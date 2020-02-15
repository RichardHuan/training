grep maskrcnn_benchmark.trainer l1|awk '{if($10%100 == 0 ){print  $10 " " $12}}' > fp32_1.loss
grep maskrcnn_benchmark.trainer l1|awk '{if($5=="eta:") {save=$10 } else if ($6=="mAP:") {print save " " $7 " " $10} }' > fp32_1.map

grep maskrcnn_benchmark.trainer ../../object_detection_BF16/pytorch/bf16_1.log|awk '{if($10%100 == 0){print  $10 " " $12}}' > bf16_1.loss
grep maskrcnn_benchmark.trainer ../../object_detection_BF16/pytorch/bf16_1.log|awk '{if($5=="eta:") {save=$10 } else if ($6=="mAP:") {print save " " $7 " " $10} }' > bf16_1.map

gnuplot -p -e 'set ytics nomirror; set y2tics 0.1,0.01;plot "fp32_1.map" u 1:2 w linesp axis x1y2, "fp32_1.map" u 1:3 w linesp axis x1y2, "fp32_1.loss" u 1:2 axis  x1y1 , "bf16_1.map" u 1:2 w linesp axis x1y2, "bf16_1.map" u 1:3 w linesp axis x1y2, "bf16_1.loss" u 1:2 axis  x1y1'

