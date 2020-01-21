grep "Epoch.*HR" log1_v100 |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p1_v100
grep "Epoch.*HR" log2_v100 |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p2_v100
grep "Epoch.*HR" log3_k80  |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p3_k80
grep "Epoch.*HR" log4_k80  |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p4_k80
#grep "Epoch.*HR" lbf16_1   |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p5_bf16_k80

gnuplot -p -e 'set key right bottom;plot "p1_v100" u 1:2 w linesp , "p2_v100" u 1:2 w linesp, "p3_k80" u 1:2 w linesp,"p4_k80" u 1:2 w linesp,"p5_bf16_k80" u 1:2 w linesp'

