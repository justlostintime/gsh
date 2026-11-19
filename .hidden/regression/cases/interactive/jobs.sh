# jobs on, a background job reported while the prompt waits, jobs -list, jobs -wait, jobs removes ended jobs
. "$REGRESSION/pty.inc"
pty_run '
key "jobs on"; pause 0.4
key "!sleep 2 &"; pause 0.4
key "!sleep 3 &"; pause 0.6
key "jobs -list"; pause 1
key "jobs -wait 2"; pause 3.5
key "jobs"; pause 1
key "jobs"; pause 1
key "jobs off"; pause 0.4
' | grep -E "^ +[0-9] |Job pid|\[Complete\]|\[Running\]|No running" | mask | sort
