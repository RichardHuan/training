gnuplot -p -e '
  f(n,e,m) = (e+n*(1+m))/(n*(1+e+m));
  f824(x)=f(x,8,24);
  f87(x)=f(x,8,7);
  f84(x)=f(x,8,4);
  plot [1:32] f824(x) title "Saving on FP32" , f87(x) title "Saving on BF16", f84(x) title "Saving in BF12"
'
