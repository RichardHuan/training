grep "^Bleu score (cased)"  l1_fp32_v100 | awk '{print $NF}' > a1_fp32_v100

gnuplot -p -e 'set xlabel "Iteration";set ylabel "Bleu score (cased)";set key bottom right;plot "a1_fp32_v100" u 0:1 w linesp'
