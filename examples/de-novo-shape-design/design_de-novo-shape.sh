#!/usr/bin/env bash

set -euo pipefail

# Set this to the root directory of your RFdiffusion installation.
RFDIFFUSION_ROOT="${RFDIFFUSION_ROOT:-/path/to/RFdiffusion}"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

export CUDA_VISIBLE_DEVICES=0

"${RFDIFFUSION_ROOT}/scripts/run_inference.py" \
	inference.output_prefix="${SCRIPT_DIR}/diffusion/test-de-novo_shape" \
	'contigmap.contigs=[350-450]' \
	inference.num_designs=100 \
	"potentials.guiding_potentials=[\"type:shape_ctrl,obj_file:${SCRIPT_DIR}/input/test_bracket_ori.obj,weight:0.75,sdf_weight:1.0\"]" \
	potentials.guide_scale=2 \
	potentials.guide_decay='constant'
