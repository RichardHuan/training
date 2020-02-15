grep maskrcnn_benchmark.trainer l1|awk '{print $10 " " $12}'|gnuplot -p -e 'plot "<cat"'

