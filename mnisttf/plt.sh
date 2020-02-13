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
grep "^Accuracy" l15_bf16_fpbp_v100| awk '{print substr($4,1,length($4)-1) " "  $5}' > a15_bf16_fpbp_v100
grep "^Accuracy" l16_bf12_fpbp_v100| awk '{print substr($4,1,length($4)-1) " "  $5}' > a16_bf12_fpbp_v100
grep "^Accuracy" l17_bf10_fpbp_v100| awk '{print substr($4,1,length($4)-1) " "  $5}' > a17_bf10_fpbp_v100
grep "^Accuracy" l18_bf9_fpbp_v100| awk '{print substr($4,1,length($4)-1) " "  $5}' > a18_bf9_fpbp_v100
grep "^Accuracy" l19_bf8_fpbp_v100| awk '{print substr($4,1,length($4)-1) " "  $5}' > a19_bf8_fpbp_v100
grep "^Accuracy" l20_bf16_fpbit_bpmerge_v100| awk '{print substr($4,1,length($4)-1) " "  $5}' > a20_bf16_fpbit_bpmerge_v100
grep "^Accuracy" l21_bf12_fpbit_bpmerge_v100| awk '{print substr($4,1,length($4)-1) " "  $5}' > a21_bf12_fpbit_bpmerge_v100
grep "^Accuracy" l22_bf10_fpbit_bpmerge_v100| awk '{print substr($4,1,length($4)-1) " "  $5}' > a22_bf10_fpbit_bpmerge_v100
grep "^Accuracy" l23_bf9_fpbit_bpmerge_v100| awk '{print substr($4,1,length($4)-1) " "  $5}' > a23_bf9_fpbit_bpmerge_v100
grep "^Accuracy" l24_bf8_fpbit_bpmerge_v100| awk '{print substr($4,1,length($4)-1) " "  $5}' > a24_bf8_fpbit_bpmerge_v100

grep "^Accuracy" cuda_fp32_1.log | awk '{print substr($4,1,length($4)-1) " "  $5}' > fp32
grep "^Accuracy" bf16_l2.log     | awk '{print substr($4,1,length($4)-1) " "  $5}' > bf16


#gnuplot -p -e 'set xlabel "Epoch";set ylabel "Accuracy";set key right bottom;set yrange [0.8:0.97] ; plot "a1_fp32_v100" u 1:2 w linesp title "fp32", "a15_bf16_fpbp_v100" u 1:2 w linesp title "bf16 8 bit mantissa", "a16_bf12_fpbp_v100" u 1:2 w linesp title "4 bit mantissa", "a17_bf10_fpbp_v100" u 1:2 w linesp title "2 bit mantissa", "a18_bf9_fpbp_v100" u 1:2 w linesp title "1 bit mantissa", "a19_bf8_fpbp_v100" u 1:2 w linesp title "leading 1 without mantissa", "a20_bf16_fpbit_bpmerge_v100" u 1:2 w linesp title "bf16 8 bit mantissa with fp bit shift", "a21_bf12_fpbit_bpmerge_v100" u 1:2 w linesp title "4 bit mantissa with fp bit shift", "a22_bf10_fpbit_bpmerge_v100" u 1:2 w linesp title "2 bit mantissa with fp bit shift", "a23_bf9_fpbit_bpmerge_v100"  u 1:2 w linesp title "1 bit mantissa with fp bit shift", "a24_bf8_fpbit_bpmerge_v100" u 1:2 w linesp title "leading 1 bit without mantissa with fp bit shift"'
#gnuplot -p -e 'set xlabel "Epoch";set ylabel "Accuracy";set key right bottom;set yrange [0.8:0.97] ; plot "a1_fp32_v100" u 1:2 w linesp title "fp32",  "a20_bf16_fpbit_bpmerge_v100" u 1:2 w linesp title "bf16 8 bit mantissa with fp bit shift", "a21_bf12_fpbit_bpmerge_v100" u 1:2 w linesp title "4 bit mantissa with fp bit shift", "a22_bf10_fpbit_bpmerge_v100" u 1:2 w linesp title "2 bit mantissa with fp bit shift", "a23_bf9_fpbit_bpmerge_v100"  u 1:2 w linesp title "1 bit mantissa with fp bit shift", "a24_bf8_fpbit_bpmerge_v100" u 1:2 w linesp title "leading 1 bit without mantissa with fp bit shift"'
gnuplot -p -e 'plot "bf16" u 1:2 w linesp, "fp32" u 1:2 w linesp'
