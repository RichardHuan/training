#grep ^accuracy l1 > a1
#grep ^accuracy l2 > a2
grep ^accuracy l5 > a5
#grep ^accuracy l6 > a6
grep ^accuracy l6_bf16_v100 > a6_bf16_v100


#gnuplot -p -e 'plot "a1" u 0:3 w linesp, "a2" u 0:3 w linesp,"a5" u 0:3 w linesp,"a6" u 0:3 w linesp'
gnuplot -p -e 'set xlabel "Epoch"; set ylabel "Accuracy" ; set key right bottom; f2(x)=b2*x+c2;fit f2(x) "a2" u 0:3 via b2,c2 ; f5(x)=b5*x+c5;fit f5(x) "a5" u 0:3 via b5,c5; f6(x)=b6*x+c6;fit f6(x) "a6_bf16_v100" u 0:3 via b6,c6;plot "a2" u 0:3 w linesp,f2(x),"a5" u 0:3 w linesp,f5(x), "a6_bf16_v100" u 0:3 w linesp, f6(x)'

