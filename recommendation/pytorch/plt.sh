#grep "Epoch.*HR" log1_v100.log |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p1_v100.p
#grep "Epoch.*HR" log2_v100.log |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p2_v100.p
#grep "Epoch.*HR" log3_k80.log  |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p3_k80.p
#grep "Epoch.*HR" log4_k80.log  |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p4_k80.p
##grep "Epoch.*HR" lbf16_1   |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p5_bf16_k80
## from incorrect bf16cut operator that return nan from zero value
##grep "Epoch.*HR" lbf16_v100|awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p6_bf16_v100
##grep "Epoch.*HR" log7_bf16_fb_v100 |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p7_bf16_fb_v100
##grep "Epoch.*HR" log8_bf16_fb_goodNeg_v100 |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p8_bf16_fb_goodNeg_v100
#grep "Epoch.*HR" log10_bf16_fb_v100.log |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p10_bf16_fb_v100.p
#grep "Epoch.*HR" log12_bf12_fb_v100.log |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p12_bf12_fb_v100.p
#grep "Epoch.*HR" log13_bf10_fb_v100.log |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p13_bf10_fb_v100.p
#grep "Epoch.*HR" log14_bf9_fb_v100.log |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p14_bf9_fb_v100.p
#grep "Epoch.*HR" log15_bf16_fpbpMod_v100.log |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p15_bf16_fpbpMod_v100.p
#grep "Epoch.*HR" log17_bf16_fpbpMod_v100.log |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p17_bf16_fpbpMod_v100.p
#grep "Epoch.*HR" log18_bf12_fpbpmod_correct256to16_v100.log |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p18_bf12_fpbpmod_correct256to16_v100.p
#grep "Epoch.*HR" log19_bf10_fpbpMod_merge_v100.log |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > p19_bf10_fpbpMod_merge_v100.p




grep "Epoch.*HR"   fp32_1.log |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > fp32_1.p
grep "Epoch.*Loss" fp32_1.log |awk '{print $2 " " $4 " " substr($5,2,length($5)-3)}'                 > fp32_1.loss
grep "Epoch.*HR" ../../recommendation_bf16/pytorch/bf16_1.log   |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > bf16_1.p
grep "Epoch.*Loss" ../../recommendation_bf16/pytorch/bf16_1.log |awk '{print $2 " " $4 " " substr($5,2,length($5)-3)}'                 > bf16_1.loss
grep "Epoch.*HR"   ../../recommendation_bf16/pytorch/bf12_1.log |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > bf12_1.p
grep "Epoch.*Loss" ../../recommendation_bf16/pytorch/bf12_1.log |awk '{print $2 " " $4 " " substr($5,2,length($5)-3)}'                 > bf12_1.loss
grep "Epoch.*HR"   ../../recommendation_bf16/pytorch/bf10_1.log |awk '{print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1)}' > bf10_1.p
grep "Epoch.*Loss" ../../recommendation_bf16/pytorch/bf10_1.log |awk '{print $2 " " $4 " " substr($5,2,length($5)-3)}'                 > bf10_1.loss

gnuplot -p -e '
  set xlabel "Epoch";
  set ylabel "Precision";
  set key right bottom;
  plot 
   0.635 title "Target",
   "fp32_1.p" u 1:2 w linesp title "fp32" ,
   "bf16_1.p" u 1:2 w linesp title "bf16 on both feature weight and gradient",
   "bf12_1.p" u 1:2 w linesp title "bf12 with 4 bit mantissa on both feature weight and gradient" ,
   "bf10_1.p" u 1:2 w linesp title "bf10 with 2 bit mantissa on both feature weight and gradient"
'
#gnuplot -p -e '
#  set xlabel "Epoch";
#  set ylabel "Loss";
#  set y2label "Precision";
#  set ytics nomirror; 
#  set y2tics 0.1,0.01;
#  set key right bottom;
#  plot 
#  "fp32_1.p"    u 1:2 w linesp title "fp32 precision" , 
#  "fp32_1.loss" u 1:2          title "fp32 loss" , 
#  "fp32_1.loss" u 1:3 w linesp title "fp32 loss avg" , 
#  "bf16_1.p"    u 1:2 w linesp title "bf16 on both feature, weight and gradient",  
#  "bf16_1.loss" u 1:2          title "bf16 loss" , 
#  "bf16_1.loss" u 1:3 w linesp title "bf16 loss avg" , 
#  "bf12_1.p"    u 1:2 w linesp title "bf12 with 4 bit mantissa on both feature, weight and gradient" , 
#  "bf12_1.loss" u 1:2          title "bf12 loss" , 
#  "bf12_1.loss" u 1:3 w linesp title "bf12 loss avg" , 
#  "bf10_1.p"    u 1:2 w linesp title "bf10 with 2 bit mantissa on both feature, weight and gradient" ,
#  "bf10_1.loss" u 1:2          title "bf10 loss" , 
#  "bf10_1.loss" u 1:3 w linesp title "bf10 loss avg" 
#  '

