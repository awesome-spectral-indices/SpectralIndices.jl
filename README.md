# SpectralIndices.jl

[![Julia](https://img.shields.io/badge/julia-v1.6.2+-blue.svg)](https://julialang.org/)

## Overview

SpectralIndices.jl is a Julia package for working with spectral indices commonly used in remote sensing and earth observation applications. It provides a convenient way to compute various spectral indices using Julia's high-performance capabilities.

## Features

- Compute a wide range of spectral indices.
- Support for various data types, including arrays, DataFrames, YAXArrays objects, and more. (Coming soon)
- Compatibility with multiple remote sensing platforms and sensors.

## Installation

You can install SpectralIndices.jl using the Julia package manager. Open the Julia REPL and run:

```julia
using Pkg
Pkg.add("SpectralIndices")
```

## Usage

Here's a basic example of how to compute a spectral index using SpectralIndices.jl:

```julia
using SpectralIndices

# Define your input data (e.g., reflectance values)
N = [0.643, 0.725, 0.819]
R = [0.175, 0.212, 0.307]

# Compute NDVI
ndvi_result = compute_index("NDVI", N=N, R=R)

println("Computed NDVI: ", ndvi_result)
```

For more advanced usage and detailed documentation, please refer to the documentation.

## Contributing

Contributions to SpectralIndices.jl are welcome! If you would like to contribute, please see our Contribution Guidelines for more information.

## License

SpectralIndices.jl is licensed under the MIT License. See LICENSE for more information.

## Acknowledgments

This package is inspired by the [Spyndex](https://github.com/awesome-spectral-indices/spyndex) Python library for spectral indices.

## Support

If you have any questions, issues, or feature requests, please open an issue or contact us via email.

## Citation

If you use SpectralIndices.jl in your research, please consider citing it using the following DOI:

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