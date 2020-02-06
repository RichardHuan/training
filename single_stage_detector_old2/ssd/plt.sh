grep "^Current AP" l1_fp32_v100 > a1_fp32_v100
grep "^Current AP" ../../single_stage_detector_old2_bf16/ssd/l2_bf16_v100 > a2_bf16_v100
grep "^Current AP" ../../single_stage_detector_old2_bf12/ssd/l3_bf12_v100 > a3_bf12_v100

gnuplot -p -e 'set xlabel "Iteration*10000";set ylabel "Accuracy";plot "a1" u 0:3 w linesp,"a1" u 0:6 w linesp, "a1_fp32_v100" u 0:3 w linesp, "a2_bf16_v100" u 0:3 w linesp, "a3_bf12_v100" u 0:3 w linesp'


