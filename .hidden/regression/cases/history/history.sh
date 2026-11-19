# history: hh lists, N! runs an entry again, [N]find/replace/ edits an entry; lines come from stdin
cat <<'X' | $GSH 2>&1 | grep -v " > \["
clearhist
echo hello world
hh
1!
[1]hello/goodbye/
1!
hist
X
