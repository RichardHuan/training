grep eval_accuracy l1_fp32_v100 |awk '{print substr($7,1,length($7)-1) " " substr($NF,1,length($NF)-1)}' > a1_fp32_v100
grep eval_accuracy l2_bf16_v100 |awk '{print substr($7,1,length($7)-1) " " substr($NF,1,length($NF)-1)}' > a2_bf16_v100
grep eval_accuracy l3_fp32_base25_v100 |awk '{print substr($7,1,length($7)-1) " " substr($NF,1,length($NF)-1)}' > a3_fp32_base25_v100
grep eval_accuracy ../../rnn_translator_BF16/pytorch/l4_bf16_base25_v100 |awk '{print substr($7,1,length($7)-1) " " substr($NF,1,length($NF)-1)}' > a4_bf16_base25_v100
grep eval_accuracy ../../rnn_translator_BF12/pytorch/l5_bf16_base25_v100 |awk '{print substr($7,1,length($7)-1) " " substr($NF,1,length($NF)-1)}' > a5_bf16_base25_v100


#gnuplot -p -e 'set key bottom right;set xlabel "Epoch";set ylabel "Accuracy";plot "a1_fp32_v100" u 1:2 w linesp, 25 title "target", "a2_bf16_v100" u 1:2 w linesp, "a3_fp32_base25_v100" u 1:2 w linesp, "a4_bf16_base25_v100" u 1:2 w linesp , "a5_bf16_base25_v100" u 1:2 w linesp'
gnuplot -p -e 'set key bottom right;set xlabel "Epoch";set ylabel "Accuracy";plot "a1_fp32_v100" u 1:2 w linesp, "a2_bf16_v100" u 1:2 w linesp, "a3_fp32_base25_v100" u 1:2 w linesp, "a4_bf16_base25_v100" u 1:2 w linesp , "a5_bf16_base25_v100" u 1:2 w linesp'

