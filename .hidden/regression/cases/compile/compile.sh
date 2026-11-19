# compile name [directory] writes an executable script, ~/bin without a directory; it runs with gsh -u
cat > c.gsh <<'X'
sub zqupper(s as string) as string
  return upper(s) & "!"
end
compile zqprog
  print zqupper("compiled")
  for i as integer = 1 to 2
    echo line {i}
  next
end compile
compile zqprog2 out
  print "in out ";$1
end compile
compile zqprog3 /nonexistent/dir
  print "never"
end compile
X
mkdir out
$GSH c.gsh
head -1 ~/bin/zqprog
ls -l ~/bin/zqprog | cut -c1-10
$GSHBIN -u ~/bin/zqprog
rm -f ~/bin/zqprog
ls out
$GSHBIN -u out/zqprog2 arg1
