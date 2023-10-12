# Profiles.gsh the default system profile

 Defaults to be loaded into an empty system
 Script for Shell Version 1.5 and above
 Functions in this file or the plugin directory are loaded as
 plugins each time the gsh starts or as needed by the shell.
 The comment lines starting with double ' will be printed by the help
 function. See the /usr/share/gsh/plugin directory. Or
 your own plugins from ~/vars/plugin
 so :
 '' this is help
 will be printed when detailed help is required
 may contain as many lines as required after the Sub declaration
 Extern, Include and Use may be declared in the body of any function
 each is treated as a stand alone Program
 see Sub clearhist for an example of extern
 Dont use public that is assumed.
 if you call a function from this file during loading then
 it should be defined before you call it