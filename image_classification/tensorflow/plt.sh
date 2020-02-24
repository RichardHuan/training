#grep "Saving dict for global step " l2_fp32_v100.log                                                 |awk '{print substr($6,1,length($6)-1) " " substr($9,1,length($9)-1) " " substr($12,1,length($12)-1)}' > a2_fp32_v100.p
#grep "Saving dict for global step " ../../image_classification_BF16/tensorflow/l3_bf16_fpbp_v100.log |awk '{print substr($6,1,length($6)-1) " " substr($9,1,length($9)-1) " " substr($12,1,length($12)-1)}' > a3_bf16_fpbp_v100.p

grep "Saving dict for global step " l11_fp32_rmModeldie_v100.log                                     |awk '{print substr($6,1,length($6)-1) " " substr($9,1,length($9)-1) " " substr($12,1,length($12)-1)}' > a11_fp32_rmModeldie_v100.p
grep "Saving dict for global step " ../../image_classification_BF16/tensorflow/cuda_bf16cut_1.log    |awk '{print substr($6,1,length($6)-1) " " substr($9,1,length($9)-1) " " substr($12,1,length($12)-1)}' > cuda_bf16cut_1.p
grep "Saving dict for global step " ../../image_classification_3dir_bf16/tensorflow/bf16_3dir_1.log  |awk '{print substr($6,1,length($6)-1) " " substr($9,1,length($9)-1) " " substr($12,1,length($12)-1)}' > bf16_3dir_1.p

grep "INFO:tensorflow:loss" l11_fp32_rmModeldie_v100.log                                     |awk '{print $6 " " substr($3,1,length($3)-1)}' | awk '{ssy=ssy+1;if(ssy%60==0) {print }}'> a11_fp32_rmModeldie_v100.loss
grep "INFO:tensorflow:loss" ../../image_classification_BF16/tensorflow/cuda_bf16cut_1.log    |awk '{print $6 " " substr($3,1,length($3)-1)}' | awk '{ssy=ssy+1;if(ssy%60==0) {print }}'> cuda_bf16cut_1.loss
grep "INFO:tensorflow:loss" ../../image_classification_3dir_bf16/tensorflow/bf16_3dir_1.log  |awk '{print $6 " " substr($3,1,length($3)-1)}' | awk '{ssy=ssy+1;if(ssy%60==0) {print }}'> bf16_3dir_1.loss

gnuplot -p -e  '
  set xlabel "Steps";
  set ylabel "Loss";
  set y2label "Accuracy" ;
  set key top left; 
  set ytics nomirror;
  set y2tics 0.35,0.05,0.8;
  set y2range [0.35:0.8];
  plot 
    0.749                                          axis x1y2  title "target 0.749", 
    "a11_fp32_rmModeldie_v100.p"    u 1:2 w linesp axis x1y2  title "FP32 Accuracy" , 
    "bf16_3dir_1.p"                 u 1:2 w linesp axis x1y2  title "BF16 3 dir Accuracy" ,
    "a11_fp32_rmModeldie_v100.loss" u 1:2          axis x1y1  title "FP32 Loss" , 
    "bf16_3dir_1.loss"              u 1:2          axis x1y1  title "BF16 3 dir Loss"
'
#gnuplot -p -e  '
#  set xlabel "Steps";
#  set ylabel "Loss";
#  set y2label "Accuracy" ;
#  set key top left; 
#  set ytics nomirror;
#  set y2tics 0.35,0.05,0.8;
#  set y2range [0.35:0.8];
#  plot 
#    0.749                                          axis x1y2  title "target 0.749", 
#    "a11_fp32_rmModeldie_v100.p"    u 1:2 w linesp axis x1y2  title "FP32 Accuracy" , 
#    "cuda_bf16cut_1.p"              u 1:2 w linesp axis x1y2  title "BF16 Accuracy" ,
#    "bf16_3dir_1.p"                 u 1:2 w linesp axis x1y2  title "BF16 3 dir Accuracy" ,
#    "a11_fp32_rmModeldie_v100.loss" u 1:2          axis x1y1  title "FP32 Loss" , 
#    "cuda_bf16cut_1.loss"           u 1:2          axis x1y1  title "BF16 Loss" ,
#    "bf16_3dir_1.loss"              u 1:2          axis x1y1  title "BF16 3 dir Loss"
#'
