#! /bin/bash
export CUDA_VISIBLE_DEVICES=0
### step1
/home/yilun/app/RFdiffusion/scripts/run_inference.py \
	inference.output_prefix=diffusion/test_shructure_reshaping_7 \
	'contigmap.contigs=[439-439]' \
	inference.num_designs=2 \
	inference.input_pdb=./input/tp1_2_buffloop_195_dock.pdb \
	diffuser.partial_T=25 \
	'potentials.guiding_potentials=["type:shape_ctrl,obj_file:./input/tp1_density_ori_bent90-7.obj,weight:0.5"]' \
	potentials.guide_scale=2 \
	potentials.guide_decay='constant' 
