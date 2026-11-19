echo one > out.txt
echo two >> out.txt
cat out.txt
cat < out.txt
!ls > $zqa
print $zqa
cat <<< "from a string"
$zqf = "from a var"
cat <<< $zqf
cat <<< $zqf <<< "and a string"
ls nnnnvvvv 2> err.txt
cat err.txt
ls nnnnvvvv 2> $zqe
print Trim($zqe)
ls out.txt nnnnvvvv > all.txt 2>&1
sort all.txt
ls out.txt !> $zqr
print "exit";; $zqr
ls nnnnvvvv 2> $zqe !> $zqr
print "exit";; $zqr
vardel zqa
vardel zqf
vardel zqe
vardel zqr
