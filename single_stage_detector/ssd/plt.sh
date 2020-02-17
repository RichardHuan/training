grep "^Current AP" l1_fp32_v100                                                   > a1_fp32_v100
grep "^Current AP" ../../single_stage_detector_bf16/ssd/l2_bf16_v100              > a2_bf16_v100
grep "^Current AP" ../../single_stage_detector_bf12/ssd/l3_bf12_v100              > a3_bf12_v100
grep "^Current AP" ../../single_stage_detector_bf16/ssd/l4_bf16_fpbpMOD_v100      > a4_bf16_fpbpMOD_v100
grep "^Current AP" ../../single_stage_detector_bf12/ssd/l5_bf12_fpbpMod_v100      > a5_bf12_fpbpMod_v100
grep "^Current AP" ../../single_stage_detector_bf16/ssd/l11_bf10_v100             > a11_bf10_v100
grep "^Current AP" ../../single_stage_detector_bf12/ssd/l13_bf9_v100              > a13_bf9_v100
grep "^Current AP" ../../single_stage_detector_native_bf16//ssd/bf16_native_1.log > bf16_native_1.p

#gnuplot -p -e 'set key bottom right;set xlabel "Iteration*10000";set ylabel "Accuracy";plot "a1" u 0:3 w linesp, "a1_fp32_v100" u 0:3 w linesp, "a2_bf16_v100" u 0:3 w linesp, "a3_bf12_v100" u 0:3 w linesp , "a3_bf12_v100" u 0:6 w linesp title "target", "a4_bf16_fpbpMOD_v100" u 0:3 w linesp, "a5_bf12_fpbpMod_v100" u 0:3 w linesp, "a11_bf10_v100" u 0:3 w linesp , "a13_bf9_v100" u 0:3 w linesp'
gnuplot -p -e 'set key bottom right;set xlabel "Iteration*10000";set ylabel "Accuracy";plot "a1_fp32_v100" u 0:3 w linesp, "a1_fp32_v100" u 0:6 w linesp title "target", "a4_bf16_fpbpMOD_v100" u 0:3 w linesp, "a5_bf12_fpbpMod_v100" u 0:3 w linesp title "4 bit mantissa", "a11_bf10_v100" u 0:3 w linesp title "2 bit mantissa", "a13_bf9_v100" u 0:3 w linesp title "1 bit mantissa" , "bf16_native_1.p" u 0:3 w linesp title "native bf16 on both feature, weight and gradient"'


