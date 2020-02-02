grep "^Accuracy" l1_fp32_v100| awk '{print substr($4,1,length($4)-1) " "  $5}' > a1_fp32_v100
grep "^Accuracy" l2_bf16_v100| awk '{print substr($4,1,length($4)-1) " "  $5}' > a2_bf16_v100
grep "^Accuracy" l3_bf16_v100| awk '{print substr($4,1,length($4)-1) " "  $5}' > a3_bf16_v100
grep "^Accuracy" l4_bf16_v100| awk '{print substr($4,1,length($4)-1) " "  $5}' > a4_bf16_v100
grep "^Accuracy" l5_bf16_v100| awk '{print substr($4,1,length($4)-1) " "  $5}' > a5_bf16_v100

gnuplot -p -e 'set xlabel "Epoch";set ylabel "Accuracy";set key right bottom;plot "a1_fp32_v100" u 1:2 w linesp, "a2_bf16_v100" u 1:2 w linesp, "a3_bf16_v100" u 1:2 w linesp, "a4_bf16_v100" u 1:2 w linesp, "a5_bf16_v100" u 1:2 w linesp'
