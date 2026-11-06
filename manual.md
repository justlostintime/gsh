# Gambas Shell gsh

Version 1.6.3.8

**June 4, 2025**

## Introduction

Gambas Shell(**gsh**) is a general purpose command line interpreter that
executes commands entered from the standard input or from a file much
like bash or sh. It can be used for interactive terminal sessions or job
control. The major difference is in the use of the complete Gambas3
Basic syntax with a few exceptions that were required to try to add some
Posix compliance. One of the important features is the ability to share
and synchronize data between running processes and to store the state
and environment between invocations. **gsh** simplifies shell script
development with the simple yet powerful and consistent syntax provided
by the Gambas3 language.

**Gsh** is not a Posix compliant shell. Of course it can be used to run
Posix compliant scripts through the command line. But natively gsh uses
Gambas3 syntax and constructs.

For Gambas users - **gsh** required Gambas 3.18.0 or greater be
installed as its base Gambas3 . **gsh** requires a few Gambas3 modules
**gambas3-runtime**, **gambas3-eval-highlight.**,
**gambas3-dev-tools**,**gambas3-westwood-sharedmem**,**gambas3-westwood-gb-scripter**

Some of the notable extensions to Gambas3 syntax is the linux cli app
interface which, on top of the expected forms of redirection, allows
data to be redirected to and from user defined Gambas3 variables and
functions. Gambas-user-defined subroutines and functions may be the
target of piped input or output.

An in-memory database is utilized throughout the shell to store
persistent values and uses the dollar sign variable name(\$varname)
notation throughout scripts and interactive sessions. This is important
to understand as gsh compiles and executes blocks of code as they are
completed from the command line or read from a gsh script file. Only
global variables persist between code blocks.

Code blocks are defined as any statement or statements containing Gambas
syntax blocks as examples for-next, if-endif etc. A single line is also
considered a complete code block for execution.

To allow more complex command sequences to be entered for one time, use
lambda-end, Begin-end or {} may be used to create a lambda expression
notation which been added to the valid gsh or alternatively wrap the code in a 
```
    do ... done(alias for loop)
```
script syntax. This is explained in later chapters.

The remainder of this document attempts to describe the Gambas shell
command line interface and general usage.

The development of this shell started as a test program and a fun
project for the in-memory database development and sort of just grew. I
enjoy using it now in day-to-day operations at work and home. Enjoy!

Gambas shell (gsh) 1.4.2 now supports and extended set of Gambas3 syntax and byte code
integrating the Linux CLI into the Scripting syntax.

You can find Gambas syntax at:

<http://gambaswiki.org/wiki>

The Shell extensions are explained in this document, but the reader is
directed to the wiki for gambas3 syntax. But if the reader is familiar
with good old Basic syntax then the usage should not be too difficult.

## Requirements

Gsh has a few important requirements.

Gambas3 version 3.18.0 or greater

### Gambas3 Modules used
\- gambas3-runtime \>= 3.18\
\- gambas3-dev \>= 3.18
\- gambas3-gb-signal \>= 3.18\
\- gambas3-gb-pcre \>= 3.18\
\- gambas3-gb-highlight \>= 3.19\
\- gambas3-gb-eval \>= 3.19\
\- gambas3-gb-args \>= 3.18\
\- gambas3-westwood-sharedmem \>= 3.19 included in project\
\- gambas3-westwood-gb-scripter \>= 3.18 included in project\
\- gambas3-gb.compress \>= 3.18\
\- gambas3-gb.debug \>= 3.18\
\- gambas3-gb-image \>= 3.18\
\- gambas3-gb.net \>=3.18\
\- gambas3-gb.net.curl \>=3.18\
\- gambas3-gb.net.smtp \>=3.18\
\- gambas3-gb.term \>=3.18\
\- gambas3-gb.util \>=3.18\
\- gambas3-gb.util.web \>=3.18\
\- gambas3-gb.xml \>=3.18\

### C and Gambas3 Libs used

**libreadline7** or greater version depending on your OS GNU readline and history libraries\
**Libc6** or greater\
**Libpthread-2.27** or greater\
**gb.westwood-sharedmem** Component now included as par of GSH its self\
**gb.scripter** Component now included as part of gsh it's self

Optionally the fortune app can be installed as the onstart() default
startup will try to run it....
Optionally the Nerd fonts to enable cool shell prompt.

If you want to improve the speed of your scripts then gcc should also be installed to enable
the gambas3 jit to be used at runtime with caching of scripts.

The first start of **gsh** after a new SharedMem library is installed takes about a minute,
the jit compiles the library once. Later starts are fast.

From here:
```
sudo apt install fortune
sudo apt install gcc
```
## Installation
### update 06/04/2025
Gambas has now moved all installation media to the opensuse build service. Please refer to the Gambas3 wiki for details. click link below for details:
[Installing Gambas3 binary from opensuse build service](https://gambaswiki.org/wiki/doc/packages?nh)

#### Update
The SharedMem and Scripter libraries are now included in the Distribution package and do not need to be installed separately.

### Raspberry Pi Gambas3 versions
Gambas 3.18 is now available as a backport for debian and ubuntu, even available for Raspberry OS!
Here is how to do this:
```
for Raspberry Pi OS 64Bit Add this line to the beginning of /etc/apt/sources.list

deb http://deb.debian.org/debian/ bullseye-backports main contrib non-free

Then for all versions of deb/pi/ubuntu
    sudo apt update
    apt -t bullseye-backports install gambas3
```

### Update - Ubuntu/Debian/RaspberryPi OS binary installation packages for GSH are available to add to apt source list
In the future this will be the preferred way of installing binary images. The gshInstall App is depreciated.

### Installing the GSH gambas shell from binary is available as follows
```
curl -s --compressed "https://raw.githubusercontent.com/justlostintime/ppa/main/ubuntu/KEY.gpg" | sudo apt-key add -
sudo curl -s --compressed -o /etc/apt/sources.list.d/gsh.list "https://raw.githubusercontent.com/justlostintime/ppa/main/ubuntu/gsh.list"
sudo apt update
sudo apt install gsh
```
But of course you can always download and build your own packages.

### Making gsh your default shell

To make gsh shell available as a login shell.

```
   sudo vi /etc/shells
```

You must append this line to the end of the file

```
   /usr/bin/gsh
```

Then you may change the user's default shell in the **passwd** file or
through the tool provided by your distro. Most distros include the
'chsh' command so the following command line should work

```
   sudo chsh -s /usr/bin/gsh UserName
```

## Quick Overview

### Getting Started

Download and install gsh. The project is available from the GambasShell
github repository. See previous section for instructions.

Once installed you may change your default shell in your login
configuration file. Do this only after you play with gsh for a while and
are familiar with its interface and scripts.

Gsh uses two directories: \~/vars where all the files are stored, and
\~/bin where created/compiled Gambas3 executable scripts are stored by
default. On first startup of the gsh it will create these directories if
they don't exist.

A copy of the default profile called profile.gsh will be copied into the
\~/vars directory and loaded into and executed by gsh. This file defines
most of the shell default aliases. Gsh loads internal commands on demand
from \~/vars/subs then /usr/share/gsh/subs if no user system version is found.
These commands are loaded as plugins after being compiled.
The user can override these system commands by creating a function of
the same name in \~/vars/subs. Gsh searches user then system directories
for the commands.

Three files will be created by the startup. These are:

**\~/vars/gsh.image** -- this is the default image used by the shell and
will be updated as variables, functions and classes are added, as well
as when gsh exits. This is the environment used by gsh on all future
startups. The state of all global objects are stored here.

**/dev/shm/<User Name>gsh** -- this is the storage area for the in-memory
database strings, arrays and objects.

**/dev/shm/<User Name>gshCol** -- this is the Index/Storage area used to
store simple variables and storage pointers.

These files are shared by all instances of the gsh shell for a single
user, and may be used to communicate between tasks. It is possible to
specify a different shared memory databases at gsh start.

It is also possible to use a private instance of the in-memory database
shared only by tasks started by the current gsh shell.

When the gsh shell enters interactive mode, the onstart() function is
executed. Commands and variables may be set here that are required by
interactive sessions. The default startup tries to run
**fortune**...lol

The default onstart() function is defined in the \~/vars/subs/onstart
script or defaults to the system copy.

When in interactive mode onexit() function is executed just before the
shell exits. Cleanup and other user-defined commands may be placed here.

The default onexit() function is defined in the \~/vars/subs/onexit
script or defaults to the system copy.

Almost all editable functions and variables may be edited with the built
in **edit** command.

One of the most important commands is **lsubs,** which will lists the
loaded plugins/command scripts and the version of that command being
used -- system/user/in-mem. The gsh image is saved and loaded at each
gsh invocation. Variables and subs are not stored to individual files
unless explicitly directed by the user, everything remains in the image
only. Savesubs is used to save a function/sub to disk. On the other hand
everything created in an image is persistent unless it is explicitly
deleted. This is by default. It is possible to override this behavior by
invoking the gsh with the single option. In this case the image only
persists while being used and is gone when the process running gsh
exits.

### Help System - Gambas/Gsh/Linux CLI combined

**help** -- basically displays a summary of this document and function
description from each of the gsh function containing descriptions,
followed by all valid gambas searchable keywords.

or

**help \<command name\>** - command name will print a more detailed
description of any gambas3 keyword or of any gsh/gambas/linux cli function/variable/command.

Information is displayed like a Linux man page.

If more than one match is found the user is prompted to enter the number
next to the correct selection.

#### Example Help session
```
> Help var

Please select Choice using number
0) CVariant
1) Local Variable Declaration
2) VarPtr
3) Variable
4) Variable Declaration
5) Variant[]
6) lvars
7) runvar
8) vardel
9) varrd
10) varread
11) varstat
12) varwr
13) varwrite

  > 2
```
Output is display as a full text screen as follows:

***Help result is output using cli command less in the same format as
man pages:***

NAME\
VarPtr\
Pointer = VarPtr ( Variable )\
Returns a pointer that points at the Variable contents in memory.\
\* Variable must be a local variable, or a global variable of the
current class.\
\* The datatype of the variable must be a number, a date, or a pointer.\
\* It can be a string only for global variables. In that case, the
returned pointer is not the address of the string contents, but the
address of a pointer that points at the string contents.\
Since 3.15\
\* Variable can be a Variant too. But beware, the returned pointer is
guaranteed to be valid until the datatype of the variant changes.\
Use this function when an extern function argument is a pointer to a
numeric variable. For example, int \*, or void \*\*.\
Do not use it to deal with char \*\*, because the contents of a Gambas
string variable is read-only.\
\
See also\
\* External_Function_Management

### Documenting Built-Ins/Subs/Plugins

The documentation for each built-in command and user function is located
inside the script file for that function. The help system reads these lines:

- The Sub line and every line starting with ''' make up the SYNOPSIS. They
  are also the entry shown in the help summary list. Every sub should have at
  least one ''' line.
- Lines starting with '' make up the DESCRIPTION.
- Lines starting with '''' are listed under SEE, for related commands.
```
Sub mysub(...) As Variant
''' One line summary, shown in the help summary list
''' a second ''' line continues the summary
'' Full description of the sub
'' more details
'' more etc.........
'''' othersub
.....
End
```
example:

```
Sub jobs(...) As Variant
''' Job Control - list of current BG jobs
'''               or turn job control on or off
''jobs <pid|on|off> prints a list of current background jobs
''          Or turns job control ON or OFF
''
''          This lists all the jobs currently running for a user
''          The list includes every instance of a task started by gsh for a user
''          The default is all user tasks or a pid can be provided for specific task
''          The parameters:
''                  -ON for turning on job control
''                  -OFF for turning off job control
''                  -Keep Keep information after reporting
....
End
```
### Stopping a Sub with Ctrl-C (system_break)

Every sub gsh compiles has a public Boolean called **system_break**. gsh sets
it to False when the sub starts, and to True when Ctrl-C is pressed while the
sub runs. A sub with a long or endless loop must check system_break and return
when it is set.

The loop must also call Wait, because Ctrl-C only reaches gsh during a Wait. A
loop that never waits can not be told about Ctrl-C.
```
Sub mywatch()
''' Print the time every second until Ctrl-C
  While Not system_break
    Print Format(Now, "hh:nn:ss")
    Wait 1
  Wend
  Print "stopped"
End
```
If a sub does not check system_break and is still running, a second Ctrl-C
stops it with a Terminated error. A sub compiled with Fast (JIT) is the
exception: an error raised through JIT code would crash gsh, so a Fast sub is
only told through system_break and must check it to be stopped.

### Overview of Interactive and Script Syntax

All Gambas3 syntax and variable types are available with Linux cli
extensions.

Regular Gambas variables will not persist between command blocks. Only
global variables persist between blocks and are identified by a starting
\$. Global variables are created and data type is set by the value
assigned to it. Data types may change dynamically during execution.
There is one exception to this rule in the case where a process has
asked to be notified of the change in value of a variable In this case
the data type is fixed until the variable is deleted.

To delete a global variable use:

**vardel variablename** , ... , ...   (the name without the \$)

A script stops at its first gsh error and gsh exits with code 1. The
subs the script defined are freed and the shell exits normally. A gsh
error is a line gsh cannot read, a compile error, or a Gambas run time
error. A command that only returns a non zero exit code does not stop
the script, its exit code is in \$?. An error in a job run in the
background with & does not stop it either.
```
  ls nnnnvvvv          ' ls fails, the script goes on
  print 1/0            ' Division by zero, the script stops here, exit code 1
  print "not printed"
```

**gsh** compiles and runs code blocks as a Gambas3 scripts unless the
function or command has been compiled and loaded as a plugin. This
happens automatically the first time a function compiles without error.

**USE**, **INCLUDE** and **EXTERN** may be used in each function
definition. Unlike Gambas programs where they must be at the beginning
of the file.

All Subs and Classes are automatically **PUBLIC** and defined as global.

Example Sub or Command definition
```
  sub ex(parm1 as variant) as variant
    USE gb.gui,mybiz.comp
    extern malloc(size as integer, count as integer) as pointer in "libc:6"
    Include xxx
    while x=Something
         print x
         ...
    wend
  end
```
**gsh** takes care of creating and compiling the Gambas script
correctly.

When a function or class compiles correctly, it is loaded into the shell
as a plugin and may be directly executed from the command line in the
context of the shell with access to all classes, etc. If changes are
made to the function after the plugin is loaded then the plugin is
ignored and the new version is executed as a script. Gambas can not
unload a plugin so the changes are not internal to the shell until the
next start of gsh. So if you change a builtin command, you must
clearsubs exit gsh and restart gsh to have them run correctly in the
context of the shell.

You may use a lambda expression as the syntax of a single simple multi
line function. This allows the definition of local variables, etc within
a script section. More on lambda later. Remember that script lines or
blocks i.e. (such as **for-next** or **while**-**wend** structure or any
Gambas language component with a **begin** -- **end** structure) are
executed as they are encountered in a script. They are each essentially
treated as a separate module with a main function in Gambas terms.

For example A lambda expression is defined as:
```
  lambda ' or '{' or Begin
    dim a as string
    a = "hello world"
    print a
  end ' or }
```
A simpler way without lambda expressions would be:
```
  do
    dim a as string
    a = "hello world"
    print a
  done  ' this is a gsh alias for  loop until true more on aliases later
```
Gambas variable are not accessible outside of a block. The above lambda
function or do ..done may also be expressed using global variables as follows. But
remember that global variables are just that, available to every copy of
gsh running for the current user upon creation unless gsh is started with the -S or --Single option.

```
  $a = "Hello World"
  ? $a                     ' ? is synonymous for print
```

This may not seem clear but writing a script full of individual lines is
not the most efficient thing in the world.

For example, writing the following is quite inefficient because it
executes each line as an individual block. Which translates to executing an 
individual gambas3 script for each line.
```
  $a = 24
  print $a
  $b = $a
  print $b
```

This is better written as one block of code as follows, since it is
executed as a single block of code. And a single gambas3 script.
```
  Begin           ' creates a lambda function
    $a = 24
    print $a
    $b = $a
    print $b
  end
or
  Do             ' simple code block
    $a = 24
    print $a
    $b = $a
    print $b
  done
```
Because each line is its own program, a declaration on a line by itself
is gone before the next line runs. This is the same in a script as when
typing at the prompt. A top level Dim shows a message, and a top level
Public or Private variable is not seen by the following lines. Use a
global $name, put the lines in a Begin or Do block, or write the code
as a Class with the Public variables inside it:
```
  Class counter
    Public Total As Integer
    Public Sub Add(n As Integer)
      Total += n
    End
  End Class

  Begin
    Dim c As New counter
    c.Add(2)
    c.Add(3)
    Print "total="; c.Total      ' prints total=5
  End
```
**Note**:If you make an error entering the code you can edit the whole block by simply entering:
```
  edit     ' with no parameters allows to change the last block of code entered
```
### gsh Command Line Parameters
```
  -h --help Display the help pages 
  -a --about Displays information about gsh
  -C --cleanup Forces the close of the in-memory database then reopen.
  -c --command Used by the remote ssh or other access for Posix compliance, not used in other cases.
  -d --service Runs Shell as a service point
  -D --dictsize Defines the size of the space reserved for the in memory database dictionary.
      The default size is 2.5m.
  -f --from Executes the content of a global variable. 
       The global variable may contain any gsh script
       gsh -f name -- args, the arguments after -- are passed to the script.
  -h --help Gets this information.
  -i --image Loads a specific image from an image file upon start. 
       The Image can be viewed as the total environment. 
       It is possible to have many project environments saved.
  -M --memsize Defines the starting allocated variable memory size for in
       memory database. Defaults to 20.5m.
  -m --manual Prints the detailed extended help information.
  -n --noload Does Not load the image, Its already loaded. 
       This is used mainly if you are not using the default image.
       Mostly gsh will detect if the image is already loaded.
  -r --runline Executes the following command line.
       gsh -r name -- args, the name of the sub is followed by -- and then
       its arguments. A sub in a pipe is run this way.
  -s --shmname The name of the in memory database to use.
       Defaults to username. Two in-memory files are created, data segment and 
       Index/Collection segment
  -S --single Do Not Use Shared Memory, Only Shared with tasks/threads.
  -t --trace Turns on tracing in scripts.
  -V --version Displays the version number.
  -v --version Displays the version information as gsh starts.
  -- Ends the gsh options. Everything after it is passed to the -r sub or
       the -f script, so arguments such as -x are not read as gsh options:
       gsh -r mysub -- -x --color=auto
```
## Keyboard Input and Configuration

gsh uses the C readline and history functions, and it is very
configurable. For details on keyboard support and configuration, please
see:

<http://man7.org/linux/man-pages/man3/readline.3.html>

The readline7 or greater package must be installed for gsh to work
correctly.
To copy and paste examples from this document add the following lines to your .inputrc . then restart gsh
```
set horizontal-scroll-mode on
set enable-bracketed-paste off
```

The shell will run with readline 5 or 6 library but it does not pass the
signals to the shell program. This causes the about ctrl-c to fail and
other control sequences to fail as well.

## Current Working Directory

Every process has its own working directory, kept in its environment
variable PWD. \$pwd is that variable: reading \$pwd gives env["PWD"] of
the process, setting it changes the directory of that process and sets
PWD and OLDPWD. Nothing is stored in the shared memory, so each **gsh**
session has its own directory and a program started by **gsh** begins in
the directory of the session that started it.

Use cd to change the directory of the shell. A script line that sets
\$pwd runs in its own program and changes only that program, as a
subshell does in bash. Inside a begin..end block, \$pwd = "/usr" changes the
directory for the rest of the block.
```
  cd /tmp
  ? $pwd                      ' prints /tmp
  begin
    $pwd = "/usr"
    ls -d share               ' runs in /usr
    $pwd = "lib"              ' relative to the current directory, now /usr/lib
  end
  ? $pwd                      ' still /tmp, the block changed only its own directory
```
The shell changes to PWD before each command, so cli commands, which use
the process directory, and Gambas code, which uses env["PWD"], agree.

## File and Path Name Expansion for Linux Cli Commands

The shell uses the glob library call to create all file expansion lists.
It then takes the paths returned and turns them into absolute paths
before passing them to a CLI or internal function running as a task.

For example: `ls /*/*/gsh/subs` would be expanded by the shell to
`/usr/share/gsh/subs` before being passed to ls.

Another example would be to echo /\*. This would echo a directory
listing of the root directory:
```
  echo /*
```
outputs:
```
/bin/ /boot/ /cdrom/ /core /dev/ /etc/ /home/ /initrd.img
/initrd.img.old /lib/ /lib32/ /lib64/ /libx32/ /lost+found/ /media/
/mnt/ /oldhome/ /oldSrvToo/ /opt/ /proc/ /root/ /run/ /sbin/ /srv/
/srvToo/ /sys/ /tmp/ /usr/ /var/ /vmlinuz /vmlinuz.old
```
`echo **/*` would recurse through all directories if `$globstar=true`

Bash Brace Expansion is also supported:
```
  echo $"0..100"        ' will print 0 to 100
  touch $"tm{0..10}"    ' will touch files tm0 ... tm10
  for each i as integer in $"1..10"
     print i;;
  next
  for each s as string in $"tm{0..10}"
    rm {s}              ' delete the files created by touch
  next
```
## First Scripts: Examples

The following is a simple example script. It attempts to include most of
the syntax elements and may be entered from the interactive terminal.
Follow the examples by entering them into the interactive shell. As you
progress, it is hoped you will get a reasonably good feel for the gsh
scripts and implementation.

### Let's Print "hello world"
```
  ? "hello world"  '  Gambas3 supports the use of ? to print a value.
Outputs:
  Hello world
  > _
```
We may also do the same thing using the Linux **echo** command.

Try the following as well.
```
  echo hello world
```
Furthermore, gsh allows the embedding of Linux commands into your
script. Here is an example of that.

### Let's Print "hello world" Five Time in Basics and Five Times with CLI Command
```
 for I as integer = 0 to 5
    ? "hello world";;i         ' internal Gambas print
    echo  Hello World  {i}     ' print with shell command notice how gambas variables are passed in {}
    next                       ' notice the auto indent when typing this
```
This will display "hello world" ten times, 5 times from each command. If
you made a mistake just type edit on the command line by it's self and
make your changes, save the file. The block will be executed as soon as
you leave the editor. We will talk about editing in the next section.

Right now you can also use the up and down arrow to move back and forth
through the history and correct the error.

You may have noticed that the shell auto indents the code at the
beginning of each line depending on the depth of nested blocks.

You will notice the ability to use both Linux commands and Gambas3
commands in the same script.

This is one of the most important additions to the Gambas syntax.

It should be noted that, if you're using a Linux command, it must be the
first thing on the line.

### Let's Look at History

You may recall lines and execute them from history by using the
```
  20!              ' <HistoryLinenumber!>  expression.
```
Enter:
```
  hist             ' which displays the entire history
or
  hh               ' an alias which displays the last 10 entries
```
This will display a list of everything we have entered so far

Look at the listing and find the line containing the start of the
**for** loop. The output should look something like this:
```
  hh
   [ 2]for I as integer = 0 to 10 
   [ 3]  ? "hello world";;i
   [ 4]  echo echoing hello world {i}
   [ 5]  next
```
Now enter the history number containing the **for** keyword followed by
an !
```
  2!
```
You should see "hello world" ten more times.

If you made an error when entering you can use the edit history
expression to change and rerun it.

Let's change "hello world" to "goodbye world."
```
  [3]hello/goodbye/            'This will change the "hello" to "goodbye"
                                  using regular expressions and syntax
```
```
   hh    'We can see the change.
```

Let's run it again.
```
  2!
```
It prints "goodbye world" 5 times and "hello world" 5 times.

### Let's Define a Function/Sub/Procedure

All functions/sub/procedures are public so don't use public keyword.

Type the following:
```
  Sub mytest(msg as string) as string
    return upper(msg) & "one more"
   end
```
Again you will notice that the shell auto indents as you're typing the
function.

Don't forget the end!

Let's run our new function.
```
   ? mytest("this is a message")  'This will print the message in upper case to the console
```

### Let's Write a Simple Gambas Short Program Interactively

Improper script code:
```
   dim a as string = "this"       ' This will run but variable 'a' goes away
                                  ' as soon as the line executes.
   'The line was executed immediately after the <Enter> was pressed.
   ? a                            ' This will print an error. It dumps the compiled script with an
                                  ' unknown variable error.
```
To clear the screen buffer, enter:
```
   clear                          'This will clear the screen.
' or
   cls                            'This is an alias to for "clear" to clear the screen.
```

Let's use a lambda expression and a code block as an examples. 
You may use begin .. end or { ... } rather than lambda but
they are the same. It is possible to pass parameters into a lambda
expression. Have a look at the lambda section of this document.

### defining lambda functions 3 possible notations
```
lambda                            '  begin                            {
  dim a as string = "this"        '    dim a as string = "this"         dim a as string = "this"
  ? a                             '    ? a                              ? a
  end                             '    end                              }
```
### Defining a gambas code block
```
do
  dim a as string = "this"
  ? a 
  done   ' alias for loop until true
```
Any of these will print the value of 'a' correctly.

We can add a call to our mytest in the lambda function or code block by editing it.

### Let's Look at the edit Command
```
  > ? $editor      'This prints the editor defined as the default text editor.
  nano
```
You can change it now changing by setting the global variable \$editor
to your favorite editor.
```
  $editor = "/bin/nano"   ' I am just setting it to the default again.
  edit lambda  ' edits the last logical code block using nano.
  edit         ' same as above
```
In the editor we can change the code:
```
  ? a   ' line to read ? mytest(a)
```
Save the file to the provided file name and it will execute as soon as you save it. You may only
edit the most recent lambda expression or logical code block.

Let's change our mytest function to do something else.
```
   edit mytest
```
Change the return line to
``` 
   return upper(msg) & "one more".
```
Save it. It will compile but not run the function.

Enter:
```
   ? mytest("this")        ' You should see 'THIS one more'
                           ' printed to the console.
```

### Summary of What We Learned So Far

So far we have learned that subroutines, functions and procedures become
global as soon as they are created and persist in the environment. These
sub routines become immediately available to all other running gsh
sessions upon creation.

You can see what's loaded by executing the **lsubs** command.

We have also learned that each script line is executed as soon as the
section of code is completed. And we learned that the lambda expression
allows us to group Gambas code into related block for execution.

### Let's Look at the Shell Interface to Linux Commands

To run a Linux CLI command, just enter it on the command line.

For example:
```
   ls -l
```
This will produce the usual directory listing.

**gsh** looks for executable in the following order:

Gambas keywords Execute the line as gambas code.

Check statements in the following order:\
```
  Defined user functions 
  Gambas functions 
  Gambas statements
  Linux Commands(cli)
```

If there is a keyword or function with the same name as a linux cli
command then you can force the command to be evaluated as a linux cli by
adding a ! to the beginning of the line.

For example:
```
   chmod env["PWD"] &/ "filename" to "rw-rw-rw-"    ' Gambas Chmod, it needs the full path
   chmod 777 filename
```
Both have the same name but executing the second line will give you an
error regarding 'to' being missing. So to execute the cli use ! as
follows
```
  > !chmod 777 filename
```
This will execute as expected.

The same applies to commands such as true, false, mkdir, kill and date.
When a line like this fails to compile, gsh prints a hint after the
error, for example:
```
  > false
  MMain.module:22:7: error: This expression cannot be a statement
  false is a Gambas keyword or function, so the line was compiled as Gambas code, put a ! in front, !false, to run the command
```

Commands with the same name as a Gambas class, such as env, file and stat,
also need a leading !. Put quotes around parameters that contain an = or
spaces:
```
  > !env "FOO=1" printenv FOO      ' prints 1
  > !env "FOO=a b" printenv FOO    ' prints a b
  > !file "all.txt"
  > !stat -c %n "all.txt"
```

A sub or plugin at the start of a cli style line, one with pipes or
redirection, is run as a command. Write it with a leading ! and its
arguments separated by spaces, like any other command, not as a function
call:
```
   !lprint "one" "two" | tr a-z A-Z      ' prints ONE and TWO
   !lprint("one", "two") | tr a-z A-Z    ' error: A sub in a sh style line is run as a command
```

In most cases the **gsh** shell will make the correct choice. Passing
parameters from Gambas variables to Linux commands is a little more
complicated than just putting them onto the command line. you must surround
them in braces for example:
```
   echo {myvar}
```
If you want the content evaluated you must us braces and brackets
```
   echo {(myvar + 5)}    ' more on this later
```
Because braces always mean substitution, an empty `{}` is an error. Commands
that use `{}` as a literal placeholder, such as `find -exec` and `xargs -I`,
need it quoted. The `;` that ends `-exec` needs no escape in **gsh**:
```
   find . -name "*.txt" -exec ls -l "{}" ;
   ls | xargs -I "{}" echo file "{}"
```
As in Gambas, `'` starts a comment, and a `'` at the start of a word comments
out the rest of a cli line. A word that contains `'`, such as `it's`, is an
error and must be quoted:
```
   echo "it's here"      ' prints: it's here
   echo it's here        ' error: A word containing ' must be quoted
```


### Let's Look at Aliases and Alias Substitution

Alias substitution is performed on the line before being passed to the
shell parser. "ls" has an alias defined in the profile.gsh file.

Let's look at the aliases currently defined as default aliases in the
profile.gsh file.

Enter the following command:
```
   alias
```

You should see a list of current aliases. 
You may create or delete aliases using the **alias** command.

For example:
```
   alias hello='? "hello world"'
```
Notice the single quote around the definition. This is required.\
Enter:
```
   alias
```
You should see our new alias listed.\
Now enter:
```
  > hello
```
We should see "hello world" printed. Now let's delete our alias.
```
   alias hello=
```
This deleted the definition; we can list them again and see that it's
gone.
```
   alias
```
Changing an alias is simple process of redefining it.

### Let's Look at Global Variables

Global variables persist across command blocks, restarting **gsh**, and
are available to tasks and processes using the same in-memory database.
By default all invocation of **gsh** by a user accesses the same in
memory database.

By convention a \$ starts a global variable and is seen by the
pre-processor and converted to database access. So be careful how you
use the \$. Global data types are defined at creation according to the
type of data assigned to them. These are dynamically typed and may be changes
except when a process has asked to be notified if the variable changes.

Enter at the  >  prompt:
```
  $a = "this is a string"    ' This will work well.
  ? $a                       ' This will print $a.
  $a = 2                     ' This works, $a is now a number.
  ? $a                       ' Prints 2.
  vardel a                   ' This deletes the variable, give the name without the $.
  $a = "This string"         ' Defines it as a string.
  ? mytest($a)               ' Prints the string in upper case and 'one more.'
```
And setenv sets a linux environment variable for the commands run after it:
```
  setenv myvalue this       ' or setenv("myvalue", "this")
  printenv myvalue          ' prints this
```
Each line runs as its own program, so `env["myvalue"] = "this"` only lasts
until the end of that line or block. `? env["myvalue"]` reads a value.
### Let's Look at Input and Output Redirection

There are several forms of output redirection.

There are the standard Linux shell redirection constructors:
```
   cat < myfilename                   ' input from a file
   cat << EOF                         ' Input the lines that follow, up to the line EOF.
                                      '   The case of the text is ignored, see << below.
   cat <<< "This is the text string"  ' Input the text string to command stdin
   echo "this" > myfile               ' Output to a file, Enclose name in quotes of 
                                      '   contains special characters
   echo "this" >> myfile              ' Append the output to the file

```

This is how you direct the output of a linux cli command to a global
variable.(stdout)

Enter at the > prompt:
```
  ls > $a            ' save the listing to a Shell variable
  ? $a              ' Displays the listing.
```
This is how you add the output from a cli command to the end of a global
variable

value (concatenated from stdout)
```
  ls /etc >> $a           ' add etc to variable
  ? $a                    ' Displays the combined listing.
```
This is how to pass data from a global variable into a linux cli
command(stdin from $a).
```
   cat < $a               ' update this now passes the content as the name of a file to open
   cat <<< $a             ' Displays the listing again, update now uses <<< to pass the actual content.
```
This is how you capture the error output from a linux cli command into a
global variable(stderr).
```
  ls nnnnvvvv &> $b         ' $b now contains the error file not found.
  ? $b                      ' Prints the error message.
```
This is how to redirect output from stderr to a variable(concatenated).
```
  ls nnnnvvvv &>> $b        ' $b now contains the error file not found.
  ? $b                      ' Will display both errors.
```
The sh forms 2> and 2>> do the same as &> and &>>, and 2>&1 sends stderr to
where stdout goes, see 2> 2>> 2>&1 sh Style Error Redirection below.
Now let's define a data sink function to receive data.
```
  sub echodata(data as string)
    print data;
    flush
    end
```
Let's use this to display the output from ls ..., just a simple
example.
```
  ls > echodata                  ' You should see the listing output like normal.
```
Let's define a null output function.
```
  sub devnull(data as string)
     ' do nothing with the data
     end
  ls > devnull                   ' This will do nothing and throw away the data
```
Let's define a data source function.
```
  sub datasource() as string
    return "this is a message\nto\nbe\nprinted\nto\nthe\nterminal\n"
    end
  cat <<< datasource     ' This will print the data source data to the terminal
```
  Note: `<` always reads from a file, `<<<` passes a string, so the output of a
  function is sent to a command with `<<<`.
  What if we want to pass data to the source function then you must use the {( )}
  But this is a simple example, you can send any data to a cli you want..
  A sub can only be defined once, use edit to change it, so this one has a new name.
``` 
 sub moredata(...) as string
    dim ExtraData as string[] = param.all
    return "this is a message\nto\nbe\nprinted\nto\nthe\nterminal\n" & ExtraData.join("\n")
    end

  cat <<< {(moredata("this", "is", "also", "data"))}       ' This will print the data source data to the terminal
```
Let's use our functions to send and receive data thru cat.
```
  cat <<< datasource > echodata   ' This should display the source data to the terminal
```
Let's define a filter function that changes data as it is passed
through.
```
  sub filterdata(data as string) as string
    print upper(data)
    end
  ls > filterdata       ' This should display everything in upper case
```
Let's save the output to multiple variables.
```
  ls > $a > $b >> $c ' This will place the data into all of
                     ' the variables and add it to the last
  ? $a, $b, $c       ' This should display the data three times
```
Let's send multiple data sources to the command.
```
  cat <<< $a <<< $b <<< $c <<< datasource    ' NOTE: Updated as <<< is now used to pass variable content as string
                                             ' Again it should display the
                                             ' data three times, and our source
```
Let's define a fileread function to source filedata.
```
   sub filesource(filename as string) as string
     dim data as string
     data = file.load(filename)
     return data
     end

  '  display file in uppercase you could of course just input the file
   cat > filterdata <<< {(filesource(user.home &/ "/vars/profile.gsh"))}
```
### Let's Look at Pipes

Pipes allow data to be sent from process to process or many processes.

Let's do a simple pipe USING \|.
```
  ls | less                    ' We should see a list of files in less.
```
Now let's send the data to a number of process for examples output to
cat and less at the same time using the \|\> special pipe function.
And we will capture the data into $b as well.
```
  ls |> cat > $b | less        ' We can look at data with less.
  ? $b                         ' cat outputs to $b this should print listing again.
```
Let's add one more process and add our filter function we defined
earlier.
```
  ls |> cat > $b |> cat > filterdata | cat > $a  ' You will notice
                                                 ' that the listing in uppercase was displayed
  edit $a
```
#### Summary of \| and \|\> Output Messaging

We see here that we can send data to the next task using a \| or \|\>. We
have also seen that we can send the same data to multiple tasks at the
same time for processing.

#### Now Let's Look at Using Pipes to Have Multiple Input Streams to a Single Task!

Let's do a simple multi input stream
```
  cat |< ls |< ls -l | sort  > $a  'This should put out a sorted list of both 'ls' commands.
  edit $a
```
We have seen how we can do pipe fitting with \|\> and \|\< to pipe
multiple processes into a single process or pipe the output from to many
process.

Let's try something more complex.
```
  ls -1 |> sort -r > $a | sort > $b ' This will create two sorted lists.
  ? $a;"\n";$b                      ' We should see the two list one reverse order.
  $c = $a & $b
  edit $c                           ' we can see everything 
```

Let's define a Gambas function as a filter, we will call it dog and
make it bark!
```
  Sub dog()
    dim buffer as string
    while not eof()
       try line input buffer
       if error then break
       print "bark..";buffer
    wend
    print "Ruff Ruff!!"
  end
```
Don't forget you can just edit it if there is an error with '**edit**
dog.'

Let's try it out.
```
  $a = 1        ' clear our variables
  $b = 1
  ls -1 | dog |> sort -r > $a | sort > $b
  ? $a;"\n";$b '  We should see the two lists, one in reverse order.
```
'Let's try to bark twice
```
  ls -1 | dog |> sort -r > $a | sort | dog > $b
  ? $a;"\n";$b   '  We should see the two list one reverse order.
  $c = $a & $b
  edit $c        '  lets look in detail at output
                 '  the second list will be bark bark.
```
#### Summary of Pipes and Pipe Fitting or Tees as They Are Known in Some Shells

So we have looked at creating pipes with filters and tees.

Note: when using a gambas function as the first element of a pipe stream it must be preceded by a !
so that the shell knows that the line is to be a cli pipe stream. Else it will try to execute it as
gambas script.

It is very simple to write Gambas functions and mix them with existing
Linux commands.

The \|\> and \|\< are unique to gsh and replace the tee used in other
shells.

## Gambas Shell Reference

### How Command Classes and Structures are Handled

In gsh each system command, user function, classes and structure is
stored in the \~/vars/subs or \~/vars/class or \~/vars/struct in the
users' directory; these will hold the users' functions, etc. If the user
wishes to modify one of the system commands then a copy saved here will
override the default system version. The system versions of
sub/class/struct reside in the '/usr/share/gsh/subs',
'/usr/share/gsh/class' and '/usr/share/gsh/struct' directories.

*Upon first use or reference the subs/classes/struct are loaded and
compiled into the shell name space.*

### gsh.image

At startup **gsh** loads the environment from the default image
\~/vars/gsh.image if it is exists.

This any image may be loaded explicitly with the \--image startup
parameter.

The gsh.image file is created when ever the gsh shell exits or save is
called with no parameters.

The gsh.image and \~/vars directory will be created if they do not exist
upon first startup of **gsh**.

### profile.gsh contains system wide definitions

This script is checked at each startup and if it has changed then it is
executed upon startup and may be edited. This file is the system wide
default profile. A copy is made in \~/vars and you may change it at your
own risk.

### gsh.rc contains all user specific definitions

This is run at every startup and is the place to put anything needed by
your private image during run time. It will be loaded into the image
when ever it changes. This file is found in the \~/vars directory.

### onstartup() executed at start of interactive session

This function is executed at the beginning of every interactive session.
It is defined in the onstartup file found in the \~/vars/subs directory.

### onexit() executed at end of interactive session

This function is executed at the end of every interactive session. It is
defined in the onexit file found in the \~/vars/subs directory.

### Shell Global Variables

Shell Global variables start with \$, for example ,\$history. Case
insensitive.

These variables are not dim'd. Data type is assigned dynamically.

The type may not change if the variable is being watched for changes.

Shell Global variables persist and are saved at the time of closing the
**gsh** shell.

Shell Global variables may be used the same way regular variables are
used except for iteration evaluation this is not allowed: for \$i = 0 to
100 .....

Shell Global variables can be referenced in any process or sub process
of **gsh**.

They are system wide, except:

\* \$pwd is the PWD environment variable of each process, see Current Working Directory.

\* A variable kept in sync with an environment variable, \$path and any variable
given to setsync, is private to each session: the **gsh** started from a terminal
and everything it starts, including a **gsh** started from it, share one copy. Another
session has its own copy. A new session starts from the saved shared value merged
with its environment. A change made in a session is not saved for later sessions,
put lasting changes in profile.gsh or gsh.rc.

Remember to vardel ("varname") at the end of a session if you don't
want it to appear when you next start **gsh**.

#### \$VarName = \<value\>

Global Variables Definition, value may be any type, and is set
dynamically upon assignment.

#### \$0 to \$n gsh command line parameter

Parameters passed on the command line of a **gsh** script.

#### \$\# gsh command line parameter count

This is the number of parameters passed to a script, including the
script name.

#### \$result

This reserved variable will have the returned value after each builtin
function is called.

This may be used by your functions to return values.

Note, you must VarDel "\$result" if you change the type away from
string type.

#### \$trace Use the traceon or traceoff command to set this

Turn on or off shell script tracing. Writes line to stderr as they are
executed.

This is global and will affect system wide scripts, on the fly.

\$trace = true ' turns on tracing.

\$trace = false ' turn off tracing. This is the default.

#### \$prompt

The prompt, it is displays as 'print eval(\$prompt);;' so can be
edited with any valid eval statement to change the prompt just 'edit
\$prompt'. The change is apparent when the editor closes.

Be warned if the expression fails the prompt will be reset to the
default.

The default prompt is -

"\\x1b\[31m"&user.name&"@"&system.host&":\\x1b\[32m\]"&env\["PWD"\]&"\$\\x1b\[0m\]"&gsh.blockindent

#### \$editor

This variable contains the name of the default text editor. (nano)

#### \$hexeditor

This variable contains the default binary editor for binary
information.(hexedit)

#### \$alias

The collection of aliases.

#### \$profile

Set to true or false . Indicates if profile should be reloaded on next start.

"True" means is loaded. "False" means to load/reload profile.gsh.

#### \$blockindent

This is the characters used when indenting block levels during
interactive sessions.

Set to " " 2 spaces by default

#### \$maxhistory

Maximum line entries to be kept as history

#### \$historycurrent

The current history entry, never roles over. Use clearhist to reset
history

#### \$history

This is the collection of lines entered.

#### \$pwd

The current working directory of this process, the same as env["PWD"].
Setting it changes the directory of the process. See Current Working Directory.

#### \$path

The search path for commands, kept in sync with env["PATH"]: setting \$path
changes PATH for the commands run after it. Private to each session, see Shell
Global Variables.
```
  $path = $path & ":/opt/mytools/bin"   ' this session finds the commands in /opt/mytools/bin
  ? env["PATH"]                         ' shows the new entry
```

#### \$env

The environment that is passed to the Tasks and processes

#### \$helpdisplay

This is the command used to display the help text information(less -c)

#### \$\$

This will substitute the current pid onto a command line

#### \$UID

This will substitute the user id onto the command line

#### \$GID

This will substitute the Group id onto the command line

#### \$scriptpath

This is the path used when looking for executable gsh scripts
Defaults to "~/vars/scripts;/usr/share/gsh/scripts"

#### \$structpath

This is the path searched when looking for structure definitions
Defaults to "~/vars/struct;/usr/share/gsh/struct"

#### \$subspath

This provides the path to search when looking for plugin subroutine definitions
Defaults to "~/vars/subs;~/vars/games;/usr/share/gsh/subs"

#### \$classpath

This is the path used when looking for class definitions
Defaults to "~/vars/class;/usr/share/gsh/class"

#### \$TraceLevel

This is the depth of script trace performed 0-400
Defaults to 400, controlled by traceon command.

#### \$execprog

Contains the last executed code block. see code block section

#### \$TextFont

Contains the font to be set when the gsh app is running in a terminal.
This must be set by you to match the terminal font type.
Defaults to mono, Must be set to nerd if they are installed.

#### \$nerdfont true or false

The nerdfonts have been installed, checked and set by default onstart


### Shell Operators

#### ! or \| Direct the stdout from one task/process/function to another

Is used at the beginning of a line to define an external command or
force a function to be executed as a process.

In many cases the shell will detect an external command but using !
forces it to execute as a command or functions as a command \| may only
be used between commands, not at the beginning of a line. chmod and
chown are examples of Gambas and cli both having same name.

For example, type '!ls or 'ls' to list a directory.

```
   !ls > $a
   ls -1 > $a      ' or just this
```

this will store the returned value into the global value \$a; if a local
variable is used it needs to be dim'd first and will only persist
during the command execution.

This may also be used to pipe stdout to stdin of the next command.

```
   !cat <<< $f | cat | cat | cat > $r
```

This will send output from the first to the second command and so on.
The ! is not needed for the first command as gsh checks the first symbol
to see if it's external so from

```
   cat <<< $f | cat | cat | cat > $r ' will also work.
```

Any function that reads or writes to stdin stderr or std out may be used
in the pipe string.

*Examples* see sample functions at end of help.

```
   cat <<< $f | SampleFilter <<< $f | tr [a-z] [A-Z] | SampleReceiver
```

In the above case SampleFilter gets input from \$f and cat at the same
time

```
   !SampleInjector | cat > $r | tr [a-z] [A-Z] | SampleReceiver
```

The ! before the function is required to force the line to be treated as
a pipe fitting. A sub in a pipe line is run as a command, so it is written
without () and any arguments follow it separated by spaces. Without it the shell will pass this line to the Gambas
compiler directly. This causes the shell to create a task with this
function as the source. given any function n the pipe will cause the
creation of a process with the function as the main process.

```
   cat <<< DataSource() | less
```

A function may be used as an input to a command/function with <<< as long
as it returns a string.

```
   sub Datasource() as string
     return "MsgHeader"&application.name
   end
   cat <<< "hello" > datasink | less
```

The datasink function will be called each time data is available from
**cat**.

The function must receive a string as it only inputs parameters.

```
   sub datasink(data as string)
     ...... ' process data
   end
```

#### Input Output Redirection Targets

There are four types of targets or sources for input and output
redirection.

##### Files: Files may be the source or destination of redirection. Specified as follows.

It may start with ./ \~/ / followed by path and filename. Or just a
filename from the current working directory. If the file name conflicts
with a command or keyword then a @ may be placed in front of the
filename.

Examples: ./thisfile or \~/thisfile or */usr... or \@filename or
filename*

Shell substitution such as \~/\*/filename will be expanded as required

##### Variables: Output may be sent to any global variable, input is sent from a variable with <<<

##### Functions: Output to any function who's parameter is a string

##### Functions: Input with <<< from any function that returns a string

##### Constants: Any string or numeric constant or inline array of such types

#### \< Redirect input from a file

Reads a file into the command's input.

```
   cat < myfilename
```

#### \<\< Here document, send the lines that follow as input

The lines after the command, up to a line holding only the end word, are
sent to the command's input. In a script they are read from the script,
at the prompt gsh asks for them with `> `. The case of the end word is
ignored. gsh reads the text once into a variable, so a here document in
a loop is sent each time round without being read again.

```
   $name = "World"
   cat << EOF
Hello $name, 1 + 2 = {(1+2)}
EOF
```
prints `Hello World, 1 + 2 = 3`. Write the lines without indenting
them, the end word must be alone on its line.

- `$name`, `{(expression)}` and `{name}`, a Gambas variable such as a loop
  counter, are filled in each time the command runs. `\$` and `\{` keep
  the character.
- `<< "EOF"` or `<< 'EOF'` sends the text exactly as written.
- `<<- EOF` removes the tabs at the start of each line and of the end
  word line, so the text can be indented with tabs.
- `<< $var` takes the end word from a variable when the command runs,
  the text is then read from the command's input.

```
   for i as integer = 1 to 2
     cat << EOF
pass {i} of 2
EOF
   next
```
prints `pass 1 of 2` and `pass 2 of 2`.

#### \<\<\< Send a string, variable or function result as input

Direct the content of a global variable, a string or the result of a
source function into an external command.

It is allowed to send multiple variable contents to a command.

You may also send variable input to a command in a pipe sequence.

Example:

```
   cat <<< $f <<< $t | cat <<< $r | cat > $b | cat > $s
```

#### \> \>\> Redirect output to file/sub/variable

Direct Output from an external command to a global variable or sink
function.

It is allowed to write the output to multiple variables and also to pipe
to the next external command.

Example:

```
   cat <<< $f <<< $t > $g > $d | cat <<< $u > $s | cat | cat > $z
```

`>>` Appends to variable content or calls a sink function.

`>` Clears variable first then sets content, or calls a sink
function.

#### &\> &\>\> Redirect Error Output to file/sub/variable

Direct stderr? to a global variable. It is allowed to send it to many
variables, as needed.

Example:

```
   cc "myprog.c" > $g &> MyFunc() &> $cerr &>> $cerrhist | cat | cat | cat > $z
```

`&>>` Appends to variable content, Also may send data to a sink
function.

`&>` Clears variable first then sets value. Also may send data to a
sink function.


#### 2\> 2\>\> 2\>\&1 sh Style Error Redirection

The sh forms may be used as well. 2\> is the same as &\>, and 2\>\> is the
same as &\>\>, so they send stderr to a file, variable or sink function.
2\>\&1 sends stderr to where stdout goes, a file, a variable or the next
stage of a pipe. Only 2\>\&1 is supported for duplicating stderr.

Example:

```
   ls nnnnvvvv 2> errors.txt          ' the error message goes to the file errors.txt
   ls mmmmvvvv 2>> errors.txt         ' a second error message is added to errors.txt
   ls nnnnvvvv 2> $b                  ' the error message goes to $b
   ls mmmmvvvv 2>> $b                 ' $b now holds both messages
   ls errors.txt nnnnvvvv > all.txt 2>&1    ' the listing and the error both go to all.txt
   ls errors.txt nnnnvvvv 2>&1 | sort       ' both streams go into the pipe
   ls errors.txt nnnnvvvv > $a 2> $b        ' the listing goes to $a, the error to $b
```

Note: stdout and stderr are read separately, so with 2\>\&1 the text of the
two streams may be mixed together in the order it arrives.

#### !\> Save the Exit Code of a Command to a Variable

!\> stores the exit code of the command it follows in a global variable,
0 for success. In a pipe it belongs to the command it is written after.
$? holds the exit code of the last command of the line.

Example:

```
   ls errors.txt !> $r                ' $r is 0, ls found the file
   ls nnnnvvvv 2> $e !> $r            ' $r is 2, the error message is in $e
   ls nnnnvvvv !> $r | sort           ' $r is 2, the exit code of ls
   ls nnnnvvvv | sort !> $r           ' $r is 0, the exit code of sort
   ls nnnnvvvv 2> $e !> $r
   If $r <> 0 Then Print "ls failed with";; $r
```

#### \|\< \|\> Pipe fitting output or input from multiple tasks/processes/functions

These allow more that one input/output function/task to feed a command
or one command to feed many tasks like a tee in pipe fitting.

Example:

```
   NetMonitor |< NetConnect1() |< NetConnect2() |> netforward() | cat >> $logger
```

In this example, network traffic is received by NetMonitor from
NetConnect 1 and 2. NetMonitor output goes to netforward and Cat and
finally appended into \$logger database entry.

**\|\<** send data to a process from a source function or another
process

**\|\>** send data from a process to a sink function or another process.

#### :\> Store the return code from this process to a variable

`:>` is no longer used, write `!>` instead, see **!\>** above.

```
   ls xvxdfdr !> $s
```

ls outputs the message : directory xvxdfdr not found.

`print $s` outputs 2 which is from **ls**. It means not found.

The 2 is the **ls** commands exit code equivalent to the Gambas quit(2).

#### HistoryEntryNumber!

Will re-execute the command from history for example :

```
   3!
```

#### \[0\]findpattern/replacepattern/

Edit the content of history lines using regular expression
regex.replace().

\[historyEntryNumber\] is the history entry number enclosed in \[\].

findpattern is a regular expression to locate in the history entry.

replacepattern is the text to use to replace the matching entry.

#### \`Linux cli\` Back Ticks - Execute cli and return exit code

Back ticks run a linux command line from Gambas code and return the exit
code of the last command, 0 when it worked. This may be used anywhere a
Gambas function may be called.

Example:
```
  if `ls / > $a` = 0 then print "the command worked\n" ; $a
  print `ls /nofile 2> /dev/null`     ' prints 2, the exit code of ls
```

This is different from bash. In bash back ticks, and $(...), are command
substitution: the command is run and its output text replaces the back
ticks in the command line, so ls -d \`echo /tmp\` runs ls -d /tmp. gsh does
not do this, back ticks inside the arguments of a command line are passed
to the command as they are written. To use the output of a command in
another command line, send it to a variable and use {(...)}:
```
  echo /tmp > $d
  ls -d {(Trim($d))}                  ' runs ls -d /tmp/, echo adds the / to a directory name
```

#### "\#{expression}"

Evaluate the expression immediately and replace text with evaluated
expression.

Example:

```
   "#{'print'}" application.name; User.name
```

This translates to and executes this line

```
   print application.name; user.name
```

Inside expressions use single quote ' instead of double quote ".

This example will be evaluated to 'print application.name; "stuff".'

After the evaluation, the line will be executed.

Example using the default prompt:

```
   print "#{quote(Sharedmem['pwd']&' $'&sharedmem['blockindent'])}"    ' the names are without the $
```

Remember the evaluation is executed in this context. The line is
executed in its own context.

This allows to pass values from this context to the next.

Example:

```
   print "#{quote(application.name)}"    'this will print "gsh"
   print application.name    'this will print "lambda"
```

They happen in different contexts. Global variables span contexts.

#### ? Same as print

At the beginning of a line will print what ever follows this is a
standard Gambas notation.

For example ? \$a;\$b,c,d \-- will print the content of these variables

#### & Start the command/function as a detached process

Place this after the last line of your command to execute the command as
an independent process.

#### :; Used to separate Gambas statements

This is used to separate multiple statements on single line, changed
from : as Gambas name spaces now use the : in their definition.

#### {Var/Expr} or \$gshVar Passes a Gambas variable into a Linux command (CLI)

This format is used to pass a Gambas block local variable into a Linux
command.

Example : \$a = 4 :; For I as integer = 0 to 5 :; echo the variables are
{i} and \$a :; next

gsh global variables are passed simply as : \$myvar

### Global Commands/Functions/Classes

#### get \<Command\> \<Command\> ... This is now Mostly Obsolete

List of additional commands to be loaded. These are complete modules
having many functions. Only the provided command name may be called from
the command line.

Command may be a file name or filename and path as a file
"/usr/bin/mycommand" or CommandName which is loaded from \~/vars.

The interface entry point is the function with the same name as command

**Commands and subroutines/classes and structures are loaded as they are
referenced**

**in a command line or script. Location \~/vars/subs,
\~/vars/class,\~/vars/struct. So this is really no longer required.
Except when pointing to non standard locations.**

#### edit \[class\|function\|variable\]

Edit or create a class,function,string or string\[\] variable for your
environment. Starts the editor defined in the \$editor global variable
classes and functions become part of the image and are linked to
commands as needed.

\$editor - holds the name of the text editor to be used for texted based
editing.

\$hexeditor - holds the name of the editor to be used for binary type
variables.

Examples:

sub test() is defined then 'edit test' will allow you to change this
function.

class test2 is defined then 'edit test2' will allow you to change
this.

\$h = \["ddd","dddd"\] then edit this like 'edit \$h'

\$h = "djjdjdjddj" then edit this like 'edit \$h' the shell knows
the base type and will save it in the same form.

\$h = new byte\[\] when you edit \$h then the hex editor will open with
content

Edit a collection of string values in the same way eg edit \$history.

Edit the system prompt edit \$prompt.

You can create a new variable, class, or function

Enter edit newname&&

You will be prompted to create a variable,class or function.

In summary you can edit just about everything!

If entered without any parameters then it will open the last executed
block of code.

\$execprog is a special case of file name and will open the last
generated gambas script.

#### run \["Scriptname"\]

Execute an external gsh script immediately. Scripts should return
information in global variables. This is a Gambas shell script not a
Gambas script.

If run is entered without any parameters then the last valid code block
is executed. That is the last thing you ran will be run again. Be
careful not to run 'run this way, as an infinite loop will result...

#### Quit

End of execution or close gsh session. Gsh shells/scripts return values
in global variables.


#### alias text substitution of values before evaluation

An alias replaces a command at run time with the alias and are defined
much the same as posix shell. The input is scanned and matching entries
are replaced by the alias. The process is repeated after each
substitution until all aliases have been checked ensuring that each is
only applied once to the line. An alias whose name ends in () takes
parameters, see Parameterized aliases below.

Alias function are created by creating a sub of the name of the command
its replacing.

Examples of aliases from the profile.gsh . Defaults are directly
imported from .profile.

alias fgrep='fgrep \--color=auto'

alias grep='grep \--color=auto'

alias l='ls -CF'

alias la='ls -A'

alias ll='ls -alF'

alias ls='ls \--color=auto'

alias cls='clear'

alias home='cd \~'

alias pkill='!kill' ← need to use this as KILL is a Gambas language
keyword

alias ps='ps -al'

alias update='run "profile.gsh"'

alias hh='hist -10'

alias path='? env\["PATH"\]'

alias exit='quit'

Aliases must be enclosed in ' single quotes and are applied only to
command lines not

program code.

Adding an alias:

The alias keyword followed by the alias name an equal sign and then a
single quote substitution string.

alias xxx='this'

Remove an alias:

Simply assign with no content.

Example

alias home=

This will remove the home alias.

List all aliases:

Just type the **alias** command by itself.

#### Parameterized aliases

An alias whose name ends in () takes parameters. In the alias text &1 is
replaced by the first parameter, &2 by the second and so on. The
parameters are put in as text, they are not evaluated, so they may be
pieces of code. A parameter written as one quoted string has its quotes
removed, so "print value" and print value give the same result. :; in
the alias text splits it into separate lines.

These are defined in the default profile.gsh:
```
alias foreach()='do:;for each value as variant in &1:;&2:;next:;done'
alias ifor()='for i as integer = &1 to &2:;&3:;next'
```
Examples:
```
   foreach([1,2,3], print value)                     ' prints 1 2 3
   foreach(Split("a b c", " "), print upper(value))  ' prints A B C
   foreach("env", "print value")                     ' prints the environment variable names
   ifor(1, 3, print i)                               ' prints 1 2 3
   ifor(1, 2, print i * 10) :; print "done"          ' prints 10 20 done
```
Defining and removing your own:
```
   alias twice()='&1:;&1'
   twice(print "hi")                                 ' prints hi twice
   alias twice()=
```
The last line removes it. A comment can not follow an alias line, the '
would be read as the start of the alias text.
Because a quoted parameter loses its quotes, a string value must be
written with escaped quotes inside the string, "\"one\"". A parameter
that is more than one string, such as "one" & "!", is put in as written.

#### compile or program \<Output Script Name\>

This will not execute the script entered but will produce an executable
Gambas script.

The script is standalone and may be executed directly.

The default program name if not specified is \~/bin/script.out

The mode is changed to executable as well.

In terms of functional programming.

You may compile and test each function and then after the final test.
Create a function which is the master function and compile it.

Example Session

```
   sub asub1(printString as string) as string
     return upper(printstring) & " Not much spoken!"
   end
```

now let's test our new sub enter:

```
   ? asub1("this")
```

it works!

Let's test it in a simple usage case.

```
   cat <<< asub1("This message to all\nNot Done\nJoy and life job\nNot hello") | tr [A-Z] [a-z] | grep not
```

It now works how we want. So now let's produce a standalone Gambas
script.

```
   <Compile | Program> nntest
     for i as integer = 0 to 10
       cat <<< asub1("This message to all\nNot Done\nJoy and life job\nhello") | tr [A-Z] [a-z] | grep not
     next
   end compile
```

Let's run our standalone script:

```
   nntest
```

The script produced will be a ready to execute stand alone Gambas Script
gbs type.

#### \@GlobalVariableName(don't include \$)

This will execute the content of the variable as a program and place the
text output into the current program line. Sort of self modifying code.
It must write text to the std out
```
Example:
 $j = "Print quote(\"hello\")"  'this stores program
 ? @j                            'this prints hello
```
In a sh style line write !@name (or ! @name) to run the variable as a
command, also after :;. Write @name for a later stage of a pipe or
after && or ||.
A bare name is never looked up as a variable, so a global such as
$mv = "x" does not hide the mv command.
```
 $c = "Print \"hi\""
 !@c | tr a-z A-Z                'prints HI
 echo abc | @c                   'prints hi
 ls x || @c                      'prints hi when ls fails
```
On a line by itself @name runs the variable but its output is not used,
the same as any other value that is not used. Use the result in a
statement, or put a ! in front to run the variable as a command:
```
 $c = "Print \"hi\""
 @c                              ' runs, nothing is shown
 ? @c & " more data"             ' prints hi more data
 !@c                             ' runs the variable as a separate process, prints hi
 echo {(@c)}                     ' prints hi
```
#### Parameters \$0-\$n and \$\#

This will contain all the parameters passed to the \@variable(parm0...)
call
```
example:
  $j = "Print quote($0)"  ' this sets the code
  ? @j("hello")           ' prints hello that was passed as a parameter
```
***Except when used on a CLI command line it's content will be used as
a file name for redirection.***

#### Sub/Function/Procedure and Class/Structures

Each are compiled immediately after creation. If there are errors they
are listed with the line number. Use **edit** command to make changes to
the code they are recompiled as soon as the editor exits. The syntax and
definitions follow Gambas rules with the exception that USE for defining
gambas components and shared libraries, Extern for defining external
c,c++ libraries, may be defined inside the sub or function for which it
is required. Public and private variables may be defined before the sub
definition.

If function is used as a command then they are executed in the context
of the current shell.

Example:
```
cd /      ' changes the current working directory to 
          ' the root directory
cd("/")   ' this will cause the function cd to be 
          ' linked to whatever script its called from.
```
When compiled without error the function, class etc will be loaded as a
memory resident plugin and executed withing context of the shell. It
will also be linked to any function or class that calls it.

If used as functions then they execute in the context of the block or
app executed that is running at the time.

Functions ,classes and structures may be edited with the **edit**
command.

#### Code Blocks Defined/Described

Will execute independently in the order they appear in the script.
```
Examples: if ... endif, while ... wend, for ... next , do ... loop until
```
In this document a code block is a single logically related section of
code that is encased by any valid Gambas language construct.

A single line such as:
```
   a = 24
```
Would be considered a singular block of code. And is executed as soon as
it's read by gsh. The value of **a** is lost immediately after it executes.
See: Global variables for persistence.
```
For I as integer = 0 to 100
  dim j as integer = i+1
  print I,j,I*j
next
```
This is an example of a multi line block of code. And would execute
after the next keyword is read.

And again all variables defined within this block disappear after the
block executes.

#### { ... } or Lambda ... end or Begin ... End or Do ... Done

Are pseudo instructions used to create a block of executable code. Gsh will normally execute
code immediately as it is read. So using one of these shell notations
allows the creation of a complete block before the shell begins
execution of the block. In this case execution begins as soon as the last [end, }, Done] 
statement is entered.

Also any other block type gambas instruction will start a block eg for .... next,
while...do etc .

Example:
```
{ < parm1 parm2 ... > or [[Lambda | Begin] or  Do] < parm1 parm2 ... >
  Dim i As String          Dim i As String 'as a use one time function
  i = "this\nthat"         i = param[0]
  dim j as string[]        dim j as string[]
  j = split(j,"\n")        j = split(j,"\n")
  $e = j                   $e = j
} <&>                  [[end] or Done] <&>

Preferred format is

Do
  print "this"
  ...
Done

```

You may edit and execute the last lambda expression by using \<edit \|
edit lambda \>

You may execute the lambda function again by using the run command with
no parameters.

Parameters may be passed to a lambda expression using the param for
Gambas '...' functions

If used in gsh scripts Gambas variable declarations are only local to
the lambda expression. But Shell Global variables may be changed and
created by lambda functions and will be available after the execution.

Parameters are useful if the expression is executed within a script
which is called many times with changing values.

Adding the & to the last statement will cause the block to execute as an
independent task with no wait.

### Commands -- Plugins from subs/class/struct Directories

#### cd directorypath - Change the current working directory

Changes the directory of the shell, sets env["PWD"] (\$pwd) and env["OLDPWD"].\
Function cd("directory").\
Command cd "directory."
Returns 'true' if found, 'false,' otherwise.\
\$result contains the error text or "OK"

#### clear Clears the screen

Returns 'true' if cleared, 'false,' otherwise.\
\$result contains the error text or "OK."

#### clearclass Clears all classes and structures from the image

#### clearhist Clears the history of entered commands

Function clearhist()\
Command clearhist()\
Returns 'true' if found, 'false' otherwise.\
\$result contains the error text or "OK."

#### clearsubs Clears all subs/functions/procedures from the image

#### clearvars Clears all user defined shell variables from memory

#### compload Loads a gambas3 component into the image

Compload "componentname" ...\
Loads the list of components into the shell.

#### fprint Prints to a file
The content of arrays and collections or objects/classes with the special
\_print function.\
Function fprint(filename,...) print the variables.\
Command lprint filename ..... prints the variables.\
Returns 'true' if found, 'false' otherwise.\
\$result contains the error text or "OK."

#### getfile "FileName" Loads a binary copy of the file into a global variable

Defaults to \~/vars/filename.\
Loaded file may be dumped using fprint.\
Used a byte\[\] as the medium edit will hex edit this type.

#### hist \<start at\>\<number of entries\> Prints a list input lines to the stdout

As function hist(optional StartAt, NumberOfEntriesToDisplay).\
As command hist startAt NumberOfEntriesToDisplay.\
Uses the global collection \$history.\
You can use a negative start up number to go back that number from the\
current line.
Returns 'true' if read, 'false' otherwise.\
\$result contains the error text or "OK."

#### hh Lists the last 10 history entries only

#### jobs \< pid \| ON \|OFF \> Prints a list of current background jobs

Turns Job Control ON or OFF Default is OFF.\
This lists all the jobs currently running for a user or requested PID.\
That is every instance of a task started by all gsh sessions for a user.

#### lclass \<GlobalClassname\> - Prints a list of global classes.

Prints the content of specific class if name is provided.\
Function lsub(\<subname\>).\
Command lsub \<subname\>\
Returns 'true' if found, 'false' otherwise.\
\$result contains the error text or "OK."

#### lenv Prints the current environment for exec.

As function lenv().\
As command lenv.\
Uses the global \$env string\[\] variable.\
Returns 'true' if found, false otherwise.\
\$result contains the error text or "OK."

#### dbload \<"ImageFileName"\> Loads and uses a memory image from a file .

Images may be saved to a file and loaded as needed.
Images may contain any application environment.\
Function load(\<"filename"\>).\
Command load \<"filename"\>.\
The default path is \~/vars/filename.\
The default filename is gsh.image.\
Returns 'true' if found, 'false' otherwise.\
\$result contains the error text or "OK."

#### dbsave \<"ImageFileName"\> - Saves the current image to a file.

Images may be saved to a file and loaded as needed.\
Images may contain any application environment.\
Function save(\<"filename"\>).\
Command save \<"filename"\>.\
returns 'true' if found, false otherwise.\
\$result contains the error text or "OK."

#### lprint Prints the content of arrays, collections, Object or Classes

Having a special \_print or write function.

Function lprint(...) print the variables.\
Command lprint ..... prints the variables.\
Returns 'true' if found, false otherwise.\
\$result contains the error text or "OK."

#### fprint Prints the content of arrays, collections, Object or Classes to a file

Having a special \_print or write function.

Function fprint(filename,...) print the variables.\
Command fprint filename ..... prints the variables.\
Returns 'true' if found, 'false' otherwise.\
\$result contains the error text or "OK."

#### lcompsub Lists all subs/functions compiled and loaded
#### lenv Lists the current environment
#### lnotify Lists the variables the current task is waiting to be notified on change
#### lsclasses Lists all the classes in the current environment

This is the Gambas classes collection for the current application

#### lsubs \<GlobalSubName\> - Prints a list of global functions, subs, procs

Prints the content of function if name is provided.\
Function lsub(\<subname\>)\
Command lsub \<subname\>\
Returns 'true' if found, false otherwise.\
\$result contains the error text or "OK"

#### lvars \<\$GlobalVarName\> - Lists all variables or specific variable with content

Shows this session's own \$path and \$pwd, not the copies of other sessions.\
Function lvars(\<varname\>)\
Command lvars \<varname\>\
Lists all if no parameter, other wise varname passed\
Returns 'true' if found, false otherwise\
\$result contains the error text or "OK"

#### readto(GlobalVar as string) For next command redirects output to variable

#### removesync varname - Stops keeping a variable in sync with its environment variable

Function removesync("varname").\
Command removesync varname.\
The variable stays private to this session until the session ends.

#### resetdefaults Resets the system variables to their default value

This is not destructive and will change all gsh system variables to
their default values.

#### resetenv Resets the current image to default

You must call save or quit to save this image to disk.

Function resetenv().\
Command resetenv.\
Returns 'true' if found, 'false' otherwise.\
\$result contains the error text or "OK."

#### savesubs Saves all or some of the subs in memory to the \~/vars/subs directory.
savesubs suba suba .. or just savesubs which will save them all

#### saveclasses Saves all/some of the classes to \~/vars/class or \~/vars/struct directories
saveclasses class1 struct1 ... or just saveclasses to save them all

#### setsync varname envname - Keeps a variable in sync with an environment variable

Setting the variable sets the environment variable of the session, for the
commands run after it. The variable becomes private to the session, see Shell
Global Variables. If the variable does not exist it starts with the value of the
environment variable, otherwise the environment variable takes the value of the variable.
```
  setsync myeditor EDITOR       ' or setsync("myeditor", "EDITOR")
  $myeditor = "vim"
  printenv EDITOR               ' prints vim
```
When the environment variable does not exist yet, setsync prints "creating new env variable".\
Function setsync("varname", "envname").\
Command setsync varname envname.

#### traceoff Turns off shell command tracing.

Will cause the printing of each input line with time stamp and required
terminator.\
Terminator is the current block termination string.

Command: traceoff

Returns 'true' if found, 'false' otherwise.\
\$result contains the error text or "OK."

#### traceon Turns on shell command tracing.

Will cause the printing of each input line with time stamp and required
terminator.

Terminator is the current block termination string.

Command traceon:

Returns 'true' if found, false otherwise\
\$result contains the error text or "OK"

#### vardel "\$globalvar" - Deletes a global variable/Sub/Class/Struct.

As function vardel("varname").\
As command vardel "varname."\
Global functions have format "sub.subname."\
Global classes have format "class.classname."\
Structures have format "struct.structname."\
Returns 'true' if found, 'false' otherwise.\
\$result contains the error text or "OK."

#### varread \$GlobalVarName \<"filename"\> - Reads a global variable value from a file\> .&&

Default File name = \~/var/varname\
As function - varread("varname \<, "filename"\>).\
As command - varread "varname" \<"filename"\>.\
Returns 'true' if read, 'false' otherwise ,\$result contains the error\
text or "OK."

#### varrd Reads a list of global variables from their default filenames.

varrd \$a \$b ...

#### varstat varname display\<true\|false\> - Displays info about a variable.

varname with display=yes; defaults to display info other wise just
returns Stat

Displays the var type, class etc.

#### varwrite \$GlobalVarName \<"filename"\> - Writes a global variable value to a file.

Default file name = \~/var/varname\
As function - varwrite("varname \<, "filename"\>)\
As command - varwrite "varname" \<"filename\>\
Returns 'true' if write, 'false' otherwise.\
\$result contains the error text or "OK."

#### varwr Writes a list of global variables to their default files names.

varwr \$a \$b ....

### Job control

Job control allows the user to keep track of jobs executing in
background and collect statistics about the jobs execution time.

- `jobs on` Turns on the job control and recording
- `jobs off` Turns off the job control and recording
- `jobs pid` Lists the current state of the job with pid(process id)
- `jobs` By its self lists all terminated, running, suspended background jobs.

Output looks like this after a job completes in foreground
```
  Complete pid=10382 State=0 Value=0

  Start=06/18/2020 22:08:52.509 End=06/18/2020 22:08:52.545
  Duration=0.041630119085312
```

When background jobs complete an entry is made into list by entering the
jobs command it returns a list of and status of all jobs. For example:
```
>> jobs
18591 06/18/2020 19:20:03.468 06/18/2020 19:20:03.476 [Complete]
result=0 Duration=0.009266659617424 "time" , "-v" , "ls"

18829 06/18/2020 19:22:03.923 06/18/2020 19:22:03.926 [Complete]
result=0 Duration=0.003492459654808 "time" , "--help"

18915 06/18/2020 19:22:45.385 06/18/2020 19:22:45.388 [Complete]
result=0 Duration=0.003445893526077 "ls" , "--color=auto"

10388 06/18/2020 22:08:52.535 06/18/2020 22:08:52.542 [Complete]
result=0 Duration=0.008102506399155 "ls" , "--color=auto" , "-l"

10661 06/18/2020 22:11:11.243 06/18/2020 22:11:11.248 [Complete]
result=0 Duration=0.005774199962616 "ls" , "--color=auto" , "-l"

10672 06/18/2020 22:11:12.697 06/18/2020 22:11:12.703 [Complete]
result=0 Duration=0.006938353180885 "ls" , "--color=auto" , "-l"
```

After the jobs are listed any completed ones are removed from the list

### Sample Functions for Pipe Fitting

These are simple templates for using Gambas functions as pipe elements.

They can open network connections or a file, anything you want to
manipulate data.

An example might be:
```
  DataAnalyzer |< ExternThermometer1 |< ExternThermometer2 |< WindSpeedMonitor |> DataReporter | DataRecorder
```
This will feed ExternThermometer1, ExternThermometer2 and
WindSpeedMonitor to DataAnalyzer

The Output from DataAnalyzer is sent to both DataReporter, and
Datarecorder.

Each function is run as an independent process. When used with the
Compile command a stand-alone Gambas scripts can be created.

#### Sub filter() ' this is a simple filter to do upper to lower case
```
Sub filter()
'' these functions just have to read from std input and write to
'' standard output until the std input is closed
  dim buffer as string
  while not eof()
    try line input buffer
    if error then break
    print upper(buffer)
  wend
  print "done"
End
```

#### Sub injector(num as integer) Simple Example of a Data Injector

Functions like this can be to inject data into a process stream. You
just have to write to standard output.
```
Sub injector(num as integer)
   for i as integer = 0 to num
     print "Sub here";;i
   next
   quit 0
End
```

#### Sub Sink() ' simple example of a data sink receiver
```
Sub Sink()
'' Functions like this can be to sink/receive data from a process stream
'' Just have to read from stdin
  dim buffer as string
  while not eof()
    line input buffer   ' do something with data
  wend
  quit 0
End
```

### Sample Functions for Stream Redirection

Filter or Data Sink functions both use the same interface. The filename
is passed as a global variable.

#### Sub DataSink(Data as string) ' example output data redirection sink
```
Sub DataSink(Data as string)
  extern mopen(FileName as string, mode as integer) as integer in "libc:6" exec "open"
  extern mwrite(filenum as integer,value as pointer, length as integer) as integer in "libc:6" exec "write"
  If $OpenFileNum = -1 then
     $OpenFileNum = mopen($filename,&x400 or 1 or &x0100)
  endif
  write($OpenFileNum,data,data.len)
end
```
The function parameter is not required. The function must return a
string as the data to be written to the process.

#### Sub DataSource(filename as string) as string ' example input redirection source
```
Sub DataSource(filename as string) as string
  dim a as string
  a = file.load(filename)
  return a
end
```