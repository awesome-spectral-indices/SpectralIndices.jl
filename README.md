# SpectralIndices.jl

<p align="center">
    <img width="400px" src="docs/src/assets/logo.png"/>
</p>

[![docs](https://img.shields.io/badge/docs-latest-blue.svg)](https://awesome-spectral-indices.github.io/SpectralIndices.jl/dev/)
[![CI](https://github.com/awesome-spectral-indices/SpectralIndices.jl/actions/workflows/CI.yml/badge.svg)](https://github.com/awesome-spectral-indices/SpectralIndices.jl/actions/workflows/CI.yml)
[![codecov](https://codecov.io/gh/awesome-spectral-indices/SpectralIndices.jl/graph/badge.svg?token=0IRRDAZM0U)](https://codecov.io/gh/awesome-spectral-indices/SpectralIndices.jl)
[![Julia](https://img.shields.io/badge/julia-v1.6.2+-blue.svg)](https://julialang.org/)
[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)

## Overview

SpectralIndices.jl is a Julia package for working with spectral indices commonly used in remote sensing and earth observation applications. It provides a convenient way to compute various spectral indices using Julia's high-performance capabilities.

## Features

- Compute a wide range of spectral indices.
- Support for various data types, including arrays, DataFrames, YAXArrays objects, and more. (Coming soon)
- Flexible parameter input options.
- Compatibility with multiple remote sensing platforms and sensors.

## Installation
SpectralIndices.jl is not yet register in the general registry, please install it using the following:
```julia
using Pkg
Pkg.add("https://github.com/awesome-spectral-indices/SpectralIndices.jl")
```

## Usage

You can compute spectral indices either by specifying the index and its parameters or using predefined SpectralIndex instances.

### Using `compute_index`
```julia
using SpectralIndices

# Compute NDVI with direct parameter input
result = compute_index("NDVI", N = 0.643, R = 0.175)

# Compute multiple indices with array inputs
multi_result = compute_index(["NDVI", "SAVI"], N = fill(0.643, 5), R = fill(0.175, 5), L = fill(0.5, 5))

# use Dataframes
df = DataFrame(N = [0.643, 0.560], R = [0.175, 0.225])
result_df_single = compute_index("NDVI", df)
# Multiple inputs in a dataframe
df = DataFrame(N = [0.643, 0.560], R = [0.175, 0.225], L = [0.5, 0.5])
result_df_multiple = compute_index(["NDVI", "SAVI"], df)
```

### Using `compute`
```julia
# Define a SpectralIndex instance

# Compute using the instance with keyword arguments
result = compute(NDVI, N = 0.643, R = 0.175) #NDVI is autmatically in namespace with the import of SpectraIndices.jl

# Compute with array inputs
array_result = compute(NDVI, N = fill(0.643, (5, 5)), R = fill(0.175, (5, 5)))
```

### Direct computation
SpectralIndices.jl also allows for direct computation using function calls:
```julia
result = NDVI(0.643, 0.175)
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