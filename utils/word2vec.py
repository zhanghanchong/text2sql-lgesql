#coding=utf8

from embeddings import GloveEmbedding, KazumaCharEmbedding
import numpy as np
from utils.constants import PAD
import torch, random

class Word2vecUtils():

    def __init__(self):
        super(Word2vecUtils, self).__init__()
        self.word_embed = GloveEmbedding('common_crawl_48', d_emb=300)
        self.char_embed = KazumaCharEmbedding()
        self.initializer = lambda: np.random.normal(size=300).tolist()

    def load_embeddings(self, module, vocab, device='cpu'):
        """ Initialize the embedding with glove and char embedding
        """
        emb_size = module.weight.data.size(-1)
        assert emb_size in [300, 400], 'Embedding size is neither 300 nor 400'
        outliers = 0
        for word in vocab.word2id:
            if word == PAD: # PAD symbol is always 0-vector
                module.weight.data[vocab[PAD]] = torch.zeros(emb_size, dtype=torch.float, device=device)
                continue
            word_emb = self.word_embed.emb(word, default='none')
            if word_emb[0] is None: # oov
                word_emb = self.initializer()
                outliers += 1
            char_emb = self.char_embed.emb(word) if emb_size == 400 else []
            module.weight.data[vocab[word]] = torch.tensor(word_emb + char_emb, dtype=torch.float, device=device)
        return 1 - outliers / float(len(vocab))