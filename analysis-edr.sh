echo '18 0'|gmx energy -f ../md2.edr -o box-x -xvg none -b 100000

awk '{print $1, $2*3500/9.45982}' box-x.xvg > box-x2.xvg
awk '{sum+=$2;n+=1;sum2+=($2*$2)} END {print sum/n, sum2/n-(sum/n)^2}' box-x2.xvg > msf2.dat


awk '{ print $1 , $2*$2/200 }' box-x.xvg  > apl.xvg

gmx analyze -f apl.xvg -dist dist_area -bw 0.002 -xvg none



awk '{ print $1 , $2*$2 }' box-x.xvg  > area.xvg
awk '{sum+=$2;n+=1;sum2+=($2*$2)} END {print sum/n, sum2/n-(sum/n)^2}' area.xvg > msf.dat

gmx rdf -b 300000 -e 500000 -n system.ndx -bin 0.01 -f ../md2.xtc -s ../md2.tpr -ref "resname PSM and name P" -sel "resname TIP3 and name OH2" -rmax 1.5 -o rdfpo.xvg -xvg none

gmx rdf -b 300000 -e 500000 -n system.ndx -bin 0.01 -f ../md2.xtc -s ../md2.tpr -ref "resname PSM and name N" -sel "resname TIP3 and name OH2" -rmax 1.5 -o rdfpn.xvg -xvg none
