sub zqadd(a as integer, b as integer) as integer
  return a + b
end
print zqadd(2, 3)
sub zqgreet(Optional name as string = "world")
  print "hello";; name
end
zqgreet
zqgreet("gsh")
Class zqcounter
  Public Total As Integer
  Public Sub Add(n As Integer)
    Total += n
  End
End Class
Begin
  Dim c As New zqcounter
  c.Add(2)
  c.Add(3)
  Print "total="; c.Total
End
