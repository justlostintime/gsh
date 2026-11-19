for i as integer = 1 to 3
  print "for";; i
next
dim x as integer
if true then
  print "if true"
else
  print "not printed"
endif
if false then
  print "not printed"
end if
begin
  dim c as integer = 0
  while c < 3
    inc c
  wend
  print "while";; c
end
do
  dim a as string
  a = "hello world"
  print a
done
{
  print "brace lambda"
}
lambda
  print "lambda block"
end
select case 2
  case 1
    print "one"
  case 2
    print "two"
end select
begin
  dim n as integer = 0
  repeat
    inc n
  until n = 4
  print "repeat";; n
end
with sharedmem
  print "with"
end with
