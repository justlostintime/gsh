$zqprog = "print \"prog got \" & $1"
print runvar("zqprog", "abc")
print @zqprog("def")
vardel zqprog
print sharedmem.exist("zqprog")
