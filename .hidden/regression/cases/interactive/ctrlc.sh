# Ctrl-C at the prompt drops the line; in a block it leaves the block; a running command stops;
# background jobs keep running
. "$REGRESSION/pty.inc"
pty_run '
key "!sleep 30 &"; pause 0.5
raw junk; pause 0.3; raw "\x03"; pause 0.5
key "echo after line ctrl-c"; pause 0.6
key "if true then"; pause 0.4; raw junk; pause 0.3; raw "\x03"; pause 0.6
key "echo after block ctrl-c"; pause 0.6
key "!sleep 10"; pause 1; raw "\x03"; pause 0.6
key "echo after command ctrl-c"; pause 0.6
key "!kill -0 \$! && echo \"bg running\""; pause 0.8
key "!kill \$!"; pause 0.6
' | grep -E "^(after|DoBlock|bg running)" | mask
