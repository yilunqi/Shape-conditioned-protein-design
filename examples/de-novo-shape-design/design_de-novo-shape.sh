#! /bin/bash
export CUDA_VISIBLE_DEVICES=0
### step1
/home/yilun/app/RFdiffusion/scripts/run_inference.py \
	inference.output_prefix=diffusion/test-de-novo_shape \
	'contigmap.contigs=[350-450]' \
	inference.num_designs=100 \
	'potentials.guiding_potentials=["type:shape_ctrl,obj_file:./input/test_bracket_ori.obj,weight:0.75,sdf_weight:1.0"]' \
	potentials.guide_scale=2 \
	potentials.guide_decay='constant' 
