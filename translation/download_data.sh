#!/bin/bash

#wget https://raw.githubusercontent.com/tensorflow/models/master/official/transformer/test_data/newstest2014.en -O tensorflow/newstest2014.en --no-check-certificate
#wget https://raw.githubusercontent.com/tensorflow/models/master/official/transformer/test_data/newstest2014.de -O tensorflow/newstest2014.de --no-check-certificate

wget https://nlp.stanford.edu/projects/nmt/data/wmt14.en-de/newstest2014.en -O tensorflow/newstest2014.en --no-check-certificate
wget https://nlp.stanford.edu/projects/nmt/data/wmt14.en-de/newstest2014.de -O tensorflow/newstest2014.de --no-check-certificate

python3 data_download.py --raw_dir raw_data
