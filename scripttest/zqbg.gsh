' a & at the end of a line with && or || runs the whole list in the background, as bash does
/usr/bin/sleep 2 && echo BG1-OK-LATE &
echo BG1-FIRST
/usr/bin/false || echo BG2-OK &
/usr/bin/false && echo BAD1 &
!( ls -d d1 && echo BG3-OK ) &
cd d1 && /usr/bin/sleep 1 && pwd &
pwd
cd nosuchdir && echo BAD2 || echo BG4-OK &
!cd d1 && echo BG5-OK &
/usr/bin/sleep 3
echo "a&b" && echo "x 2>&1"
' inside a block it is an error
if true then
ls d1 && echo BAD3 &
endif
echo END
