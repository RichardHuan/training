grep "^Epoch" l1_conv_fp32_v100 |awk '{print $3 " " $7 " " $15}' > a1_conv_fp32_v100
grep "^Epoch" l2_lstm_fp32_v100 |awk '{print $3 " " $7 " " $15}' > a2_lstm_fp32_v100

gnuplot -p -e 'set xlabel "Epoch"; set ylabel "Accuracy";plot "a1_conv_fp32_v100" u 1:3 w linesp, "a2_lstm_fp32_v100" u 1:3 w linesp'
