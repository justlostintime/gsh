!mkdir -p one/two
cd one
pwd
cd two
!pwd
cd ..
cd ..
print File.Name(Env["PWD"]) Like "gsh-regression-work-*"
cd /tmp
pwd
cd nnnnvvvv
print "after bad cd"
