grep eval_accuracy l1_fp32_v100.log                                                   |awk '{print substr($7,1,length($7)-1) " " substr($NF,1,length($NF)-1)}' > a1_fp32_v100.p
grep eval_accuracy l2_bf16_v100.log                                                   |awk '{print substr($7,1,length($7)-1) " " substr($NF,1,length($NF)-1)}' > a2_bf16_v100.p
grep eval_accuracy l3_fp32_base25_v100.log                                            |awk '{print substr($7,1,length($7)-1) " " substr($NF,1,length($NF)-1)}' > a3_fp32_base25_v100.p
grep eval_accuracy l6_fp32_base25_epoch20_v100.log                                    |awk '{print substr($7,1,length($7)-1) " " substr($NF,1,length($NF)-1)}' > a6_fp32_base25_epoch20_v100.p
grep eval_accuracy ../../rnn_translator_BF16/pytorch/l7_bf16_base25_epoch20_v100.log  |awk '{print substr($7,1,length($7)-1) " " substr($NF,1,length($NF)-1)}' > a7_bf16_base25_epoch20_v100.p
grep eval_accuracy ../../rnn_translator_BF12/pytorch/l8_bf12_base25_epoch20_v100.log  |awk '{print substr($7,1,length($7)-1) " " substr($NF,1,length($NF)-1)}' > a8_bf12_base25_epoch20_v100.p
grep eval_accuracy ../../rnn_translator_BF16/pytorch/l10_bf10_base25_epoch20_v100.log |awk '{print substr($7,1,length($7)-1) " " substr($NF,1,length($NF)-1)}' > a10_bf10_base25_epoch20_v100.p
grep eval_accuracy ../../rnn_translator_BF12/pytorch/l11_bf10_base25_epoch20_v100.log |awk '{print substr($7,1,length($7)-1) " " substr($NF,1,length($NF)-1)}' > a11_bf9_base25_epoch20_v100.p
grep eval_accuracy ../../rnn_translator_3DBF16/pytorch/bf16_3dir_1.log                |awk '{print substr($7,1,length($7)-1) " " substr($NF,1,length($NF)-1)}' > bf16_3dir_1.p
grep eval_accuracy ../../rnn_translator_3DBF16/pytorch/bf12_3dir_1.log                |awk '{print substr($7,1,length($7)-1) " " substr($NF,1,length($NF)-1)}' > bf12_3dir_1.p


gnuplot -p -e '
  set key bottom right;
  set xlabel "Epoch";
  set ylabel "Accuracy";
  plot 
    21.8 title "target" , 
    "a6_fp32_base25_epoch20_v100.p"  u 1:2 w linesp , 
    "bf16_3dir_1.p"                  u 1:2 w linesp ,
    "bf12_3dir_1.p"                  u 1:2 w linesp
'

#gnuplot -p -e '
#  set key bottom right;
#  set xlabel "Epoch";
#  set ylabel "Accuracy";
#  plot 
#    21.8 title "target" , 
#    "a1_fp32_v100.p"                 u 1:2 w linesp , 
#    "a2_bf16_v100.p"                 u 1:2 w linesp , 
#    "a3_fp32_base25_v100.p"          u 1:2 w linesp , 
#    "a6_fp32_base25_epoch20_v100.p"  u 1:2 w linesp , 
#    "a7_bf16_base25_epoch20_v100.p"  u 1:2 w linesp ,
#    "a8_bf12_base25_epoch20_v100.p"  u 1:2 w linesp , 
#    "a10_bf10_base25_epoch20_v100.p" u 1:2 w linesp , 
#    "a11_bf9_base25_epoch20_v100.p"  u 1:2 w linesp ,
#    "bf16_3dir_1.p"                  u 1:2 w linesp ,
#    "bf12_3dir_1.p"                  u 1:2 w linesp
#'

