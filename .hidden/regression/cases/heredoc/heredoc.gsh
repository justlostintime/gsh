$zqname = "World"
cat << EOF
Hello $zqname, 1 + 2 = {(1+2)}
EOF
for i as integer = 1 to 2
  cat << EOF
pass {i} of 2
EOF
next
cat << "EOF"
kept $zqname {(1+2)}
EOF
cat <<- END
	tab removed
	END
cat << eof
lower case end
EOF
vardel zqname
