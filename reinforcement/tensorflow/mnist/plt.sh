grep "^Accuracy" l1_fp32_v100| awk '{print substr($4,1,length($4)-1) " "  $5}' > a1_fp32_v100
grep "^Accuracy" l2_bf16_v100| awk '{print substr($4,1,length($4)-1) " "  $5}' > a2_bf16_v100
grep "^Accuracy" l3_bf16_v100| awk '{print substr($4,1,length($4)-1) " "  $5}' > a3_bf16_v100
grep "^Accuracy" l4_bf16_v100| awk '{print substr($4,1,length($4)-1) " "  $5}' > a4_bf16_v100
grep "^Accuracy" l5_bf16_v100| awk '{print substr($4,1,length($4)-1) " "  $5}' > a5_bf16_v100
grep "^Accuracy" l6_bf15_v100| awk '{print substr($4,1,length($4)-1) " "  $5}' > a6_bf15_v100
grep "^Accuracy" l7_bf14_v100| awk '{print substr($4,1,length($4)-1) " "  $5}' > a7_bf14_v100
grep "^Accuracy" l8_bf13_v100| awk '{print substr($4,1,length($4)-1) " "  $5}' > a8_bf13_v100
grep "^Accuracy" l9_bf12_v100| awk '{print substr($4,1,length($4)-1) " "  $5}' > a9_bf12_v100
grep "^Accuracy" l10_bf11_v100| awk '{print substr($4,1,length($4)-1) " "  $5}' > a10_bf11_v100
grep "^Accuracy" l11_bf10_v100| awk '{print substr($4,1,length($4)-1) " "  $5}' > a11_bf10_v100
grep "^Accuracy" l12_bf9_v100| awk '{print substr($4,1,length($4)-1) " "  $5}' > a12_bf9_v100
grep "^Accuracy" l13_bf8_v100| awk '{print substr($4,1,length($4)-1) " "  $5}' > a13_bf8_v100
grep "^Accuracy" l14_bf7_v100| awk '{print substr($4,1,length($4)-1) " "  $5}' > a14_bf7_v100

gnuplot -p -e 'set xlabel "Epoch";set ylabel "Accuracy";set key right bottom;plot "a1_fp32_v100" u 1:2 w linesp, "a5_bf16_v100" u 1:2 w linesp, "a10_bf11_v100" u 1:2 w linesp title "3 bits mantissa","a12_bf9_v100" u 1:2 w linesp title "1 bit mantissa","a13_bf8_v100" u 1:2 w linesp title "1 bit leading 1 and no mantissa"'
