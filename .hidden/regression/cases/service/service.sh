# -d service mode reads commands from stdin and stops at its end
printf 'echo hi from service\nprint 6*7\n' | timeout 10 $GSH -d 2>&1 | head -6 | sed 's/service mode .*/service mode/'
