# fed through stdin, like typing at the prompt: subs keep their own names
cat <<'X' | $GSH
sub zqdoc() as string
''' zqdoc summary line
'' zqdoc description line
  return "doc"
end
print sharedmem["sub.zqdoc"] Like "*zqdoc description line*"
X
