import{_ as l,c as d,j as a,a as t,G as e,a5 as n,B as o,o as p}from"./chunks/framework.CqMsIcbj.js";const f=JSON.parse('{"title":"Datasets","description":"","frontmatter":{},"headers":[],"relativePath":"api/datasets.md","filePath":"api/datasets.md","lastUpdated":null}'),r={name:"api/datasets.md"},h={class:"jldocstring custom-block",open:""},k={class:"jldocstring custom-block",open:""};function c(g,s,u,E,y,m){const i=o("Badge");return p(),d("div",null,[s[6]||(s[6]=a("h1",{id:"datasets",tabindex:"-1"},[t("Datasets "),a("a",{class:"header-anchor",href:"#datasets","aria-label":'Permalink to "Datasets"'},"​")],-1)),a("details",h,[a("summary",null,[s[0]||(s[0]=a("a",{id:"SpectralIndices.get_datasets",href:"#SpectralIndices.get_datasets"},[a("span",{class:"jlbinding"},"SpectralIndices.get_datasets")],-1)),s[1]||(s[1]=t()),e(i,{type:"info",class:"jlObjectType jlFunction",text:"Function"})]),s[2]||(s[2]=n(`<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">get_datasets</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(; datasets</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">[</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;S2_10m.json&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;spectral.json&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">], data_loc</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">joinpath</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">dirname</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">@__FILE__</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">), </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;..&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, </span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;data&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">))</span></span></code></pre></div><p>Download predefined datasets from a specified remote location and save them to a local directory.</p><p><strong>Keyword Arguments</strong></p><ul><li><p><code>datasets::Array{String,1}</code>: A list of dataset filenames to download. Defaults to <code>[&quot;S2_10m.json&quot;, &quot;spectral.json&quot;]</code>.</p></li><li><p><code>data_loc::String</code>: The local directory path where the downloaded datasets will be saved. Defaults to a <code>data</code> directory located one level up from the script&#39;s directory.</p></li></ul><p><strong>Description</strong></p><p>This function iterates over a list of dataset filenames, downloads each dataset from a predefined remote URL, and saves them into a specified local directory. The remote URL is currently hardcoded to download specifically the &quot;S2_10m.json&quot; file for any given dataset in the list. Adjust the function or its usage accordingly if different URLs are needed for different datasets.</p><p><strong>Example</strong></p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">get_datasets</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">()  </span><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;"># Downloads the default datasets to the default location</span></span>
<span class="line"></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">get_datasets</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(; datasets</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">[</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;custom_dataset.json&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">], data_loc</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;path/to/custom/directory&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>This is particularly useful for setting up local environments with necessary data files for further processing or analysis.</p><p><a href="https://github.com/awesome-spectral-indices/SpectralIndices.jl/blob/994107f05b9a8c6c95186d600422846043bacdeb/src/datasets.jl#L1-L24" target="_blank" rel="noreferrer">source</a></p>`,10))]),a("details",k,[a("summary",null,[s[3]||(s[3]=a("a",{id:"SpectralIndices.load_dataset",href:"#SpectralIndices.load_dataset"},[a("span",{class:"jlbinding"},"SpectralIndices.load_dataset")],-1)),s[4]||(s[4]=t()),e(i,{type:"info",class:"jlObjectType jlFunction",text:"Function"})]),s[5]||(s[5]=n(`<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">load_dataset</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(dataset</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">String</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">) </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">-&gt;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> YAXArray</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">load_dataset</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(dataset</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">String</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">) </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">-&gt;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> DataFrame</span></span></code></pre></div><p>Load a specified dataset and convert it into either a YAXArray or a DataFrame, depending on the loaded packages.</p><p><strong>Arguments</strong></p><ul><li><code>dataset::String</code>: The name of the dataset to load. Currently supports <code>&quot;sentinel&quot;</code> and <code>&quot;spectral&quot;</code>.</li></ul><p><strong>Returns</strong></p><ul><li><p>If YAXArrays is loaded in the namespace, returns a <code>YAXArray</code> object containing the loaded dataset, with dimensions labeled as <code>:x</code>, <code>:y</code>, and <code>:bands</code>. The spatial dimensions (<code>:x</code> and <code>:y</code>) are assumed to have a size of 300 each, and the <code>:bands</code> dimension includes [&quot;B02&quot;, &quot;B03&quot;, &quot;B04&quot;, &quot;B08&quot;] bands.</p></li><li><p>If DataFrames is loaded in the namespace, returns a <code>DataFrame</code> with the dataset loaded into it.</p></li></ul><p><strong>Errors</strong></p><p>Throws an error if the <code>dataset</code> argument does not match one of the predefined dataset names.</p><p><strong>Example</strong></p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;"># Load dataset as YAXArray</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">yax_ds </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> SpectralIndices</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">.</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">load_dataset</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;sentinel&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"></span>
<span class="line"><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;"># Load dataset as DataFrame</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">df_ds </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> SpectralIndices</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">.</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">load_dataset</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;spectral&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>The current implementation expects the JSON files (&quot;S2_10m.json&quot; for &quot;sentinel&quot; and &quot;spectral.json&quot; for &quot;spectral&quot;) to follow a specific format: a vector of vectors where each inner vector represents a band&#39;s data in a 300x300 spatial grid for the YAXArray version, or a suitable structure that can be directly converted into a DataFrame for the DataFrame version. The files are already provided for examples in the package in the folder <code>data</code>.</p><p><a href="https://github.com/awesome-spectral-indices/SpectralIndices.jl/blob/994107f05b9a8c6c95186d600422846043bacdeb/src/datasets.jl#L43-L74" target="_blank" rel="noreferrer">source</a></p>`,12))])])}const b=l(r,[["render",c]]);export{f as __pageData,b as default};
