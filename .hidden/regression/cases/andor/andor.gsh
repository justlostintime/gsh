!true && echo "and ran"
!false && echo "not printed"
!false || echo "or ran"
!true || echo "not printed"
!false && echo "skipped" || echo "or after and"
ls nnnnvvvv 2> /dev/null || echo "ls failed"
echo $?
cd /tmp && pwd
