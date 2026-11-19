# fed through stdin, like typing at the prompt: subs keep their own names
cat <<'X' | $GSH
sub zqmgmt2() as string
  return "x"
end
print zqmgmt2()
clearsubs zqmgmt2
print sharedmem.exist("sub.zqmgmt2")
X
