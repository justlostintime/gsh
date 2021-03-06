% GSH(1) gsh 1.2
% Westwood
% December 2020

# NAME
gsh -  Gambas Command Shell V1.2

# SYNOPSIS
**gsh** [*options*] [Command String | gsh-script-filename | User/Builting Function | Global Variable names]

            
# DESCRIPTION
**gsh** is a command language interpreter that executes commands from standard in, File or command line . It is based upon the **GAMBAS** language and all syntax and is derived from that language and executed by the **Gambas** interpreter. The Shell extendes the language with syntax and functions appropriate for command Shell ussage  See **GAMBAS** website http://gambas.sourceforge.net/en/main.html.
**gsh** incorporates some of the enumeration and file expansion and brace expansion from Korn and C shell.

**gsh** is not Posix compliant.

# OPTIONS
**gsh** recognizes the following as options.

**-h | --help**
: Display the help pages.

**-a | --about**
: Display information about gsh.

**-C | --cleanup**
: Force the close of the named in_memory database, if present on system.

**-c | --command**
: Used by the remote ssh or other access for Posix compliance, not used in other cases

**-D | --dictsize** [Dictionary Memory length]
: Define the amount of memory reserved for the in memory database index/dictionary defaults to 1.5MB.

**-d | --service**
: Start gsh in service mode, requests are sent via stdin/ssh remote requests to access database elements and store database elements.

**-f | --from**
: Execute the content of a global variable. The global variable may contain any gsh script.

**-i | --image**
: Load a specific image from an image file upon start. The Image can be viewed as the total environment. It is possible to have many project environments.

**-M | --memsize** [Memlength]
: Define the storage reserver for the in memory database Default  4.5MB.

**-m | --manual**
: Print the detailed extended help information

**-n | --noload**
: Do Not load the image, Its already loaded. This is used mainly if you are not using the default image. Mostly gsh will detect if the image is already loaded.

**-p | --port** [Port ID]
: Any of the following: TCP/IP port number | devicename example USBtty0 | Unix named pipe path. Used for service mode deamons.

**-r | --runline** [gsh script command]
: Execute the following command line
             
**-s | --shmname** [Name Of In-memory DataBase to Use]
: The name of the in memory database to use defaults to 'gsh&username' Two in memory files are created, data segment and collection segment Dictionary
                         
**-S | --single**
: Use a private in memory database and share only with tasks

**-v | --version**
: Display the version information
             
**-V | --version**
: Same as v - version number
  
# KEYBOARD EXPANSION AND SHORTCUTS
Keyboard input and config.GSH uses the C readline function and is very configurable please see http://man7.org/linux/man-pages/man3/readline.3.html for details of the keyboard support and configuration. The readline package must be installed for gsh to work correctly. It support command and file path completion. Both emacs and vi style editing for input lines and History is supported.
            
# HELP INTERACTIVE MODE    
**help** [command]
**command** will print a detailed description of the external/Builtin commands found in the /usr/share/gsh/subs and ~/vars/subs directory Builtins and user sub file are self documenting.                see the **Documenting plugin and user functions**

# Gambas Shell Overview
**gsh** is an in memory shell all global variables are kept in an in memory database image. Functions, Subs, Procudures, Functions, Classes, Structures are considered as global variables.           This image is saved when a new variable is created. or when the shell exits. It is reloaded when the shell is started. This in memory data base is shared by all GSH shells started by a single user. That is to say that a variable created by one instance is accessible by every other instance of the GSH running for that user. Objects, Functions and classes are part of this database. One task can update an object and have it available to another task. ETC. This Sharing can be overridden by the --single option.
            
It is possible to have a single database shared by any combination of users through the command line parameters. Or have each gsh instance have a private in memory database. Shared only by tasks.
            
# Configure gsh as your login and default shell.
First add the entry /usr/bin/gsh to the /etc/shells file this enables **gsh** to be used as a login shell. Gsh can replace your current shell by changing the default shell in your /etc/passwd file.
```
            To do this use chsh command.
            NAME
                chsh - change login shell

            SYNOPSIS
                chsh [options] [LOGIN]                     
```
# Scripting Language is GAMBAS
You may use most Gambas language and variables definitions. Regular Gambas variables will not persist between command blocks as each block of code is executed as a single Gambas script. Blocks being any code that requires a begin and end type directive.
````
for Examples: 
for ... next 
if..endif 
Do ...  While, also
Lambda .. end or Begin ... end or { ... } can used to define an unnamed block of code.
ee Code Blocks for more details.
````
Gambas Shell compiles and runs code blocks as a Gambas scripts. So you can use 'USE', 'INCLUDE', 'extern' inside each Block/function definition. All Subs/functions/procedures and Classes are automatically PUBLIC. Most of this Man Page document assumes you know GAMBAS code. You may see more at http://gambas.sourceforge.net/en/main.html. But if your familure with the BASIC programming language then only the **gsh** extentions really need your attention.
 ````
 Example  of format of user defined or BUiltin function format  
            sub ex()
              USE gb.gui,mybiz.comp 
              extern malloc(size as integer,count as integer) as pointer in "libc:6"
              Include xxx  ' these will not be embedded but placed at start of the script file.
              while x=yy
                 ......
                 ......
                 wend
             end
```` 
When a function compiles correctly. It is loaded into the shell as a plugin and may be directly executed from the command line. If the compile ..end directive or called from inside a block then the function is included as part of the compiled block script.

# Global Definitions
Global Functions and Variables once defined immeadiatly become part of the environment for all instances of **gsh**.
Global Variables start with a '$' and are translated into a memory database call. The Database is shared by all instances of **gsh**.
Global variable data types are determined by the type of data stored at runtime. The Data types may change during assignment unless a request for notification of change has been set. **See later for notification requests**. 
  
Defined Subs, Procedures, Functions, Classes, Structures and Global variables are carried from code block to block and saved as part of the gsh environment and reloaded each time gsh is started it is restored form the Global database.
  
# Configuration and Startup Files

**profile.gsh**
: is executed upon each startup and may be edited. System Defined Startup commands and the default alias definitions. This is always executed at startup.
            
**gsh.rc** 
: Is the users startup definitions and aliases etc. Updated at startup in image only when changed by user otherwise it just uses the image.
  
**onstart** 
: is read from ~/vars/subs when gsh starts in interactive mode and the user has changed it since the version in the image was defined. It defines the onstart() function called at the start of an interactive session.
  
**onstart()**
: This function is run when the Gambas shell starts in interactive mode it may be changed using 'edit onstart' any valid Gambas code may be used here.
            
**onexit**
: Is read from ~/vars/subs when gsh starts and the user has changed it since the version in the image was
            defined. It defines the onexit() function called at the end of an interactive session.
  
**onexit()**
: This function is run when the Gambas shell exits an interactive mode it may be changed using 'edit onstart' any valid Gambas code may be used here.

At Startup gsh loads the environment from the default image ~/vars/gsh.image if it is exists.  Any specific image may be loaded explicitly with the --image startup parameter
  
**gsh.image**
: This file is created/updated when ever the gsh shell exits or save is called with no parameters. It is stored at ~/vars/gsh.image. The gsh.image and ~/vars directory will be created if they do not exist upon first startup of GSH.

# Global Variables and Predefined Variables
Global variables start with $ for example $history .. Case does not matter.
These Variables are not dim'd. Data Type is assigned when vales are assigned to the variable. Global variables persist and are saved at the time of closing the gsh shell. Global variables may be used the same way regular variables are used except for iteration. for example is Not allowed: for $i = 0 to 100 but for i = 0 to $i is allowed. Global Variables can be referenced in any process or sub process of gsh. They are system wide. Remember to vardel("varname") at the end of a session if you dont want it to appear when you next start gsh.
            
 $0 to $n   This is reserved as parameters passed to a gsh script
 $#         This is the number of parameters passed tp a script
 $$	        Linux cli only Process ID of the executing script on Linux command lines(only on Linux cli lines otherwise use application.id)
 $UID       Linux cli only User Id of the executing script on UNIX command lines(only on Linux cli lines otherwise use user.id)
 $GID       Linux cli only PID of the executing script on Linux command lines(only on Linux cli lines otherwise use user.group)
 
 $result :  This reserved variable will have the returned value after each builtin function is called. This may be used by your functions to return values.
 
 $VarName = value : Global Variables Definition, The Value type sets the data type and can change except if a change notification request is pending for the global variable.
 
 $prompt :  The prompt, it is displays as 'print eval($prompt);;' so can be edited with any valid eval statement
            to change the prompt just 'edit $prompt'. The change is apparent when the editor closes. 
            Be warned if the expression fails the prompt will be reset to the default.
            The default prompt is - 
               "\x1b[31m"&user.name&"@"&system.host&":\x1b[32m]"&env["PWD"]&"$\x1b[0m]"&gsh.blockindent
 
 Traceon   Turn on or off shell script tracing. Writes line to stderr as they are executed.
 Traceoff  This Is not Global And will not affect system wide scripts.

# Shell Grammer
#Code Blocks
: Will execute independently in the order they appear in the script eg if..endif while..wend {} lambda-end ... Any Gambas block or function definition.

## Pipelines
 ! or |
: ! Is used at the beginning of a line to define an external command or force a function to be executed as a process 
                      In Many cases the shell will detect an external command. But using ! forces it to execute as a command
                      or functions as a command | may only be used between commands not at the beginning of a line
                      For example '!ls or 'ls' to list a directory.
                      !ls > $a or just ls -1 > $a  will store the returned value into the global value $a, 
                      if a local variable is used it needs to be dim'd first and
                      Will only persist during the command execution
                      This may also be used to pipe stdout to stdin of next command
                      eg  '!cat < $f ! cat ! cat ! cat > $r' or '!cat < $f | cat | cat | cat > $r'
                      This will send output from first to second command and so on
                      the ! is not needed for the first command as gsh checks the first symbol to see if its external
                      so from eg above 'cat < $f | cat | cat | cat > $r' will also work
                      Any function that reads or writes to stdin stderr or std out may be used in the pipe string
                      
                      Examples see sample function at end of help
                         cat < $f | SampleFilter() < $f | tr [a-z] [A-Z] | SampleReciever()
                         In the above case SampleFilter get input from $f and cat at the same time
                         
                         !SampleInjector | cat > $r | tr [a-z][A-Z] | SampleReceiver()
                         The ! before the function is required to force the line to be treated as a pipe fitting
                         without it the shell will pass this line to the Gambas compiler directly.
                         
                         cat < DataSource() | less
                         functions may be used as an input to a command/function as long as it returns a string
                         sub Datasource() as string
                           return "MsgHeader"&application.name
                           end
                           
                         cat < "hello" > datasink | less
                         The datasink function will be called each time data is available from cat
                         The function must receive a string as it only input parameter
                         sub datasink(data as string)
                             ...... ' process data
                             end
                             
|< |>
: These allow more that one input/output function.task to feed a command or one command to feed many tasks
                      cat |< NetConnect1() |< NetConnect2() |> netforward() | cat >> $logger >> ~/vars/netlog
                      In this example network traffic is received by cat from NetConnect 1 and 2, 
                      cat's output goes to netforward and Cat and finally into $logger
                      
## I/O Redirections
@ used in redirection :  If a file name is not clearly a file name or conflicts with a function, datatype,  or cli name then
                      adding a @ before the name forces the compiler to use what follows as a file name
                      eg. cat < "helloworld" > @"hello world"
                      will write "hello world" to a file called 'hello world' in the users current working directory
                      eg. cat < "hello world" > @hellothere
                      will write "hello world" to a file called hellothere in the users current working directory
<                   : Direct content of global variable,function or file  into external command CLI
                      It is allowed to have multiple inputs to a command
                      for example
                      eg ' cat < $f < ~/vars/profile.gsh | cat < $r | cat > $b | cat > $s' is quite valid
                      
>  >>               : Direct Output from an external command to a global variable,function or file
                      It is allowed to write the output to multiple variables and also pipe to next external command
                      eg ' cat < $f < $t > $g > ~/vars/mylog | cat < $u > toupper() | cat | cat > $z' quite valid
                      >> appends to output stream, > clears output stream first.

&>  &>>             : Direct stderr to a global variable, function or file. It is allowed to send it to many variables,funtions or files as needed
                      eg ' cc "myprog.c" < $f < $t > $g > $d &> $cerr &>> ~/vars/myerrors ! cat < $u > $s ! cat ! cat > $z' quite valid
                      &>> appends to error stream, &> clears error stream first.
                      

                      
!>                  : Assign the result code from a Linux command or process to a variable
	                  eg. ls :>$a | tr [A-Z] [a-z] :> $b | less :> $c
	                  well store the exit code of each cli into the variable specified
                      
## Lists
&&, ||, ::            : Used to control the flow of a unix CLI line eg. ls && ps || echo "failed" :: echo "do this anyway"
                        &&  is used to execute the next command if the first work correctly eg  'true && ps' will print the ps output, 'false && ps' will print nothing
                        ||  is used to execute the next command if the first one fails  eg ' true || ps ' will print no output , 'false || ps' will print ps
                        && and || are alway executed left to right and all operators are evaluated in the same way bash or sh evaluates them.
                        :: always execute the next command when the previous one completes.
&                      : Place this after the last line of your command to execute the command as an independent process

## Compound Commands
()                      may be used to manage the order of operation, inside brackets are always evaluated first.
"#{expression}"         : evaluate the expression immediately and replace text with evaluated expression
                      example "#{'print'}" application.name; "stuff"..
                      inside expressions use single quote instead of double quote
                      This example will be evaluated to 'print application.name; "stuff"..'
                      after the evaluation the line will be executed
                      example default prompt print "#{'\''&Sharedmem['$pwd']&'->'&sharedmem['$blockindent']&'\''}"
                      remember the evaluation is executed in this context, the line is executed in its own context
                      This allows to pass values from this context to the next.
                      example :  print "#{'\''&application.name'\''}"    'this will print "gsh" the context of the shell
                                 print application.name                  'this will print "execgbs" The Context of the executed block
                                 They happen in different contexts, global variables span contexts
   
@VariableName(parm1,...) the contents of the variable are executed as a gambas function and the output replaces it in the command line.

# Integrated Functions
                             
 ?                  : at the beginning of a line will print what ever follows Same as scripts.
                      For example ? $a;$b,c,d -- will print the content of these variables
                      
 
 
 { } | Lambda..end | Begin..end: are used to create a block of executable code. Gsh will execute code as it is read.
                      Also any other  block type command will start a block eg for .... next, while...do etc . 
                      example:
                      
                      {                    lambda parm1 parm2 ... this is useful in a for next loop or
                       Dim i As String        Dim i As String     as a use one function
                       i = "this\nthat"       i = "this\nthat"
                       dim j as string[]      dim j as string[]
                       j = split(j,"\n")      j = split(j,"\n")
                       $e = j                 $e = j
                       } <&>               end <&>
                       
                      You may edit and execute the last lambda expression by using edit lambda.
                      Parameters may be passed to a lambda expression using the param for Gambas ... functions
                      This is basically a syntactic trick to let the editor know your entering code that should be executed 
                      as one block. By default gsh executes each line as it is entered.
                      If used in gsh scripts { to }  execute  after the closing brace, local variables(inside {}) are lost.
                     

 
 quit               : End of execution or close gsh session.  
                      gsh shells/scripts return values in global variables

 Global Commands/Functions/Classes : These commands are built into the gambas shell
 
 Get <Command> <Command> ...  A List of additional commands  to be loaded as plugins these are complete modules having many functions
                              only the provided command name may be called from the command line.
                              Command may be a file name or filename and path
                              as a file "/usr/bin/mycommand" or CommandName which is loaded from ~/vars
                              The interface entry point is the function with the same name as command
 
 Edit class|function|variable|Lambda   Edit or create a class,function,string or string[] variable for your environment
                              starts the editor defined in the $editor global variable
                              classes and functions become part of the image and are linked to commands as needed.
                                       
                              $editor    - holds the name of the text editor to be used for texted based editing.
                              $hexeditor - holds the name of the editor to be used for binary type variables.
                                       
                              Examples:
                              sub test()   is defined then 'edit test' will allow you to change this function
                              class test2  is defined then 'edit test2' will allow you to change this
                              $h = ["ddd","dddd"]     then edit this like 'edit $h'
                              $h = "djjdjdjddj"       then edit this like 'edit $h' the shell knows the base type and
                                                      will save it in the same form
                              $h = new byte[]         when you edit $h then the hex editor will open
                                           
                                                              
 run "Scriptname"             Execute an external gsh script immediately. Scripts should return information in global variables.
                              This is a  shell script not a gambas script. See also runscript() in profile.rc this function
                              is the preferred method of executing an external scripts.
                                        
 list                         This will list the code of the last executed block or line of Gambas code.
                                        
 alias                        Alias replace a command at run time with the alias. These are defined in much the same way as 
                              Posix shell aliases.
			      As Examples these aliases are included in the default profile.gsh provided with the shell
                                 alias fgrep='fgrep --color=auto'
                                 alias grep='grep --color=auto'
                                 alias l='ls -CF'
                                 alias la='ls -A'
                                 alias ll='ls -alF'
                                 alias ls='ls --color=auto'
                                 alias cls='clear'
                                 alias home='cd ~'
                                 alias pkill='!kill'
                                 alias ps='ps -u'
                                 alias hh='hist -10'
                                 alias path='? env["PATH"]'
                                 alias exit='Quit 0'

                              Aliases must be enclosed in ' single quotes and are applied only to command lines not 
                              program code. You may not have a comment on these lines
                              to remove an alias simply assign with no content
                              Example
                                alias home= 
                               ' this will remove the home alias
                                          
 
 Compile <program name>       This will not execute the script entered but will produce an executable Gambas script.
  .....                       The script is standalone and may be executed directly from the command line. The Output
                              is placed into the ~/bin folder and marked as executable.
 end compile                  The default program name if not specified is script.out
                              In terms of functional programming. You may compile and test each function and then
                              after the final test. Create a function which is a main and compile it.
                              AS an Example:
                                           define a sub a
                                               sub a() 
                                                 ? "hello"
                                               end

                                           define a sub b
                                               sub b() 
                                                 ? "Bye"
                                               end

                                           Now test interactively each function by just entering as a command
                                             > b
                                             Bye
                                             > a
                                             Hello
                                                
                                           Now Lets create a Gambas3 script .gbs that executes these functions
                                             
                                           Compile MyScript
                                              a()
                                              print "More From The Script"
                                              b()
                                              end

                                            The script produced will be ready to execute
                                            stand alone Gambas Script gbs type.
                                            Try it by entering MyScript at the command prompt
                                            > MyScript
                                            Hello
                                            More From The Script
                                            Bye

                                                              
 @GlobalVariableName(don't include $)  This will execute the content of the variable as a program and place the text output
                              into the current program line. Sort of self modifying code. It must return a string.
                              eg. > $j = "Print \"\"hello\"\""  ' This returns "hello"
                                  > ? @j                        ' This prints hello
                              Parameters
                               $0-$n and $# This will contain all the parameters passed to the @variable call 
                               eg > $j = "Print quote($0)"
                                  > ? @j("hello")               ' This prints hello
 
 Sub,Function,Procedure,Class,Struct  Each are compiled immediately after creation. If used as a command then they are executed
                              in the context of the current shell they are loaded as plugins to the shell.
                              If used as functions then they execute in the context of the block or app executed.
                              functions and classes may be edited with the edit command.
                                       
                                       
*************************************************************************************************

Sample function for pipe fitting see /usr/share/gsh/examples

*************************************************************************************************
# HISTORY

#HISTORY EXPANSION 

## EVENT DESIGNATORS
  
 n!                            : Will execute the command block starting at n          : 3!\
 -n!                           : Will execute the command block starting at minus n    : -3!\
 [0]findpattern/replacepattern : Allows to edit the history lines regular expression regex.replace()\
 
# SEE ALSO


# FILES


# AUTHORS
Ercoupflyer 2019-2020

# BUGS
Absolutly

# COPYRIGHT
GNU GENERAL LICENSE 2
