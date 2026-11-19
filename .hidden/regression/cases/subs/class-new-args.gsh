Class zqshape
  Public Name As String
  Public Sub _new(n As String)
    Name = n
  End
  Public Function Describe() As String
    Return "shape " & Name
  End
End Class
Begin
  Dim s As New zqshape("square")
  Print s.Describe()
End
