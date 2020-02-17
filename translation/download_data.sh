#!/bin/bash
# dont ever tray to download, because their md5sum is not correct
# get it from git clone  https://github.com/mlperf/training_results_v0.6
#wget https://raw.githubusercontent.com/tensorflow/models/master/official/transformer/test_data/newstest2014.en -O tensorflow/newstest2014.en --no-check-certificate
#wget https://raw.githubusercontent.com/tensorflow/models/master/official/transformer/test_data/newstest2014.de -O tensorflow/newstest2014.de --no-check-certificate

#wget https://nlp.stanford.edu/projects/nmt/data/wmt14.en-de/newstest2014.en -O tensorflow/newstest2014.en --no-check-certificate
#wget https://nlp.stanford.edu/projects/nmt/data/wmt14.en-de/newstest2014.de -O tensorflow/newstest2014.de --no-check-certificate

python3 data_download.py --raw_dir raw_data
