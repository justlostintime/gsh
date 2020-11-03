" Vim syntax file
" Language:    Gambas script
" Maintainer:  Brian G Mark Manning <markem@airmail.net>
" Updated:     05/25/2020
"
" Description:
"
"	Based originally on the work done by Allan Kelly <Allan.Kelly@ed.ac.uk> and Mark Manning <markem@airmail.net>
"	Updated by brian g <brian@westwoodsvcs.com>
"	Applied gambas support to the already excellent support
"	for standard basic syntax (like QB).
"
"	First version based on Micro$soft QBASIC circa
"	1989, as documented in 'Learn BASIC Now' by
"	Halvorson&Rygmyr. Microsoft Press 1989.  This syntax file
"	not a complete implementation yet.  Send suggestions to
"	the maintainer.
"
"	Quit when a (custom) syntax file was already loaded (Taken from c.vim)
"
if exists("b:current_syntax")
  finish
endif
"
"	Be sure to turn on the "case ignore" since current versions
"	of gambas support both upper as well as lowercase
"	letters. - MEM 10/1/2006
"
syn case ignore
"
"	This list of keywords is taken directly from the FreeBasic
"	user's guide as presented by the FreeBasic online site.
"
syn keyword	gambasArrays			ERASE LBOUND REDIM PRESERVE UBOUND

syn keyword	gambasBitManipulation	BIT BITRESET BITSET HIBYTE HIWORD LOBYTE LOWORD SHL SHR

syn keyword	gambasCompilerSwitches	DEFBYTE DEFDBL DEFINT DEFLNG DEFLNGINT DEFSHORT DEFSNG DEFSTR
syn keyword	gambasCompilerSwitches	DEFUBYTE DEFUINT DEFULNGINT DEFUSHORT
syn match	gambasCompilerSwitches	"\<option\s+\(BASE\|BYVAL\|DYNAMIC\|ESCAPE\|EXPLICIT\|NOKEYWORD\)\>"
syn match	gambasCompilerSwitches	"\<option\s+\(PRIVATE\|STATIC\)\>"

syn region	gambasConditional		start="\son\s+" skip=".*" end="gosub"
syn region	gambasConditional		start="\son\s+" skip=".*" end="goto"
syn match	gambasConditional		"\<select\s+case\>"
syn keyword	gambasConditional		if iif then case else elseif with

syn match	gambasConsole		"\<open\s+\(CONS\|ERR\|PIPE\|SCRN\)\>"
syn keyword	gambasConsole		BEEP CLS CSRLIN LOCATE PRINT POS SPC TAB VIEW WIDTH

syn keyword	gambasDataTypes		BYTE AS DIM CONST DOUBLE ENUM INTEGER LONG LONGINT SHARED SHORT STRING
syn keyword	gambasDataTypes		SINGLE TYPE UBYTE UINTEGER ULONGINT UNION UNSIGNED USHORT WSTRING ZSTRING

syn keyword	gambasDateTime		DATE DATEADD DATEDIFF DATEPART DATESERIAL DATEVALUE DAY HOUR MINUTE
syn keyword	gambasDateTime		MONTH MONTHNAME NOW SECOND SETDATE SETTIME TIME TIMESERIAL TIMEVALUE
syn keyword	gambasDateTime		TIMER YEAR WEEKDAY WEEKDAYNAME

syn keyword	gambasDebug			ASSERT STOP

syn keyword	gambasErrorHandling		ERR ERL ERROR LOCAL RESUME
syn match	gambasErrorHandling		"\<resume\s+next\>"
syn match	gambasErrorHandling		"\<on\s+error\>"

syn match	gambasFiles			"\<get\s+#\>"
syn match	gambasFiles			"\<input\s+#\>"
syn match	gambasFiles			"\<line\s+input\s+#\>"
syn match	gambasFiles			"\<put\s+#\>"
syn keyword	gambasFiles			ACCESS APPEND BINARY BLOAD BSAVE CLOSE EOF FREEFILE INPUT LOC
syn keyword	gambasFiles			LOCK LOF OPEN OUTPUT RANDOM RESET SEEK UNLOCK WRITE

syn keyword	gambasFunctions		ALIAS ANY BYREF BYVAL CALL CDECL CONSTRUCTOR DESTRUCTOR
syn keyword	gambasFunctions		DECLARE FUNCTION LIB OVERLOAD PASCAL STATIC SUB STDCALL
syn keyword	gambasFunctions		VA_ARG VA_FIRST VA_NEXT

syn match	gambasGraphics		"\<palette\s+get\>"
syn keyword	gambasGraphics		ALPHA CIRCLE CLS COLOR CUSTOM DRAW FLIP GET
syn keyword	gambasGraphics		IMAGECREATE IMAGEDESTROY LINE PAINT PALETTE PCOPY PMAP POINT
syn keyword	gambasGraphics		PRESET PSET PUT RGB RGBA SCREEN SCREENCOPY SCREENINFO SCREENLIST
syn keyword	gambasGraphics		SCREENLOCK SCREENPTR SCREENRES SCREENSET SCREENSYNC SCREENUNLOCK
syn keyword	gambasGraphics		TRANS USING VIEW WINDOW

syn match	gambasHardware		"\<open\s+com\>"
syn keyword	gambasHardware		INP OUT WAIT LPT LPOS LPRINT

syn keyword	gambasLogical		AND EQV IMP OR NOT XOR

syn keyword	gambasMath			ABS ACOS ASIN ATAN2 ATN COS EXP FIX INT LOG MOD RANDOMIZE
syn keyword	gambasMath			RND SGN SIN SQR TAN

syn keyword	gambasMemory			ALLOCATE CALLOCATE CLEAR DEALLOCATE FIELD FRE PEEK POKE REALLOCATE

syn keyword	gambasMisc			ASM DATA LET TO READ RESTORE SIZEOF SWAP OFFSETOF

syn keyword	gambasModularizing		CHAIN COMMON EXPORT EXTERN DYLIBFREE DYLIBLOAD DYLIBSYMBOL
syn keyword	gambasModularizing		PRIVATE PUBLIC

syn keyword	gambasMultithreading		MUTEXCREATE MUTEXDESTROY MUTEXLOCK MUTEXUNLOCK THREADCREATE THREADWAIT

syn keyword	gambasShell			CHDIR DIR COMMAND ENVIRON EXEC EXEPATH KILL NAME MKDIR RMDIR RUN

syn keyword	gambasEnviron		SHELL SYSTEM WINDOWTITLE POINTERS

syn keyword	gambasLoops			FOR LOOP WHILE WEND DO CONTINUE STEP UNTIL next

syn match	gambasInclude		"\<#\s*\(inclib\|include\)\>"
syn match	gambasInclude		"\<\$\s*include\>"

syn keyword	gambasPointer		PROCPTR PTR SADD STRPTR VARPTR

syn keyword	gambasPredefined		__DATE__ __FB_DOS__ __FB_LINUX__ __FB_MAIN__ __FB_MIN_VERSION__
syn keyword	gambasPredefined		__FB_SIGNATURE__ __FB_VERSION__ __FB_WIN32__ __FB_VER_MAJOR__
syn keyword	gambasPredefined		__FB_VER_MINOR__ __FB_VER_PATCH__ __FILE__ __FUNCTION__
syn keyword	gambasPredefined		__LINE__ __TIME__

syn match	gambasPreProcessor		"\<^#\s*\(define\|undef\)\>"
syn match	gambasPreProcessor		"\<^#\s*\(ifdef\|ifndef\|else\|elseif\|endif\|if\)\>"
syn match	gambasPreProcessor		"\<#\s*error\>"
syn match	gambasPreProcessor		"\<#\s*\(print\|dynamic\|static\)\>"
syn keyword	gambasPreProcessor		DEFINED ONCE

syn keyword	gambasProgramFlow		END EXIT GOSUB GOTO
syn keyword	gambasProgramFlow		IS RETURN SCOPE SLEEP

syn keyword	gambasString			INSTR LCASE LEFT LEN LSET LTRIM MID RIGHT RSET RTRIM
syn keyword	gambasString			SPACE STRING TRIM UCASE ASC BIN CHR CVD CVI CVL CVLONGINT
syn keyword	gambasString			CVS CVSHORT FORMAT HEX MKD MKI MKL MKLONGINT MKS MKSHORT
syn keyword	gambasString			OCT STR VAL VALLNG VALINT VALUINT VALULNG

syn keyword	gambasTypeCasting		CAST CBYTE CDBL CINT CLNG CLNGINT CPTR CSHORT CSIGN CSNG
syn keyword	gambasTypeCasting		CUBYTE CUINT CULNGINT CUNSG CURDIR CUSHORT

syn match	gambasUserInput		"\<line\s+input\>"
syn keyword	gambasUserInput		GETJOYSTICK GETKEY GETMOUSE INKEY INPUT MULTIKEY SETMOUSE
"
"	Do the Basic variables names first.  This is because it
"	is the most inclusive of the tests.  Later on we change
"	this so the identifiers are split up into the various
"	types of identifiers like functions, basic commands and
"	such. MEM 9/9/2006
"
syn match	gambasIdentifier		"\<[a-zA-Z_][a-zA-Z0-9_]*\>"
syn match	gambasGenericFunction	"\<[a-zA-Z_][a-zA-Z0-9_]*\>\s*("me=e-1,he=e-1
"
"	Function list
"
syn keyword	gambasTodo		contained TODO
"
"	Catch errors caused by wrong parenthesis
"
syn region	gambasParen		transparent start='(' end=')' contains=ALLBUT,@gambasParenGroup
syn match	gambasParenError	")"
syn match	gambasInParen	contained "[{}]"
syn cluster	gambasParenGroup	contains=gambasParenError,gambasSpecial,gambasTodo,gambasUserCont,gambasUserLabel,gambasBitField
"
"	Integer number, or floating point number without a dot and with "f".
"
syn region	gambasHex		start="&h" end="\W"
syn region	gambasHexError	start="&h\x*[g-zG-Z]" end="\W"
syn match	gambasInteger	"\<\d\+\(u\=l\=\|lu\|f\)\>"
"
"	Floating point number, with dot, optional exponent
"
syn match	gambasFloat		"\<\d\+\.\d*\(e[-+]\=\d\+\)\=[fl]\=\>"
"
"	Floating point number, starting with a dot, optional exponent
"
syn match	gambasFloat		"\.\d\+\(e[-+]\=\d\+\)\=[fl]\=\>"
"
"	Floating point number, without dot, with exponent
"
syn match	gambasFloat		"\<\d\+e[-+]\=\d\+[fl]\=\>"
"
"	Hex number
"
syn case match
syn match	gambasOctal		"\<0\o*\>"
syn match	gambasOctalError	"\<0\o*[89]"
"
"	String and Character contstants
"
syn region	gambasString		start='"' end='"' contains=gambasSpecial,gambasTodo
syn region	gambasString		start="'" end="'" contains=gambasSpecial,gambasTodo
"
"	Comments
"
syn match	gambasSpecial	contained "\\."
syn region	gambasComment	start="^rem" end="$" contains=gambasSpecial,gambasTodo
syn region	gambasComment	start=":\s*rem" end="$" contains=gambasSpecial,gambasTodo
syn region	gambasComment	start="\s*'" end="$" contains=gambasSpecial,gambasTodo
syn region	gambasComment	start="^'" end="$" contains=gambasSpecial,gambasTodo
"
"	Now do the comments and labels
"
syn match	gambasLabel		"^\d"
syn match	gambasLabel		"\<^\w+:\>"
syn region	gambasLineNumber	start="^\d" end="\s"
"
"	Create the clusters
"
syn cluster	gambasNumber		contains=gambasHex,gambasOctal,gambasInteger,gambasFloat
syn cluster	gambasError		contains=gambasHexError,gambasOctalError
"
"	Used with OPEN statement
"
syn match	gambasFilenumber	"#\d\+"
syn match	gambasMathOperator	"[\+\-\=\|\*\/\>\<\%\()[\]]" contains=gambasParen
"
"	The default methods for highlighting.  Can be overridden later
"
hi def link gambasArrays		StorageClass
hi def link gambasBitManipulation	Operator
hi def link gambasCompilerSwitches	PreCondit
hi def link gambasConsole		Special
hi def link gambasDataTypes		Type
hi def link gambasDateTime		Type
hi def link gambasDebug		Special
hi def link gambasErrorHandling	Special
hi def link gambasFiles		Special
hi def link gambasFunctions		Function
hi def link gambasGraphics		Function
hi def link gambasHardware		Special
hi def link gambasLogical		Conditional
hi def link gambasMath		Function
hi def link gambasMemory		Function
hi def link gambasMisc		Special
hi def link gambasModularizing	Special
hi def link gambasMultithreading	Special
hi def link gambasShell		Special
hi def link gambasEnviron		Special
hi def link gambasPointer		Special
hi def link gambasPredefined		PreProc
hi def link gambasPreProcessor	PreProc
hi def link gambasProgramFlow	Statement
hi def link gambasString		String
hi def link gambasTypeCasting	Type
hi def link gambasUserInput		Statement
hi def link gambasComment		Comment
hi def link gambasConditional	Conditional
hi def link gambasError		Error
hi def link gambasIdentifier		Identifier
hi def link gambasInclude		Include
hi def link gambasGenericFunction	Function
hi def link gambasLabel		Label
hi def link gambasLineNumber		Label
hi def link gambasMathOperator	Operator
hi def link gambasNumber		Number
hi def link gambasSpecial		Special
hi def link gambasTodo		Todo

let b:current_syntax = "gambas"

" vim: ts=8
