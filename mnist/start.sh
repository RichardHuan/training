# usage : source start.sh <logname> <pyfile> <GPU>
if [[ $# -ne 3 ]]; then
   echo "usage : source start.sh <logname> <pyfile> <GPU>"
else
   nvprof --quiet --profile-api-trace none --print-gpu-trace --profile-child-processes --csv --log-file $1_%p.csv -o $1_%p.nvvp ./mnist.sh $2 $3
fi

