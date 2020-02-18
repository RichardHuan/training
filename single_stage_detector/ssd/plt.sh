cat l1_fp32_v100.log                                               |sed 's+\r+\n+g' | awk '{if($1=="Iteration:") {ite=substr($2,1,length($2)-1)} else if($0 ~ /Current AP/) {print ite " " $3 " " $6}}'> a1_fp32_v100.p
cat ../../single_stage_detector_native_bf16//ssd/bf16_native_1.log |sed 's+\r+\n+g' | awk '{if($1=="Iteration:") {ite=substr($2,1,length($2)-1)} else if($0 ~ /Current AP/) {print ite " " $3 " " $6}}'> bf16_native_1.p
cat ../../single_stage_detector_native_bf16//ssd/bf12_native_1.log |sed 's+\r+\n+g' | awk '{if($1=="Iteration:") {ite=substr($2,1,length($2)-1)} else if($0 ~ /Current AP/) {print ite " " $3 " " $6}}'> bf12_native_1.p

cat l1_fp32_v100.log                                               |sed 's+\r+\n+g' | awk '{if($1=="Iteration:") {print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1) " " $NF}}' | awk '{if($1%1000==0){print}}'> a1_fp32_v100.loss
cat ../../single_stage_detector_native_bf16//ssd/bf16_native_1.log |sed 's+\r+\n+g' | awk '{if($1=="Iteration:") {print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1) " " $NF}}' | awk '{if($1%1000==0){print}}'> bf16_native_1.loss
cat ../../single_stage_detector_native_bf16//ssd/bf12_native_1.log |sed 's+\r+\n+g' | awk '{if($1=="Iteration:") {print substr($2,1,length($2)-1) " " substr($5,1,length($5)-1) " " $NF}}' | awk '{if($1%1000==0){print}}'> bf12_native_1.loss


gnuplot -p -e '
  set key left top;
  set xlabel "Iteration";
  set y2label "Accuracy";
  set ylabel "Loss";
  set ytics nomirror; 
  set yrange  [2.5:10];
  set y2tics 0,0.01,0.25;
  plot 
   0.212 axis x1y2 title "target",
   "a1_fp32_v100.p"     u 1:2 w linesp axis x1y2 title "fp32",
   "bf16_native_1.p"    u 1:2 w linesp axis x1y2 title "bf16 on 3 directions" ,
   "bf12_native_1.p"    u 1:2 w linesp axis x1y2 title "bf12 4 bit mantissa",
   "a1_fp32_v100.loss"  u 1:2          axis x1y1 title "fp32 loss",
   "bf16_native_1.loss" u 1:2          axis x1y1 title "bf16 loss",
   "bf12_native_1.loss" u 1:2          axis x1y1 title "bf12 loss"
'

#   "a1_fp32_v100.loss"  u 1:3 w linesp axis x1y1 title "fp32 loss avg",
#   "bf16_native_1.loss" u 1:3 w linesp axis x1y1 title "bf16 loss avg",
#   "bf12_native_1.loss" u 1:3 w linesp axis x1y1 title "bf12 loss avg"

