$zqj = "Print quote(\"hello\")"
? @zqj
$zqc = "Print \"hi\""
!@zqc | tr a-z A-Z
echo abc | @zqc
ls nnnnvvvv 2> /dev/null || @zqc
? @zqc & " more data"
$zqmv = "x"
echo mv is still a command
vardel zqj
vardel zqc
vardel zqmv
