#grep ^accuracy l1 > a1
#grep ^accuracy l2 > a2
grep ^accuracy l5 > a5
#grep ^accuracy l6 > a6


#gnuplot -p -e 'plot "a1" u 0:3 w linesp, "a2" u 0:3 w linesp,"a5" u 0:3 w linesp,"a6" u 0:3 w linesp'
gnuplot -p -e 'f2(x)=b2*x+c2;fit f2(x) "a2" u 0:3 via b2,c2 ; f5(x)=b5*x+c5;fit f5(x) "a5" u 0:3 via b5,c5; plot "a2" u 0:3 w linesp,f2(x),"a5" u 0:3 w linesp,f5(x)'

