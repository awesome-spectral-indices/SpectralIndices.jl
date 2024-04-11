import{_ as s,c as i,o as a,a7 as n}from"./chunks/framework.BwBv6Bzr.js";const g=JSON.parse('{"title":"DataFrames.jl","description":"","frontmatter":{},"headers":[],"relativePath":"tutorials/dataframes.md","filePath":"tutorials/dataframes.md","lastUpdated":null}'),t={name:"tutorials/dataframes.md"},e=n(`<h1 id="DataFrames.jl" tabindex="-1">DataFrames.jl <a class="header-anchor" href="#DataFrames.jl" aria-label="Permalink to &quot;DataFrames.jl {#DataFrames.jl}&quot;">​</a></h1><p>This section of the documentation will help you understand how to work with SpectralIndices.jl using DataFrames.jl as input.</p><p>This tutorial relies on data stored in <code>data</code>. To access it we are going to use the following:</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">using</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> SpectralIndices, DataFrames</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">df </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> load_dataset</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;spectral&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, DataFrame)</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">first</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(df, </span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">5</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>Each column of this dataset is the Surface Reflectance from Landsat 8 for 3 different classes. The samples were taken over Oporto. The data is taken from <a href="https://spyndex.readthedocs.io/en/latest/tutorials/pandas.html" target="_blank" rel="noreferrer">spyndex</a> and this tutorial is meant to closely mirror the python version.</p><p>This dataset specifically contains three different classes:</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">unique</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(df[</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">!</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;class&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">])</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span>3-element Vector{String}:</span></span>
<span class="line"><span> &quot;Urban&quot;</span></span>
<span class="line"><span> &quot;Water&quot;</span></span>
<span class="line"><span> &quot;Vegetation&quot;</span></span></code></pre></div><p>so to reflect that we are going to calculate three different indices: <code>NDVI</code> for <code>vegetation</code>, <code>NDWI</code> for <code>water</code> and <code>NDBI</code> for <code>urban</code>.</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">NDVI</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span>NDVI: Normalized Difference Vegetation Index</span></span>
<span class="line"><span>* Application Domain: vegetation</span></span>
<span class="line"><span>* Bands/Parameters: Any[&quot;N&quot;, &quot;R&quot;]</span></span>
<span class="line"><span>* Formula: (N-R)/(N+R)</span></span>
<span class="line"><span>* Reference: https://ntrs.nasa.gov/citations/19740022614</span></span></code></pre></div><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">NDWI</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span>NDWI: Normalized Difference Water Index</span></span>
<span class="line"><span>* Application Domain: water</span></span>
<span class="line"><span>* Bands/Parameters: Any[&quot;G&quot;, &quot;N&quot;]</span></span>
<span class="line"><span>* Formula: (G-N)/(G+N)</span></span>
<span class="line"><span>* Reference: https://doi.org/10.1080/01431169608948714</span></span></code></pre></div><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">NDBI</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span>NDBI: Normalized Difference Built-Up Index</span></span>
<span class="line"><span>* Application Domain: urban</span></span>
<span class="line"><span>* Bands/Parameters: Any[&quot;S1&quot;, &quot;N&quot;]</span></span>
<span class="line"><span>* Formula: (S1-N)/(S1+N)</span></span>
<span class="line"><span>* Reference: http://dx.doi.org/10.1080/01431160304987</span></span></code></pre></div><p>We have multiple ways to feed this data to SectralIndices.jl to generate our indices. We will try to cover most of them here.</p><h2 id="From-DataFrame-to-DataFrame" tabindex="-1">From <code>DataFrame</code> to <code>DataFrame</code> <a class="header-anchor" href="#From-DataFrame-to-DataFrame" aria-label="Permalink to &quot;From \`DataFrame\` to \`DataFrame\` {#From-DataFrame-to-DataFrame}&quot;">​</a></h2><p>A straightforward way to obtain the calculation of the indices is to feed a <code>DataFrame</code> to <code>compute_index</code>. In order to do this we need first to build the new <code>DataFrame</code>. We can explore which bands we need by calling the <code>bands</code> field in the indices:</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">NDVI</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">.</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">bands</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span>2-element Vector{Any}:</span></span>
<span class="line"><span> &quot;N&quot;</span></span>
<span class="line"><span> &quot;R&quot;</span></span></code></pre></div><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">NDWI</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">.</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">bands</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span>2-element Vector{Any}:</span></span>
<span class="line"><span> &quot;G&quot;</span></span>
<span class="line"><span> &quot;N&quot;</span></span></code></pre></div><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">NDBI</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">.</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">bands</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span>2-element Vector{Any}:</span></span>
<span class="line"><span> &quot;S1&quot;</span></span>
<span class="line"><span> &quot;N&quot;</span></span></code></pre></div><p>In this case we are going to need only Green, Red, NIR and SWIR1 bands. Since the <code>compute_index</code> expects the bands to have the same name as the have in the <code>bands</code> field we need to select the specific columns that we want out of the dataset and rename them. We can do this easily with <code>select</code>:</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">params </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> select</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(df, </span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">:SR_B3</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=&gt;</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">:G</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, </span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">:SR_B4</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=&gt;</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">:R</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, </span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">:SR_B5</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=&gt;</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">:N</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, </span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">:SR_B6</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=&gt;</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">:S1</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">first</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(params, </span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">5</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>Now our dataset is ready, and we just need to call the <code>compute_index</code> function</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">idx </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> compute_index</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">([</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;NDVI&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;NDWI&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;NDBI&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">], params)</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">first</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(idx, </span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">5</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>The result is a new <code>DataFrame</code> with the desired indices as columns.</p><p>Another way to obtain this is to feed single <code>DataFrame</code>s as kwargs. First we need to define the single <code>DataFrame</code>s:</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">idx </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> compute_index</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">([</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;NDVI&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;NDWI&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;NDBI&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">];</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    G </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> select</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(df, </span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">:SR_B3</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=&gt;</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">:G</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">),</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    N </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> select</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(df, </span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">:SR_B5</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=&gt;</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">:N</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">),</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    R </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> select</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(df, </span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">:SR_B4</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=&gt;</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">:R</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">),</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    S1 </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> select</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(df, </span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">:SR_B6</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=&gt;</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">:S1</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">))</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">first</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(idx, </span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">5</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><h2 id="From-DataFrame-to-Vector" tabindex="-1">From <code>DataFrame</code> to <code>Vector</code> <a class="header-anchor" href="#From-DataFrame-to-Vector" aria-label="Permalink to &quot;From \`DataFrame\` to \`Vector\` {#From-DataFrame-to-Vector}&quot;">​</a></h2><p>Alternatively you can define a <code>Dict</code> for the indices from the <code>DataFrame</code>, going back to an example we saw in the previous page:</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">params </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Dict</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;G&quot;</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =&gt;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> df[</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">!</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;SR_B3&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">], </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;N&quot;</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =&gt;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> df[</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">!</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;SR_B5&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">], </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;R&quot;</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =&gt;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> df[</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">!</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;SR_B4&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">], </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;S1&quot;</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =&gt;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> df[</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">!</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;SR_B6&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">])</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span>Dict{String, Vector{Float64}} with 4 entries:</span></span>
<span class="line"><span>  &quot;S1&quot; =&gt; [0.306206, 0.267596, 0.258384, 0.25958, 0.273234, 0.32954, 0.271721, …</span></span>
<span class="line"><span>  &quot;N&quot;  =&gt; [0.269054, 0.281264, 0.28422, 0.254479, 0.269535, 0.277153, 0.26563, …</span></span>
<span class="line"><span>  &quot;G&quot;  =&gt; [0.132227, 0.124404, 0.120994, 0.135981, 0.15035, 0.152303, 0.135885,…</span></span>
<span class="line"><span>  &quot;R&quot;  =&gt; [0.165764, 0.160979, 0.140203, 0.163976, 0.18126, 0.19754, 0.170026, …</span></span></code></pre></div><p>The computation is done in the same way:</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">ndvi, ndwi, ndbi </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> compute_index</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">([</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;NDVI&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;NDWI&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;NDBI&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">], params)</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span>3-element Vector{Any}:</span></span>
<span class="line"><span> [0.23754793677807357, 0.2719887844338796, 0.33932578974960087, 0.21627773595727137, 0.19582071673377036, 0.16771383579896465, 0.21944767233340506, 0.2251996432295527, 0.1655330261746833, 0.2675545906704802  …  0.810365666144593, 0.8104049969776344, 0.7616768543153676, 0.8027222040013119, 0.7929365431300779, 0.7862750574070626, 0.8080303042462863, 0.8025822103946664, 0.7135886988619672, 0.7672440264304153]</span></span>
<span class="line"><span> [-0.3409734444357916, -0.38667135030536093, -0.4028151808767594, -0.3034817907083952, -0.28385153077628394, -0.29071730449057526, -0.32313861250513676, -0.3563320964589312, -0.24060392753715099, -0.34356689100134846  …  -0.7698492602846995, -0.7547124120206541, -0.7128263753013682, -0.7716516398212895, -0.7491201313937117, -0.7510114068441064, -0.7257608604061496, -0.7401234567901236, -0.6752241340558899, -0.7074355283543386]</span></span>
<span class="line"><span> [0.06458384035045028, -0.02490161425500128, -0.04761531780788457, 0.009923476645422341, 0.006814596455672831, 0.08634934501415456, 0.01133569522728392, 0.03875665342611921, 0.006910176170362171, -0.0322322650047355  …  -0.47115094032591764, -0.46672499804111056, -0.40825671490715415, -0.5414949557901297, -0.43083696212857336, -0.43525525151156264, -0.4700842430846934, -0.4585879184008887, -0.4050436713235448, -0.44864683453438614]</span></span></code></pre></div><p>Just be careful with the naming, SpectralIndices.jl brings into the namespace all the indices as defined in <code>indices</code>. The all caps version of the indices is reserved for them, as we illustrated at the beginning of this tutorial:</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">NDVI</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span>NDVI: Normalized Difference Vegetation Index</span></span>
<span class="line"><span>* Application Domain: vegetation</span></span>
<span class="line"><span>* Bands/Parameters: Any[&quot;N&quot;, &quot;R&quot;]</span></span>
<span class="line"><span>* Formula: (N-R)/(N+R)</span></span>
<span class="line"><span>* Reference: https://ntrs.nasa.gov/citations/19740022614</span></span></code></pre></div><p>The two steps can be merged by providing the values directly as kwargs:</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">ndvi, ndwi, ndbi </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> compute_index</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">([</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;NDVI&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;NDWI&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;NDBI&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">];</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    G </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> df[</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">!</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;SR_B3&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">],</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    N </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> df[</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">!</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;SR_B5&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">],</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    R </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> df[</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">!</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;SR_B4&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">],</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    S1 </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> df[</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">!</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;SR_B6&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">])</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span>3-element Vector{Any}:</span></span>
<span class="line"><span> [0.23754793677807357, 0.2719887844338796, 0.33932578974960087, 0.21627773595727137, 0.19582071673377036, 0.16771383579896465, 0.21944767233340506, 0.2251996432295527, 0.1655330261746833, 0.2675545906704802  …  0.810365666144593, 0.8104049969776344, 0.7616768543153676, 0.8027222040013119, 0.7929365431300779, 0.7862750574070626, 0.8080303042462863, 0.8025822103946664, 0.7135886988619672, 0.7672440264304153]</span></span>
<span class="line"><span> [-0.3409734444357916, -0.38667135030536093, -0.4028151808767594, -0.3034817907083952, -0.28385153077628394, -0.29071730449057526, -0.32313861250513676, -0.3563320964589312, -0.24060392753715099, -0.34356689100134846  …  -0.7698492602846995, -0.7547124120206541, -0.7128263753013682, -0.7716516398212895, -0.7491201313937117, -0.7510114068441064, -0.7257608604061496, -0.7401234567901236, -0.6752241340558899, -0.7074355283543386]</span></span>
<span class="line"><span> [0.06458384035045028, -0.02490161425500128, -0.04761531780788457, 0.009923476645422341, 0.006814596455672831, 0.08634934501415456, 0.01133569522728392, 0.03875665342611921, 0.006910176170362171, -0.0322322650047355  …  -0.47115094032591764, -0.46672499804111056, -0.40825671490715415, -0.5414949557901297, -0.43083696212857336, -0.43525525151156264, -0.4700842430846934, -0.4585879184008887, -0.4050436713235448, -0.44864683453438614]</span></span></code></pre></div><p>You are free to choose whichever method you prefer, there is no meaningful trade-off in speed</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">@time</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> ndvi, ndwi, ndbi </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> compute_index</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">([</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;NDVI&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;NDWI&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;NDBI&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">], params)</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span>3-element Vector{Any}:</span></span>
<span class="line"><span> [0.23754793677807357, 0.2719887844338796, 0.33932578974960087, 0.21627773595727137, 0.19582071673377036, 0.16771383579896465, 0.21944767233340506, 0.2251996432295527, 0.1655330261746833, 0.2675545906704802  …  0.810365666144593, 0.8104049969776344, 0.7616768543153676, 0.8027222040013119, 0.7929365431300779, 0.7862750574070626, 0.8080303042462863, 0.8025822103946664, 0.7135886988619672, 0.7672440264304153]</span></span>
<span class="line"><span> [-0.3409734444357916, -0.38667135030536093, -0.4028151808767594, -0.3034817907083952, -0.28385153077628394, -0.29071730449057526, -0.32313861250513676, -0.3563320964589312, -0.24060392753715099, -0.34356689100134846  …  -0.7698492602846995, -0.7547124120206541, -0.7128263753013682, -0.7716516398212895, -0.7491201313937117, -0.7510114068441064, -0.7257608604061496, -0.7401234567901236, -0.6752241340558899, -0.7074355283543386]</span></span>
<span class="line"><span> [0.06458384035045028, -0.02490161425500128, -0.04761531780788457, 0.009923476645422341, 0.006814596455672831, 0.08634934501415456, 0.01133569522728392, 0.03875665342611921, 0.006910176170362171, -0.0322322650047355  …  -0.47115094032591764, -0.46672499804111056, -0.40825671490715415, -0.5414949557901297, -0.43083696212857336, -0.43525525151156264, -0.4700842430846934, -0.4585879184008887, -0.4050436713235448, -0.44864683453438614]</span></span></code></pre></div><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">@time</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> ndvi, ndwi, ndbi </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> compute_index</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">([</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;NDVI&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;NDWI&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;NDBI&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">];</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">           G </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> df[</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">!</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;SR_B3&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">],</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">           N </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> df[</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">!</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;SR_B5&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">],</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">           R </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> df[</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">!</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;SR_B4&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">],</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">           S1 </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> df[</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">!</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;SR_B6&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">])</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span>3-element Vector{Any}:</span></span>
<span class="line"><span> [0.23754793677807357, 0.2719887844338796, 0.33932578974960087, 0.21627773595727137, 0.19582071673377036, 0.16771383579896465, 0.21944767233340506, 0.2251996432295527, 0.1655330261746833, 0.2675545906704802  …  0.810365666144593, 0.8104049969776344, 0.7616768543153676, 0.8027222040013119, 0.7929365431300779, 0.7862750574070626, 0.8080303042462863, 0.8025822103946664, 0.7135886988619672, 0.7672440264304153]</span></span>
<span class="line"><span> [-0.3409734444357916, -0.38667135030536093, -0.4028151808767594, -0.3034817907083952, -0.28385153077628394, -0.29071730449057526, -0.32313861250513676, -0.3563320964589312, -0.24060392753715099, -0.34356689100134846  …  -0.7698492602846995, -0.7547124120206541, -0.7128263753013682, -0.7716516398212895, -0.7491201313937117, -0.7510114068441064, -0.7257608604061496, -0.7401234567901236, -0.6752241340558899, -0.7074355283543386]</span></span>
<span class="line"><span> [0.06458384035045028, -0.02490161425500128, -0.04761531780788457, 0.009923476645422341, 0.006814596455672831, 0.08634934501415456, 0.01133569522728392, 0.03875665342611921, 0.006910176170362171, -0.0322322650047355  …  -0.47115094032591764, -0.46672499804111056, -0.40825671490715415, -0.5414949557901297, -0.43083696212857336, -0.43525525151156264, -0.4700842430846934, -0.4585879184008887, -0.4050436713235448, -0.44864683453438614]</span></span></code></pre></div>`,49),p=[e];function l(h,k,d,o,r,E){return a(),i("div",null,p)}const u=s(t,[["render",l]]);export{g as __pageData,u as default};
