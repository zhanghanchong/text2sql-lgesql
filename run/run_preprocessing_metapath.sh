#!/bin/bash

train_data='data/train.json'
dev_data='data/dev.json'
table_data='data/tables.json'
table_out='data/tables.bin'
metapath_out='data/metapaths.bin'
vocab_glove='pretrained_models/glove.42b.300d/vocab_glove.txt'
vocab='pretrained_models/glove.42b.300d/vocab.txt'
max_metapath_length=3

echo "Start to preprocess the original train dataset ..."
python -u preprocess/process_dataset.py --dataset_path $train_data --raw_table_path $table_data --table_path $table_out --output_path 'data/train.bin' --skip_large
echo "Start to preprocess the original dev dataset ..."
python -u preprocess/process_dataset.py --dataset_path $dev_data --table_path $table_out --output_path 'data/dev.bin'
echo "Start to build word vocab for the dataset ..."
python -u preprocess/build_glove_vocab.py --data_paths 'data/train.bin' --table_path $table_out --reference_file $vocab_glove --mwf 4 --output_path $vocab
echo "Start to find meta-paths ..."
python -u preprocess/process_metapath.py --dataset_path 'data/train.bin' --table_path $table_out --max_metapath_length $max_metapath_length --output_path $metapath_out
