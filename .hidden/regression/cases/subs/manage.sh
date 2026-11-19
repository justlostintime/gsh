# fed through stdin, like typing at the prompt: subs keep their own names
cat <<'X' | $GSH
sub zqmgmt() as string
  return "mgmt ran"
end
print zqmgmt()
print sharedmem.exist("sub.zqmgmt")
clearsubs "zqmgmt"
print sharedmem.exist("sub.zqmgmt")
$zqlv = "lvars value"
lvars zqlv
lvars zql*
vardel zqlv
lvars zqlv
X
