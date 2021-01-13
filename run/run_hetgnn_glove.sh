task=lgnn_glove_remove_nomatch
seed=999
device=0
testing='' #'--testing'
read_model_path=''

model=lgnn
add_cls='--add_cls'
ptm=''
embed_size=300
subword_aggregation=attentive-pooling
schema_aggregation=head+tail
gnn_hidden_size=256
gnn_num_layers=8
khops=4
num_heads=8
dropout=0.2
attn_drop=0.0
drop_connect=0.2

lstm=onlstm
chunk_size=8
att_vec_size=512
sep_cxt=''
lstm_hidden_size=512
lstm_num_layers=1
action_embed_size=128
field_embed_size=64
type_embed_size=64
no_context_feeding='--no_context_feeding'
no_parent_production_embed=''
no_parent_field_embed=''
no_parent_field_type_embed=''
no_parent_state=''

decode_max_step=100
batch_size=20
grad_accumulate=1
lr=5e-4
layerwise_decay=1.0
l2=1e-4
warmup_ratio=0.1
lr_schedule=linear
eval_after_epoch=60
max_epoch=100
max_norm=5
beam_size=5

python scripts/hetgnn.py --task $task --seed $seed --device $device $testing $read_model_path \
    $ptm --gnn_hidden_size $gnn_hidden_size --dropout $dropout --attn_drop $attn_drop --att_vec_size $att_vec_size \
    --model $model --khops $khops $add_cls \
    --subword_aggregation $subword_aggregation --schema_aggregation $schema_aggregation --embed_size $embed_size --gnn_num_layers $gnn_num_layers --num_heads $num_heads $sep_cxt \
    --lstm $lstm --chunk_size $chunk_size --drop_connect $drop_connect --lstm_hidden_size $lstm_hidden_size --lstm_num_layers $lstm_num_layers --decode_max_step $decode_max_step \
    --action_embed_size $action_embed_size --field_embed_size $field_embed_size --type_embed_size $type_embed_size \
    $no_context_feeding $no_parent_production_embed $no_parent_field_embed $no_parent_field_type_embed $no_parent_state \
    --batch_size $batch_size --grad_accumulate $grad_accumulate --lr $lr --l2 $l2 --warmup_ratio $warmup_ratio --lr_schedule $lr_schedule --eval_after_epoch $eval_after_epoch \
    --layerwise_decay $layerwise_decay --max_epoch $max_epoch --max_norm $max_norm --beam_size $beam_size   