grep "Epoch.*HR" log1_v100.log |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p1_v100.p
grep "Epoch.*HR" log2_v100.log |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p2_v100.p
grep "Epoch.*HR" log3_k80.log  |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p3_k80.p
grep "Epoch.*HR" log4_k80.log  |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p4_k80.p
#grep "Epoch.*HR" lbf16_1   |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p5_bf16_k80
# from incorrect bf16cut operator that return nan from zero value
#grep "Epoch.*HR" lbf16_v100|awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p6_bf16_v100
#grep "Epoch.*HR" log7_bf16_fb_v100 |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p7_bf16_fb_v100
#grep "Epoch.*HR" log8_bf16_fb_goodNeg_v100 |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p8_bf16_fb_goodNeg_v100
grep "Epoch.*HR" log10_bf16_fb_v100.log |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p10_bf16_fb_v100.p
grep "Epoch.*HR" log12_bf12_fb_v100.log |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p12_bf12_fb_v100.p
grep "Epoch.*HR" log13_bf10_fb_v100.log |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p13_bf10_fb_v100.p
grep "Epoch.*HR" log14_bf9_fb_v100.log |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p14_bf9_fb_v100.p
grep "Epoch.*HR" log15_bf16_fpbpMod_v100.log |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p15_bf16_fpbpMod_v100.p
grep "Epoch.*HR" log17_bf16_fpbpMod_v100.log |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p17_bf16_fpbpMod_v100.p
grep "Epoch.*HR" log18_bf12_fpbpmod_correct256to16_v100.log |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p18_bf12_fpbpmod_correct256to16_v100.p
grep "Epoch.*HR" log19_bf10_fpbpMod_merge_v100.log |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p19_bf10_fpbpMod_merge_v100.p
grep "Epoch.*HR" fp32_1.log |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > fp32_1.p
grep "Epoch.*HR" ../../recommendation_bf16/pytorch/bf16_1.log |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > bf16_1.p

#gnuplot -p -e 'set xlabel "Epoch";set ylabel "Precision";set key right bottom;plot "p1_v100" u 1:2 w linesp , "p2_v100" u 1:2 w linesp, "p3_k80" u 1:2 w linesp,"p4_k80" u 1:2 w linesp,"p10_bf16_fb_v100" u 1:2 w linesp, "p12_bf12_fb_v100" u 1:2 w linesp title "4 bit mantissa", "p13_bf10_fb_v100" u 1:2 w linesp title "2 bit mantissa", "p14_bf9_fb_v100" u 1:2 w linesp title "1 bit mantissa" , "p15_bf16_fpbpMod_v100" u 1:2 w linesp title "bf16 two dir operator"'
#gnuplot -p -e 'set xlabel "Epoch";set ylabel "Precision";set key right bottom;plot "p1_v100.p" u 1:2 w linesp , "p2_v100.p" u 1:2 w linesp, "p3_k80.p" u 1:2 w linesp,"p4_k80.p" u 1:2 w linesp, "p15_bf16_fpbpMod_v100.p" u 1:2 w linesp title "bf16 8 bit mantissa", 0.635 title "Target 0.635" , "p17_bf16_fpbpMod_v100.p" u 1:2 w linesp title "bf16" , "p18_bf12_fpbpmod_correct256to16_v100.p" u 1:2 w linesp title "4 bit mantissa" , "p19_bf10_fpbpMod_merge_v100.p" u 1:2 w linesp title "2 bit mantissa", "fp32_1.p" u 1:2 w linesp title "fp32" , "bf16_1.p" u 1:2 w linesp title "bf16 on both feature, weight and gradient"'
gnuplot -p -e 'set xlabel "Epoch";set ylabel "Precision";set key right bottom;plot "p1_v100.p" u 1:2 w linesp , "p2_v100.p" u 1:2 w linesp, "p3_k80.p" u 1:2 w linesp,"p4_k80.p" u 1:2 w linesp,  0.635 title "Target 0.635" , "fp32_1.p" u 1:2 w linesp title "fp32" , "bf16_1.p" u 1:2 w linesp title "bf16 on both feature, weight and gradient"'

