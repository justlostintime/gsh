printf 'print 1/0\n' > e.gsh
$GSH e.gsh > /dev/null 2>&1; echo "runtime error exit=$?"
printf 'ls nnnnvvvv 2> /dev/null\n' > f.gsh
$GSH f.gsh; echo "failed command exit=$?"
printf 'print "before"\nquit 3\nprint "after"\n' > q.gsh
$GSH q.gsh; echo "quit 3 exit=$?"
printf 'quit\n' > q0.gsh
$GSH q0.gsh; echo "quit exit=$?"
printf 'exit\n' > x.gsh
$GSH x.gsh; echo "exit exit=$?"
echo 'quit 5' | $GSH; echo "quit 5 from stdin exit=$?"
printf 'print "ok"\n' > o.gsh
$GSH o.gsh; echo "ok exit=$?"
