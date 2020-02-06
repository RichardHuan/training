grep "Saving dict for global step " l2_fp32_v100 |awk '{print substr($6,1,length($6)-1) " " substr($9,1,length($9)-1) " " substr($12,1,length($12)-1)}' > a2_fp32_v100

gnuplot -p -e 'plot "a2_fp32_v100" u 1:2 w linesp, "" u 1:3 w linesp'
