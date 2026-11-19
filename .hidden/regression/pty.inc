# helpers for the terminal tests, sourced by cases/*/*.sh
# pty_run SCRIPT : runs gsh in a terminal (script), SCRIPT is a bash snippet that types into it with
# key "text" (adds Enter), raw "text" (no Enter) and pause seconds. Prints the cleaned output.
key() { printf '%s\r' "$1"; }
raw() { printf "$1"; }
pause() { sleep "$1"; }
pty_run() {
    ( sleep 2.5; eval "$1"; key exit; sleep 1.5 ) | timeout 90 script -qfc "$GSH" /dev/null |
        sed -e 's/\x1b\][^\x07]*\x07//g' -e 's/\x1b\[[0-9;?]*[A-Za-z]//g' -e 's/\r//g'
}
# keep only the lines that matter: drop prompts and echoed input, they hold dates and paths
mask() { sed -E -e 's/[0-9]{2}\/[0-9]{2}\/[0-9]{4} [0-9:.]+/<DATE>/g' -e 's/\b[0-9]{4,7}\b/<PID>/g' -e 's/[0-9]+\.[0-9]{3}s/<SECS>s/g'; }
