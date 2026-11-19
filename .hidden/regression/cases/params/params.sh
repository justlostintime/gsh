# $0 $1..$n $# $* $@ in a script
cat > p.gsh <<'X'
print "0=";$0
print "1=";$1;" 2=";$2;" 3=";$3
print "#=";$#
print "*=";$*
for each s as string in $@
  print "@ ";s
next
X
$GSH p.gsh a b "c d"
echo "--- no args"
$GSH p.gsh
