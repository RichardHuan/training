grep "^Bleu score (cased)"  l1_fp32_v100.log | awk '{print $NF}' > a1_fp32_v100.p
grep "^Bleu score (cased)"  ../fp32_1.log    | awk '{print $NF}' > fp32_1.p

gnuplot -p -e 'set xlabel "Iteration";set ylabel "Bleu score (cased)";set key bottom right;plot "a1_fp32_v100.p" u 0:1 w linesp , "fp32_1.p" u 0:1 w linesp'
