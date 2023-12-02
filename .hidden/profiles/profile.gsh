#!/usr/bin/gsh
'' Defaults to be loaded into an empty system
'' Script for Shell Version 1.5 and above
'' Functions in this file or the plugin directory are loaded as
'' plugins each time the gsh starts or as needed by the shell.
'' The comment lines starting with double ' will be printed by the help
'' function. See the /usr/share/gsh/plugin directory. Or
'' your own plugins from ~/vars/plugin
'' so :
'' '' this is help
'' will be printed when detailed help is required
'' may contain as many lines as required after the Sub declaration
'' Extern, Include and Use may be declared in the body of any function
'' each is treated as a stand alone Program
'' see Sub clearhist for an example of extern
'' Dont use public that is assumed.
'' if you call a function from this file during loading then
'' it should be defined before you call it

$profile = true  ' sets this to true on the first load of the profile. only done upon first init

print "Gsh Profile Version";;$gshversion;;"Loaded"

alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'
alias home='cd ~'
alias ??='lprint'
alias ps='ps -l'
alias hh='hist(-10)'
alias path='? env["PATH"]'
alias exit='Quit 0'
alias tcb='toclipboard'
alias fcb='fromclipboard'
alias done='loop until true'
alias clearsub='clearsubs'
alias clearvar='clearvars'
alias pwd='/bin/pwd'
alias foreach()='do:;for each value as variant in &1:;&2:;next:;done'
alias ifor()='for i as integer = &1 to &2:;&3:;next'