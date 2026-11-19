#!/bin/bash
# gsh regression tests
#
#   run.sh [--record] [--dev] [pattern ...]
#
# Every test is in cases/<area>/:
#   name.gsh   a script, run as: gsh -s zqreg name.gsh  (stdin from name.in if it exists)
#   name.sh    a bash script for what a .gsh can not do (gsh -c, -r, a pty ...), $GSH runs gsh
#   name.out   the expected output (stdout and stderr), ANSI colours removed
# --record     writes name.out for the tests that have none, check it before committing it
# --dev        runs the project build (gbx3 <project> --) instead of /usr/bin/gsh, and the project's subs
#              that differ from the installed ones (put in ~/vars/subs for the run, unless a personal one exists)
# pattern      runs only the tests whose path contains it
#
# The tests run in their own shared memory segment (zqreg) but use the real ~/vars and ~/.gshrc :
# both are copied first and put back after the run, also when it is interrupted. Other gsh sessions
# should not be used during a run, what they write to ~/vars is undone.

cd "$(dirname "$(readlink -f "$0")")" || exit 2
HERE=$(pwd)
PROJECT=$(readlink -f "$HERE/../..")

RECORD=0
GSHCMD=(/usr/bin/gsh)
PATTERNS=()
for a in "$@"; do
    case "$a" in
        --record) RECORD=1 ;;
        --dev) GSHCMD=(gbx3 "$PROJECT" --) ;;
        *) PATTERNS+=("$a") ;;
    esac
done

# --- back up ~/vars and ~/.gshrc, put them back on exit -------------------------------------------
BACKUP=$(mktemp -d "${TMPDIR:-/tmp}/gsh-regression-XXXXXX")
rsync -a "$HOME/vars/" "$BACKUP/vars/" || { echo "backup of ~/vars failed, nothing run"; exit 2; }
[ -e "$HOME/.gshrc" ] && cp -a "$HOME/.gshrc" "$BACKUP/gshrc"

restore() {
    pkill -f -- "^(/usr/bin/)?gb[rx]3 .* -s zqreg" 2>/dev/null     # only the test gsh processes
    rsync -a --delete "$BACKUP/vars/" "$HOME/vars/"
    if [ -e "$BACKUP/gshrc" ]; then cp -a "$BACKUP/gshrc" "$HOME/.gshrc"; else rm -f "$HOME/.gshrc"; fi
    rm -f /dev/shm/"$USER"zqreg /dev/shm/"$USER"zqregCol
    rm -rf "$BACKUP" "$WORK"
}
trap restore EXIT
trap 'exit 130' INT TERM

WORK=$(mktemp -d "${TMPDIR:-/tmp}/gsh-regression-work-XXXXXX")
rm -f "$HOME/vars/zqreg.image"

if [ "${GSHCMD[0]}" = gbx3 ]; then          # --dev : the project's changed subs, ~/vars is put back after the run
    for f in "$PROJECT"/.hidden/subs/*; do
        n=$(basename "$f")
        [[ "$n" == *~ ]] && continue
        [ -e "$HOME/vars/subs/$n" ] && continue
        cmp -s "$f" "/usr/share/gsh/subs/$n" || cp "$f" "$HOME/vars/subs/$n"
    done
fi

export GSH="${GSHCMD[*]} -s zqreg"           # for the .sh tests
export GSHBIN="${GSHCMD[*]}"                 # without -s, for options that must come first (-u)
export WORK REGRESSION="$HERE"
unset SHAREDMEM_PRIVATE SHAREDMEM_PRIVATE_TAG

gshrun() { "${GSHCMD[@]}" -s zqreg "$@"; }

# the first start of a new segment loads the profile and prints a line about it
(cd "$WORK" && gshrun -c 'echo ready' </dev/null >/dev/null 2>&1)

clean() {      # remove colours and terminal titles, the work directory becomes <WORK>
    sed -e 's/\x1b\][^\x07]*\x07//g' -e 's/\x1b\[[0-9;?]*[A-Za-z]//g' -e 's/\r$//' -e "s#$WORK#<WORK>#g"
}

PASS=0; FAIL=0; NEW=0; FAILED=()
while IFS= read -r test; do
    rel=${test#cases/}
    if [ ${#PATTERNS[@]} -gt 0 ]; then
        keep=0
        for p in "${PATTERNS[@]}"; do [[ "$rel" == *"$p"* ]] && keep=1; done
        [ $keep = 1 ] || continue
    fi
    base=${test%.*}
    rm -rf "$WORK"/* "$WORK"/.[!.]* 2>/dev/null
    if [[ "$test" == *.gsh ]]; then
        input=/dev/null; [ -e "$base.in" ] && input="$base.in"
        actual=$(cd "$WORK" && timeout 60 "${GSHCMD[@]}" -s zqreg "$HERE/$test" <"$input" 2>&1 | clean)
    else
        actual=$(cd "$WORK" && timeout 120 bash "$HERE/$test" 2>&1 | clean)
    fi
    if [ ! -e "$base.out" ]; then
        if [ $RECORD = 1 ]; then
            printf '%s\n' "$actual" > "$base.out"
            echo "NEW   $rel"; NEW=$((NEW+1))
        else
            echo "NOOUT $rel (run with --record)"; FAIL=$((FAIL+1)); FAILED+=("$rel")
        fi
        continue
    fi
    if diff -u "$base.out" <(printf '%s\n' "$actual") > "$WORK/.diff"; then
        PASS=$((PASS+1))
    else
        echo "FAIL  $rel"; sed 's/^/      /' "$WORK/.diff" | head -40
        FAIL=$((FAIL+1)); FAILED+=("$rel")
    fi
done < <(find cases -type f \( -name '*.gsh' -o -name '*.sh' \) | sort)

echo
echo "passed $PASS, failed $FAIL, new $NEW"
[ $FAIL = 0 ]
