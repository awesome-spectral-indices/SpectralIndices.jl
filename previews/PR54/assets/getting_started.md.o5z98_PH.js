import{_ as i,c as s,o as a,a7 as e}from"./chunks/framework.DJzJ7HnC.js";const g=JSON.parse('{"title":"SpectralIndices.jl Documentation","description":"","frontmatter":{},"headers":[],"relativePath":"getting_started.md","filePath":"getting_started.md","lastUpdated":null}'),t={name:"getting_started.md"},n=e(`<h1 id="SpectralIndices.jl-Documentation" tabindex="-1">SpectralIndices.jl Documentation <a class="header-anchor" href="#SpectralIndices.jl-Documentation" aria-label="Permalink to &quot;SpectralIndices.jl Documentation {#SpectralIndices.jl-Documentation}&quot;">​</a></h1><p>Welcome to the documentation for SpectralIndices.jl, a comprehensive Julia package for calculating a wide array of spectral indices used in remote sensing and environmental monitoring.</p><h2 id="Overview" tabindex="-1">Overview <a class="header-anchor" href="#Overview" aria-label="Permalink to &quot;Overview {#Overview}&quot;">​</a></h2><p>SpectralIndices.jl simplifies the computation of spectral indices, offering support for both standard and custom indices. The package is designed for efficiency and ease of use, catering to both researchers and practitioners in the field of remote sensing.</p><h2 id="Features" tabindex="-1">Features <a class="header-anchor" href="#Features" aria-label="Permalink to &quot;Features {#Features}&quot;">​</a></h2><ul><li><p>Supports a broad range of predefined spectral indices.</p></li><li><p>Custom index creation capabilities.</p></li><li><p>Flexible input options for various data types.</p></li><li><p>Efficient computation for large datasets.</p></li></ul><h2 id="Getting-Started" tabindex="-1">Getting Started <a class="header-anchor" href="#Getting-Started" aria-label="Permalink to &quot;Getting Started {#Getting-Started}&quot;">​</a></h2><p>To get started with SpectralIndices.jl, follow these steps:</p><h3 id="Installation" tabindex="-1">Installation <a class="header-anchor" href="#Installation" aria-label="Permalink to &quot;Installation {#Installation}&quot;">​</a></h3><p>To install SpectralIndices.jl, use the following Julia command:</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">using</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> Pkg</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">Pkg</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">.</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">add</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;SpectralIndices&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><h3 id="Basic-usage" tabindex="-1">Basic usage <a class="header-anchor" href="#Basic-usage" aria-label="Permalink to &quot;Basic usage {#Basic-usage}&quot;">​</a></h3><p>Here&#39;s a simple example to compute the NDVI spectral index:</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">using</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> SpectralIndices</span></span>
<span class="line"></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">NDVI_result </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> compute_index</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;NDVI&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, N </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.643</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, R </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0.175</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><h2 id="License" tabindex="-1">License <a class="header-anchor" href="#License" aria-label="Permalink to &quot;License {#License}&quot;">​</a></h2><p>SpectralIndices.jl is released under the <a href="https://github.com/awesome-spectral-indices/SpectralIndices.jl/blob/main/LICENSE" target="_blank" rel="noreferrer">MIT License</a>.</p><h2 id="Citation" tabindex="-1">Citation <a class="header-anchor" href="#Citation" aria-label="Permalink to &quot;Citation {#Citation}&quot;">​</a></h2><p>If you use SpectralIndices.jl in your research, please cite it as follows:</p><div class="language-bibtex vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">bibtex</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">@article</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">{</span><span style="--shiki-light:#6F42C1;--shiki-dark:#B392F0;">montero2023standardized</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">  title</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">=</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">{</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">A standardized catalogue of spectral indices to advance the use of remote sensing in Earth system research</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">}</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">  author</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">=</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">{</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">Montero, David and Aybar, C{\\&#39;e}sar and Mahecha, Miguel D and Martinuzzi, Francesco and S{\\&quot;o}chting, Maximilian and Wieneke, Sebastian</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">}</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">  journal</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">=</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">{</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">Scientific Data</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">}</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">  volume</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">=</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">{</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">10</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">}</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">  number</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">=</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">{</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">1</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">}</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">  pages</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">=</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">{</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">197</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">}</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">  year</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">=</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">{</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">2023</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">}</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">  publisher</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">=</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">{</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">Nature Publishing Group UK London</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">}</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">}</span></span></code></pre></div>`,19),l=[n];function h(p,k,r,d,o,E){return a(),s("div",null,l)}const u=i(t,[["render",h]]);export{g as __pageData,u as default};
