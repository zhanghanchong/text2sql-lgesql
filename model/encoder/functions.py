#coding=utf8
import torch

def src_dot_dst(src_field, dst_field, out_field):
    def func(edges):
        return {out_field: (edges.src[src_field] * edges.dst[dst_field]).sum(-1, keepdim=True)}

    return func

def src_sum_edge_mul_dst(src_field, dst_field, e_field, out_field):
    def func(edges):
        return {out_field: ((edges.src[src_field] + edges.data[e_field]) * edges.dst[dst_field]).sum(-1, keepdim=True)}

    return func

def scaled_exp(field, scale_constant):
    def func(edges):
        # clamp for softmax numerical stability
        return {field: torch.exp((edges.data[field] / scale_constant).clamp(-10, 10))}

    return func

def src_sum_edge_mul_edge(src_field, e_field1, e_field2, out_field):
    def func(edges):
        return {out_field: (edges.src[src_field] + edges.data[e_field1]) * edges.data[e_field2]}

    return func

def div_by_z(in_field, norm_field, out_field):
    def func(nodes):
        return {out_field: nodes.data[in_field] / nodes.data[norm_field]}

    return func

def div_by_z_hetero(in_field0, in_field1, norm_field0, norm_field1, out_field):
    def func(nodes):
        wv = nodes.data.get(in_field0, 0.) + nodes.data.get(in_field1, 0.)
        z = nodes.data.get(norm_field0, 0.) + nodes.data.get(norm_field1, 0.)
        return {out_field: wv / z}

    return func
