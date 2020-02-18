#grep ^accuracy l1 > a1
#grep ^accuracy l2 > a2
grep ^accuracy l5.log > a5.p
#grep ^accuracy l6 > a6
grep ^accuracy l6_bf16_v100 > a6_bf16_v100.p


gnuplot -p -e 'set xlabel "Epoch"; set ylabel "Accuracy" ; set key right bottom; f2(x)=b2*x+c2;fit f2(x) "a2" u 0:3 via b2,c2 ; f5(x)=b5*x+c5;fit f5(x) "a5.p" u 0:3 via b5,c5; f6(x)=b6*x+c6;fit f6(x) "a6_bf16_v100.p" u 0:3 via b6,c6;plot "a2" u 0:3 w linesp,f2(x),"a5.p" u 0:3 w linesp,f5(x), "a6_bf16_v100.p" u 0:3 w linesp, f6(x)'

