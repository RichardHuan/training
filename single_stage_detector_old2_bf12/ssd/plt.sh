grep "^Current AP" l2_bf16_v100 > a2_bf16_v100

gnuplot -p -e 'set logscale y;set xlabel "Iteration*10000";set ylabel "Accuracy";plot "a2_bf16_v100" u 0:3 w linesp, "a2_bf16_v100" u 0:6 w linesp title "target"'


