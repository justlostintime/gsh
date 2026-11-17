cd /tmp && ls -d /tmp
pwd
cd /nodir && ls || echo "no such directory"
cd /nodir
print $?
ls /nodir 2> /dev/null && echo found || echo missing
Sub IsSmall(n As Integer) As Boolean
  Return n < 3
End
For i As Integer = 1 To 4
  IsSmall i && echo {i} is small || echo {i} is big
Next
!cd /nodir || echo "cd failed"
