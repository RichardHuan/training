grep "^Epoch" l1_conv_seed1_fp32_v100|awk '{print $3 " " $7 " " $15}' > a1_conv_seed1_fp32_v100
grep "^Epoch" l2_lstm_seed1_fp32_v100 |awk '{print $3 " " $7 " " $15}' > a2_lstm_seed1_fp32_v100
grep "^Epoch" l3_conv_seed2_fp32_v100 |awk '{print $3 " " $7 " " $15}' > a3_conv_seed2_fp32_v100
grep "^Epoch" l4_conv_seed3_fp32_v100 |awk '{print $3 " " $7 " " $15}' > a4_conv_seed3_fp32_v100
grep "^Epoch" l5_conv_seed5_fp32_v100 |awk '{print $3 " " $7 " " $15}' > a5_conv_seed5_fp32_v100

gnuplot -p -e 'set xlabel "Epoch"; set ylabel "Accuracy";plot "a1_conv_seed1_fp32_v100" u 1:3 w linesp, "a2_lstm_seed1_fp32_v100" u 1:3 w linesp,  "a3_conv_seed2_fp32_v100" u 1:3 w linesp, "a4_conv_seed3_fp32_v100" u 1:3 w linesp, "a5_conv_seed5_fp32_v100" u 1:3 w linesp'
