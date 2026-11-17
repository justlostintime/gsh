cd d1 && ls
pwd
cd ..
cd nosuchdir && echo BAD1
cd nosuchdir || echo OR1-OK
cd nosuchdir && echo BAD2 || echo OR2-OK
cd d1 && cd .. && echo AND2-OK
pwd
cd nosuchdir
echo "status after failed cd" $?
cd d1
echo "status after good cd" $?
cd ..
!cd nosuchdir && echo BAD3
!cd nosuchdir || echo OR3-OK
!cd d1 && echo AND3-OK
ls d1 && echo AND4-OK
Sub zqret(n As Integer) As Integer
  Return n
End
zqret 3 && echo BAD5
zqret 3 || echo OR5-OK
zqret 0 && echo AND5-OK
!zqret 3 || echo OR6-OK
!zqret 0 && echo AND6-OK
cd d1 && ls :; pwd
cd ..
Sub zqnoret(s As String)
  Print "noret";; s
End
zqnoret a && echo AND7-OK
zqnoret a || echo BAD7
echo END
