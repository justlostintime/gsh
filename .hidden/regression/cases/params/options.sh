# command line options; -c runs its command with /bin/sh, as bash and sh do
$GSH -c 'echo from -c'
$GSH -c 'echo a; echo b | tr a-z A-Z'
$GSH -c 'exit 4'; echo "-c exit=$?"
echo 'echo from stdin' | $GSH
$GSH -V | sed 's/[0-9][0-9.]*/N/'
printf '$zqv = "print \\"from -f \\" & $1"\n' | $GSH
$GSH -f zqv -- argone
printf 'vardel zqv\n' | $GSH
