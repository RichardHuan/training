grep maskrcnn_benchmark.trainer l1|awk '{if($10%200 == 0 ){print  $10 " " $12}}' > fp32_1.loss
grep maskrcnn_benchmark.trainer l1|awk '{if($5=="eta:") { if($7=="iter:") {save=$8} else {save=$10} } else if ($6=="mAP:") {print save " " $7 " " $10} }' > fp32_1.map

grep maskrcnn_benchmark.trainer ../../object_detection_BF16/pytorch/bf16_1.log|awk '{if($10%200 == 0){print  $10 " " $12}}' > bf16_1.loss
grep maskrcnn_benchmark.trainer ../../object_detection_BF16/pytorch/bf16_1.log|awk '{if($5=="eta:") {save=$10 } else if ($6=="mAP:") {print save " " $7 " " $10} }' > bf16_1.map

#gnuplot -p -e 'set key left top;set xlabel "Iteration";set ylabel "loss";set y2label "mAP(bbox/segm)";set ytics nomirror; set y2tics 0.1,0.01;plot "fp32_1.map" u 1:2 w linesp axis x1y2 title "FP32 BBOX mAP", "fp32_1.map" u 1:3 w linesp axis x1y2 title "FP32 SEGM mAP", "fp32_1.loss" u 1:2 axis  x1y1 title "FP32 loss", "bf16_1.map" u 1:2 w linesp axis x1y2 title "BF16 BBOX mAP", "bf16_1.map" u 1:3 w linesp axis x1y2 title "BF16 SEGM mAP", "bf16_1.loss" u 1:2 axis  x1y1 title "BF16 loss" lt rgb "violet"'
gnuplot -p -e 'set size 2,1 ; set multiplot layout 2,1; set ylabel "mAP(bbox/segm)";plot "fp32_1.map" u 1:2 w linesp title "FP32 BBOX mAP", "fp32_1.map" u 1:3 w linesp title "FP32 SEGM mAP", "bf16_1.map" u 1:2 w linesp title "BF16 BBOX mAP", "bf16_1.map" u 1:3 w linesp  title "BF16 SEGM mAP"; set xlabel "Iteration";set ylabel "Loss"; plot "fp32_1.loss" u 1:2  title "FP32 loss",  "bf16_1.loss" u 1:2  title "BF16 loss" ;unset multiplot'

