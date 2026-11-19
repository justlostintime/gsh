# ~/.gshrc runs when it has changed, onstart runs at the start of an interactive gsh, onexit at its end.
# The runner puts the real ~/.gshrc and ~/vars/subs back after the run
. "$REGRESSION/pty.inc"
printf '$zqrc = "gshrc ran"\n' > "$HOME/.gshrc"
printf 'Sub onstart()\n  Print "zq onstart ran"\nEnd\n' > "$HOME/vars/subs/onstart"
printf 'Sub onexit()\n  Print "zq onexit ran"\nEnd\n' > "$HOME/vars/subs/onexit"
pty_run '
key "print \$zqrc"; pause 0.6
key "vardel zqrc"; pause 0.4
' | grep -E "^(zq onstart ran|zq onexit ran|gshrc ran)"
