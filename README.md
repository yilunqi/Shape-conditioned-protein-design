# RFdiffusion `shape_ctrl` Potential

This folder provides a `shape_ctrl` guiding potential for RFdiffusion. It uses an OBJ mesh as the target shape and guides CA atoms with a combination of SDF outside loss and Chamfer distance.

## What It Does

`shape_ctrl` optimizes two main terms:

```text
SDF outside loss: pulls CA atoms into the target OBJ mesh
Chamfer distance: improves the CA point-cloud distribution inside the target shape
```

The effective loss is:

```python
total_loss = sdf_weight * sdf_outside + chamfer_weight * chamfer_loss
potential = -weight * total_loss
```

`hausdorff_loss` and `moment_loss` are also reported for diagnostics, but their default weights are `0.0`.

## Files

Use these two files together:

```text
potentials.py
manager.py
```

`potentials.py` adds the `shape_ctrl` potential.  
`manager.py` allows `obj_file` to be passed as a string in `potentials.guiding_potentials`.

## Installation

Copy the files into your RFdiffusion source tree:

```bash
cp potentials.py /path/to/RFdiffusion/rfdiffusion/potentials/potentials.py
cp manager.py /path/to/RFdiffusion/rfdiffusion/potentials/manager.py
```

Alternatively, manually merge the `shape_ctrl` class into `rfdiffusion/potentials/potentials.py`, register it in `implemented_potentials`, and update `manager.py` so that `obj_file` is not converted to `float`.

Required manager change:

```python
if key not in {'type', 'obj_file'}:
    setting_dict[key] = float(setting_dict[key])
```

## Usage

Pass `shape_ctrl` through RFdiffusion's `potentials.guiding_potentials` argument:

```text
type:shape_ctrl,obj_file:<target.obj>,weight:<weight>,sdf_weight:<sdf_weight>,chamfer_weight:<chamfer_weight>
```

Common parameters:

```text
obj_file          target OBJ mesh
weight            overall potential weight
sdf_weight        weight for SDF outside loss
chamfer_weight    weight for Chamfer distance
num_samples       number of sampled target-shape points, default 800
scale_factor      optional OBJ coordinate scale, default 1.0
```

Recommended starting point:

```text
weight=0.5
sdf_weight=1
chamfer_weight=1
```


## Examples

Example inputs and command-line usage are provided in the `examples/` folder.

## Notes

- The target shape must be an OBJ mesh.
- The implementation requires Kaolin and CUDA.
- The relative scale of `weight`, `sdf_weight`, and `chamfer_weight` may need adjustment for different protein lengths, OBJ scales, or target shapes.
- Checking `Xt-1.pdb` is often useful when tuning these parameters. If the guided update becomes too large, the intermediate structure may show exploding coordinates or spiky artifacts; reducing `weight` or `chamfer_weight` can help avoid over-constraining the point-cloud distribution and degrading backbone quality.
