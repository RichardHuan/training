grep "Saving dict for global step " l2_fp32_v100 |awk '{print substr($6,1,length($6)-1) " " substr($9,1,length($9)-1) " " substr($12,1,length($12)-1)}' > a2_fp32_v100
grep "Saving dict for global step " ../../image_classification_BF16/tensorflow/l3_bf16_fpbp_v100 |awk '{print substr($6,1,length($6)-1) " " substr($9,1,length($9)-1) " " substr($12,1,length($12)-1)}' > a3_bf16_fpbp_v100
grep "Saving dict for global step " l11_fp32_rmModeldie_v100 |awk '{print substr($6,1,length($6)-1) " " substr($9,1,length($9)-1) " " substr($12,1,length($12)-1)}' > a11_fp32_rmModeldie_v100

#gnuplot -p -e  'set xlabel "Steps";set ylabel "Accuracy";set key bottom right;plot "a2_fp32_v100" u 1:2 w linesp title "Top 1 accuracy", "" u 1:3 w linesp title "Top 5 accuracy", 0.749 title "target 0.749"'
gnuplot -p -e  'set yrange [:0.8];set xlabel "Steps";set ylabel "Accuracy";set key bottom right; plot "a2_fp32_v100" u 1:2 w linesp title "FP32 Top 1 accuracy", 0.749 title "target 0.749", "a3_bf16_fpbp_v100" u 1:2 w linesp title "BF16 Top 1 accuracy", "a11_fp32_rmModeldie_v100" u 1:2 w linesp title "FP32 top 1 accuracy 2"'
