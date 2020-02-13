# usage : source start.sh <logname> <pyfile> <GPU>
if [[ $# -ne 3 ]]; then
   echo "usage : source start.sh <logname> <pyfile : mnist_with_summaries_bf16.py or mnist_with_summaries_fp32.py > <GPU>"
else
   #nvprof --quiet --profile-api-trace none --print-gpu-trace --profile-child-processes --csv --log-file $1_%p.csv -o $1_%p.nvvp \
  ./mnist.sh $2 $3 | tee $1.log
fi

#  CUDA_VISIBLE_DEVICES=2 python bf16cut_fp_op_test.py 
