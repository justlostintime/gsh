mkdir -p d/sub && touch a.txt b.txt c.log d/x.txt d/sub/y.txt .hidden.txt
cat > g.gsh <<'X'
echo *.txt
echo *.log
ls *.txt
echo d/*.txt
echo nomatch*.zz
echo "*.txt"
X
$GSH g.gsh
