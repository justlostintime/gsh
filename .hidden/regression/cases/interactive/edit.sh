# edit typed in a block: the editor gets the lines so far, an incomplete block continues at its indent;
# an editor that completes the block runs it at once
. "$REGRESSION/pty.inc"
printf '#!/bin/sh\nexit 0\n' > "$WORK/ed0"; printf '#!/bin/sh\necho next >> "$1"\n' > "$WORK/ed1"; chmod +x "$WORK"/ed?
pty_run "
key '\$editor = \"$WORK/ed0\"'; pause 0.6
key 'for i as integer = 1 to 2'; pause 0.4; key 'print \"a=\";i'; pause 0.4; key edit; pause 2
key 'print \"b=\";i'; pause 0.5; key next; pause 1.5
key '\$editor = \"$WORK/ed1\"'; pause 0.6
key 'for i as integer = 1 to 2'; pause 0.4; key 'print \"c=\";i'; pause 0.4; key edit; pause 2.5
" | grep -E "^[abc]=[0-9]"
