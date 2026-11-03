
sub thistest()
   print "this message";;
   $b="that message"
end

do
  for i as integer = 0 to 100
  thistest()
  next
  print
  print "B set to >";;$b
done




