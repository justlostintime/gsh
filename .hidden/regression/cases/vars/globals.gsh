$a = 24
print $a
$b = $a * 2
print $b
$s = "text"
print $s & " more"
$arr = ["x", "y", "z"]
print $arr.Count, $arr[1]
vardel a
print sharedmem.exist("a")
$t = 1
$t = "now a string"
print $t, TypeOf($t)
vardel b
vardel s
vardel arr
vardel t
print sharedmem.exist("b"), sharedmem.exist("t")
