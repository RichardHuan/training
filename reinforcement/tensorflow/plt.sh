grep ^accuracy l1 > a1
grep ^accuracy l2 > a2
grep ^accuracy l5 > a5


gnuplot -p -e 'plot "a1" u 0:3 w linesp, "a2" u 0:3 w linesp,"a5" u 0:3 w linesp'

