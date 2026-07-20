#!/usr/bin/env bash

set -euo pipefail

# Set this to the root directory of your RFdiffusion installation.
RFDIFFUSION_ROOT="${RFDIFFUSION_ROOT:-/path/to/RFdiffusion}"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

export CUDA_VISIBLE_DEVICES=0

"${RFDIFFUSION_ROOT}/scripts/run_inference.py" \
	inference.output_prefix="${SCRIPT_DIR}/diffusion/test_structure_reshaping" \
	'contigmap.contigs=[439-439]' \
	inference.num_designs=2 \
	inference.input_pdb="${SCRIPT_DIR}/input/tp1_2_buffloop_195_dock.pdb" \
	diffuser.partial_T=25 \
	"potentials.guiding_potentials=[\"type:shape_ctrl,obj_file:${SCRIPT_DIR}/input/tp1_density_ori_bent90-1.obj,weight:0.5\"]" \
	potentials.guide_scale=2 \
	potentials.guide_decay='constant'
