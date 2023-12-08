# SpectralIndices.jl Documentation

Welcome to the documentation for SpectralIndices.jl, a comprehensive Julia package for calculating a wide array of spectral indices used in remote sensing and environmental monitoring.

## Overview

SpectralIndices.jl simplifies the computation of spectral indices, offering support for both standard and custom indices. The package is designed for efficiency and ease of use, catering to both researchers and practitioners in the field of remote sensing.

## Features

- Supports a broad range of predefined spectral indices.
- Custom index creation capabilities.
- Flexible input options for various data types.
- Efficient computation for large datasets.

## Getting Started

To get started with SpectralIndices.jl, follow these steps:

### Installation

To install SpectralIndices.jl, use the following Julia command:

```julia
using Pkg
Pkg.add("SpectralIndices")
```

### Basic usage

Here's a simple example to compute the NDVI spectral index:
```julia
using SpectralIndices

NDVI_result = compute_index("NDVI", N = 0.643, R = 0.175)
```

## License
SpectralIndices.jl is released under the [MIT License](https://github.com/awesome-spectral-indices/SpectralIndices.jl/blob/main/LICENSE).

## Citation
If you use SpectralIndices.jl in your research, please cite it as follows:

```bibtex
@article{montero2023standardized,
  title={A standardized catalogue of spectral indices to advance the use of remote sensing in Earth system research},
  author={Montero, David and Aybar, C{\'e}sar and Mahecha, Miguel D and Martinuzzi, Francesco and S{\"o}chting, Maximilian and Wieneke, Sebastian},
  journal={Scientific Data},
  volume={10},
  number={1},
  pages={197},
  year={2023},
  publisher={Nature Publishing Group UK London}
}
```