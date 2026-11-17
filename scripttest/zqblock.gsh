Sub zqbfail() As Boolean
  Return False
End
Sub zqbint(n As Integer) As Integer
  Return n
End
Sub zqbnoret(s As String)
  Print "noret";; s
End
if true then
  cd nosuchdir && echo BAD-B1 || echo OR-B1-OK
  zqbfail && echo BAD-B2
  zqbfail || echo OR-B2-OK
  ls d1 && echo AND-B3-OK
  ls nosuchdir && echo BAD-B3 || echo OR-B3-OK
  zqbnoret x && echo AND-B5-OK
  cd d1 && ls && echo AND-B6-OK
endif
for i as integer = 0 to 2
  zqbint i && echo "AND-B4-OK only for 0:" {i} || echo "OR-B4-OK" {i}
next
pwd
echo AFTER
