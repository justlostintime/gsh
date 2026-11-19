# update after a new version clears the cached subs and restarts gsh in place: same pid, same terminal.
# Its own segment, zqupd : subs typed by other tests would make clearsubs ask about them
. "$REGRESSION/pty.inc"
GSH="$GSHBIN -s zqupd"
pty_run '
key "echo PID \$\$"; pause 0.6
key "sharedmem[\"subsversion\"] = \"0.0.0\""; pause 0.6
key "update"; pause 1.5; key ""; pause 6
key "echo PID \$\$"; pause 0.6
key "print \"V=\" & (sharedmem[\"subsversion\"] <> \"0.0.0\")"; pause 0.8
' > out.txt
grep -E "^(Update gsh|Clearing|gsh then)" out.txt | sed 's/Update gsh .*/Update gsh <VERSION>/'
pids=$(grep -E "^PID [0-9]+" out.txt | awk '{print $2}' | sort -u | wc -l)
[ "$pids" = 1 ] && echo "same pid after the restart" || echo "pid changed or missing: $(grep -E '^PID' out.txt | tr '\n' ' ')"
grep -E "^V=" out.txt
rm -f "$HOME/vars/zqupd.image" /dev/shm/"$USER"zqupd /dev/shm/"$USER"zqupdCol
