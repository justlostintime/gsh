{
  sub zqmm(sMsg As String)
    print "zqmm got " & sMsg
  end
  print "before"
  zqmm("abc")
}
print sharedmem.exist("sub.zqmm")
