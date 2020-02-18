import torch.nn as nn

from mlperf_compliance import mlperf_log

import seq2seq.data.config as config
from .seq2seq_base import Seq2Seq
from .decoder import ResidualRecurrentDecoder
from .encoder import ResidualRecurrentEncoder

# SSY seq2seq/models/seq2seq_base.py , but it do nothing, just use the decoder and encoder pass to it
class GNMT(Seq2Seq):
    def __init__(self, vocab_size, hidden_size=512, num_layers=8, bias=True,
                 dropout=0.2, batch_first=False, math='fp32',
                 share_embedding=False):

        super(GNMT, self).__init__(batch_first=batch_first)

        mlperf_log.gnmt_print(key=mlperf_log.MODEL_HP_NUM_LAYERS,
                              value=num_layers)
        mlperf_log.gnmt_print(key=mlperf_log.MODEL_HP_HIDDEN_SIZE,
                              value=hidden_size)
        mlperf_log.gnmt_print(key=mlperf_log.MODEL_HP_DROPOUT,
                              value=dropout)

        if share_embedding:
            embedder = nn.Embedding(vocab_size, hidden_size, padding_idx=config.PAD)
        else:
            embedder = None

        #SSY 1 seq2seq/models/encoder.py only nn.LSTM
        self.encoder = ResidualRecurrentEncoder(vocab_size, hidden_size,
                                                num_layers, bias, dropout,
                                                batch_first, embedder)
        # SSY 2 seq2seq/models/decoder.py  nn.Linear torch.bmm  nn.LSTM
        self.decoder = ResidualRecurrentDecoder(vocab_size, hidden_size,
                                                num_layers, bias, dropout,
                                                batch_first, math, embedder)



    def forward(self, input_encoder, input_enc_len, input_decoder):
        context = self.encode(input_encoder, input_enc_len)
        context = (context, input_enc_len, None)
        output, _, _ = self.decode(input_decoder, context)

        return output
