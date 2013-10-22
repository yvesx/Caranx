Caranx: Indexing Social Images At Massive Scale
===============================================

* ``26th ACM/IEEE Supercomputing 2013`` Yusheng Xie, Zhuoyuan Chen, Ankit Agrawal, Wei-keng Liao and Alok Choudhary. *Caranx: Scalable Social Image Index Using Phylogenetic Tree of Hashtags*

Most existing image indexing techniques rely on Scale Invariant Feature Transformation (SIFT) for extracting local point features. Applied to individual image, SIFT extracts hundreds of numerical vectors. The vectors are quantized and stored in tree-like data structures for fast search. SIFT-based indexing can exhibit weakness under certain non-rigid transformations, which are common among real world applications. For example, SIFT often cannot recognize a face as the same with different expressions (e.g. giggling vs. crying). Non-Rigid Dense Correspondence (NRDC) addresses such drawbacks of SIFT. However, directly using NRDC incurs an impractical amount of computation in large-scale image indexing. We present a novel idea here that uses social hashtags to organize the images into a phylogenetic tree (PT). We provide an efficient algorithm to build/search the PT, and show that using PT structure can effectively avoid unnecessary NRDC computation. The resulting image index provides more accurate and diversified search results.


Methodology
===========
* Poster at *Supercomputing*'13
![alt tag](https://raw.github.com/yvesx/Caranx/master/imgs/1.png)
