# |> sends the output to several commands, |< feeds several commands into one, a sub as a filter,
# a sub as the source of <<<, a sub as a sink of >, &| &|> &|< with stderr
touch b.txt a.txt c.txt
cat > p.gsh <<'X'
!ls *.txt |> cat > $zqb | sort -r
print "b=";Replace($zqb, "\n", ",")
!ls -1 *.txt |> sort -r > $zqa | sort > $zqb
print "a=";Replace($zqa, "\n", ","); " b=";Replace($zqb, "\n", ",")
cat |< echo one |< echo two | sort
sub zqdog()
  dim buffer as string
  while not eof()
    try line input buffer
    if error then break
    print "bark..";buffer
  wend
  print "Ruff!"
end
!ls -1 *.txt | zqdog
sub zqsource() as string
  return "from source"
end
cat <<< zqsource()
sub zqsink(data as string)
  print "sink got:";; Trim(data)
end
echo to sink > zqsink
ls nnnnvvvv &|> cat | sort
sort &|< ls a.txt nnnnvvvv
vardel zqa, zqb
X
$GSH p.gsh
