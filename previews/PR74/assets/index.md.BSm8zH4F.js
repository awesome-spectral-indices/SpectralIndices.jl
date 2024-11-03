import{_ as s,c as n,a5 as t,o as e}from"./chunks/framework.B5EHoMhA.js";const h=JSON.parse('{"title":"","description":"","frontmatter":{"layout":"home","hero":{"name":"SpectralIndices.jl","text":"Easy formulas","tagline":"Indices used in remote sensing and environmental monitoring.","image":{"src":"/logo.png","alt":"SpectralIndices"},"actions":[{"theme":"brand","text":"Getting Started","link":"/getting_started"},{"theme":"alt","text":"View on Github","link":"https://github.com/awesome-spectral-indices/SpectralIndices.jl"},{"theme":"alt","text":"API Axioms","link":"/api/axioms"}]},"features":[{"title":"Support","details":"Supports a broad range of predefined spectral indices."},{"title":"Creation","details":"Custom index creation capabilities."},{"title":"Flexibility","details":"Flexible input options for various data types. Efficient computation for large datasets."}]},"headers":[],"relativePath":"index.md","filePath":"index.md","lastUpdated":null}'),p={name:"index.md"};function i(l,a,o,c,r,d){return e(),n("div",null,a[0]||(a[0]=[t(`<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">using</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> SpectralIndices</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">NDVI</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>NDVI: Normalized Difference Vegetation Index</span></span>
<span class="line"><span>* Application Domain: vegetation</span></span>
<span class="line"><span>* Bands/Parameters: Any[&quot;N&quot;, &quot;R&quot;]</span></span>
<span class="line"><span>* Formula: (N-R)/(N+R)</span></span>
<span class="line"><span>* Reference: https://ntrs.nasa.gov/citations/19740022614</span></span></code></pre></div><div class="tip custom-block github-alert"><p class="custom-block-title">See some more with:</p><p></p></div><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">indices</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>Dict{String, SpectralIndices.AbstractSpectralIndex} with 245 entries:</span></span>
<span class="line"><span>  &quot;SWI&quot;           =&gt; SpectralIndex(short_name: SWI,…</span></span>
<span class="line"><span>  &quot;WI1&quot;           =&gt; SpectralIndex(short_name: WI1,…</span></span>
<span class="line"><span>  &quot;NDVIMNDWI&quot;     =&gt; SpectralIndex(short_name: NDVIMNDWI,…</span></span>
<span class="line"><span>  &quot;BAIS2&quot;         =&gt; SpectralIndex(short_name: BAIS2,…</span></span>
<span class="line"><span>  &quot;PSRI&quot;          =&gt; SpectralIndex(short_name: PSRI,…</span></span>
<span class="line"><span>  &quot;MGRVI&quot;         =&gt; SpectralIndex(short_name: MGRVI,…</span></span>
<span class="line"><span>  &quot;SR&quot;            =&gt; SpectralIndex(short_name: SR,…</span></span>
<span class="line"><span>  &quot;MBI&quot;           =&gt; SpectralIndex(short_name: MBI,…</span></span>
<span class="line"><span>  &quot;WRI&quot;           =&gt; SpectralIndex(short_name: WRI,…</span></span>
<span class="line"><span>  &quot;NDISIg&quot;        =&gt; SpectralIndex(short_name: NDISIg,…</span></span>
<span class="line"><span>  &quot;IRECI&quot;         =&gt; SpectralIndex(short_name: IRECI,…</span></span>
<span class="line"><span>  &quot;MTVI2&quot;         =&gt; SpectralIndex(short_name: MTVI2,…</span></span>
<span class="line"><span>  &quot;VIG&quot;           =&gt; SpectralIndex(short_name: VIG,…</span></span>
<span class="line"><span>  &quot;TCARIOSAVI705&quot; =&gt; SpectralIndex(short_name: TCARIOSAVI705,…</span></span>
<span class="line"><span>  &quot;PI&quot;            =&gt; SpectralIndex(short_name: PI,…</span></span>
<span class="line"><span>  &quot;BaI&quot;           =&gt; SpectralIndex(short_name: BaI,…</span></span>
<span class="line"><span>  &quot;CCI&quot;           =&gt; SpectralIndex(short_name: CCI,…</span></span>
<span class="line"><span>  &quot;NRFIr&quot;         =&gt; SpectralIndex(short_name: NRFIr,…</span></span>
<span class="line"><span>  &quot;NBRplus&quot;       =&gt; SpectralIndex(short_name: NBRplus,…</span></span>
<span class="line"><span>  ⋮               =&gt; ⋮</span></span></code></pre></div>`,5)]))}const I=s(p,[["render",i]]);export{h as __pageData,I as default};
