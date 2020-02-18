grep "Saving dict for global step " l2_fp32_v100.log |awk '{print substr($6,1,length($6)-1) " " substr($9,1,length($9)-1) " " substr($12,1,length($12)-1)}' > a2_fp32_v100.p
grep "Saving dict for global step " ../../image_classification_BF16/tensorflow/l3_bf16_fpbp_v100.log |awk '{print substr($6,1,length($6)-1) " " substr($9,1,length($9)-1) " " substr($12,1,length($12)-1)}' > a3_bf16_fpbp_v100.p
grep "Saving dict for global step " l11_fp32_rmModeldie_v100.log |awk '{print substr($6,1,length($6)-1) " " substr($9,1,length($9)-1) " " substr($12,1,length($12)-1)}' > a11_fp32_rmModeldie_v100.p
grep "Saving dict for global step " ../../image_classification_BF16/tensorflow/cuda_bf16cut_1.log |awk '{print substr($6,1,length($6)-1) " " substr($9,1,length($9)-1) " " substr($12,1,length($12)-1)}' > cuda_bf16cut_1.p
grep "Saving dict for global step " fp32_3.log |awk '{print substr($6,1,length($6)-1) " " substr($9,1,length($9)-1) " " substr($12,1,length($12)-1)}' > fp32_3.p

#gnuplot -p -e  'set xlabel "Steps";set ylabel "Accuracy";set key bottom right;plot "a2_fp32_v100" u 1:2 w linesp title "Top 1 accuracy", "" u 1:3 w linesp title "Top 5 accuracy", 0.749 title "target 0.749"'
gnuplot -p -e  'set yrange [:0.8];set xlabel "Steps";set ylabel "Accuracy";set key bottom right; plot "a2_fp32_v100.p" u 1:2 w linesp title "FP32 Top 1 accuracy", 0.749 title "target 0.749", "a3_bf16_fpbp_v100.p" u 1:2 w linesp title "BF16 Top 1 accuracy", "a11_fp32_rmModeldie_v100.p" u 1:2 w linesp title "FP32 top 1 accuracy 2" , "cuda_bf16cut_1.p" u 1:2 w linesp , "fp32_3.p" u 1:2 w linesp'
