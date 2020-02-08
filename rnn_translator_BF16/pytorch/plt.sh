grep eval_accuracy l1_fp32_v100 |awk '{print substr($7,1,length($7)-1) " " substr($NF,1,length($NF)-1)}' > a1_fp32_v100
grep eval_accuracy l2_bf16_v100 |awk '{print substr($7,1,length($7)-1) " " substr($NF,1,length($NF)-1)}' > a2_bf16_v100


gnuplot -p -e 'set key bottom right;set xlabel "Epoch";set ylabel "Accuracy";plot "a1_fp32_v100" u 1:2 w linesp, 21.8 title "target", "a2_bf16_v100" u 1:2 w linesp'

