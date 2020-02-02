grep "^Accuracy" l1_bf32_v100| awk '{print substr($4,1,length($4)-1) " "  $5}' > a1

gnuplot -p -e 'plot "a1" u 1:2 w linesp'
