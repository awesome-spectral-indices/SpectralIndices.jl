# DataFrames.jl

This section of the documentation will help you understand how to work with SpectralIndices.jl using DataFrames.jl as input.

This tutorial relies on data stored in `data`. To access it we are going to use the following:
```@example dataframes
using SpectralIndices, DataFrames
df = load_dataset("spectral")
```
Each column of this dataset is the Surface Reflectance from Landsat 8 for 3 different classes. The samples were taken over Oporto. The data is taken from [spyndex](https://spyndex.readthedocs.io/en/latest/tutorials/pandas.html) and this tutorial is meant to closely mirror the python version.

This dataset specifically contains three different classes:
```@example dataframes
unique(df[!, "class"])
```
so to reflect that we are going to calculate three different indices: `NDVI` for `vegetation`, `NDWI` for `water` and `NDBI` for `urban`.
```@example dataframes
NDVI
```
```@example dataframes
NDWI
```
```@example dataframes
NDBI
```

We have multiple ways to feed this data to SectralIndices.jl to generate our indices. We will try to cover most of them here.

## From `DataFrame` to `DataFrame`

A straightforward way to obtain the calculation of the indices is to feed a `DataFrame` to `compute_index`. In order to do this we need first to build the new `DataFrame`. We can explore which bands we need by calling the `bands` field in the indices:

```@example dataframes
NDVI.bands
```
```@example dataframes
NDWI.bands
```
```@example dataframes
NDBI.bands
```

In this case we are going to need only Green, Red, NIR and SWIR1 bands. Since the `compute_index` expects the bands to have the same name as the have in the `bands` field we need to select the specific columns that we want out of the dataset and rename them. We can do this easily with `select`:

```@example dataframes
params = select(df, :SR_B3=>:G, :SR_B4=>:R, :SR_B5=>:N, :SR_B6=>:S1)
```

Now our dataset is ready, and we just need to call the `compute_index` function

```@example dataframes
idx = compute_index(["NDVI", "NDWI", "NDBI"], params)
```

The result is a new `DataFrame` with the desired indices as columns.

Another way to obtain this is to feed single `DataFrame`s as kwargs. First we need to define the single `DataFrame`s:

```@example dataframes

idx = compute_index(["NDVI", "NDWI", "NDBI"]; 
    G = select(df, :SR_B3=>:G),
    N = select(df, :SR_B5=>:N),
    R = select(df, :SR_B4=>:R),
    S1 = select(df, :SR_B6=>:S1))
```


## From `DataFrame` to `Vector`

Alternatively you can define a `Dict` for the indices from the `DataFrame`, going back to an example we saw in the previous page:

```@example dataframes
params = Dict("G" => df[!, "SR_B3"], "N" => df[!, "SR_B5"], "R" => df[!, "SR_B4"], "S1" => df[!, "SR_B6"])
```

The computation is done in the same way:

```@example dataframes
ndvi, ndwi, ndbi = compute_index(["NDVI", "NDWI", "NDBI"], params)
```

Just be careful with the naming, SpectralIndices.jl brings into the namespace all the indices as defined in `indices`. The all caps version of the indices is reserved for them, as we illustrated at the beginning of this tutorial:

```@example dataframes
NDVI
```

The two steps can be merged by providing the values directly as kwargs:

```@example dataframes
ndvi, ndwi, ndbi = compute_index(["NDVI", "NDWI", "NDBI"]; 
    G = df[!, "SR_B3"],
    N = df[!, "SR_B5"],
    R = df[!, "SR_B4"],
    S1 = df[!, "SR_B6"])
```

You are free to choose whichever method you prefer, there is no meaningful trade-off in speed

```@example dataframes
@time ndvi, ndwi, ndbi = compute_index(["NDVI", "NDWI", "NDBI"], params)
```

```@example dataframes
@time ndvi, ndwi, ndbi = compute_index(["NDVI", "NDWI", "NDBI"]; 
           G = df[!, "SR_B3"],
           N = df[!, "SR_B5"],
           R = df[!, "SR_B4"],
           S1 = df[!, "SR_B6"])
```