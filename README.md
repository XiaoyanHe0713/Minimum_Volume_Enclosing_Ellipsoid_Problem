# Minimum Volume Enclosing Ellipsoid Problem
## Abstract
This paper delves into the fascinating, yet complex, realm of computational geometry, with a particular focus on the Minimum Volume Enclosing Ellipsoid (MVEE) problem. This problem concerns finding the smallest volume ellipsoid that encapsulates a given finite set of points within a multi-dimensional Euclidean space, a challenge with far-reaching implications across fields such as machine learning, pattern recognition, and optimization. We commence with a comprehensive introduction to the MVEE problem, elucidating its mathematical intricacies and its significance in both theoretical and practical applications. Then we review several ways to solve the MVEE problem. We also discuss the advantages and disadvantages of each method, and compare their performance . Finally, we conclude with a brief discussion of the applications of the MVEE problem in many fields, including machine learning, pattern recognition, and optimization.

## Code
The code for this project is listed in the repo and can be run on matlab. Before running the code, please make sure to download SeDuMi from https://sedumi.ie.lehigh.edu/.Download and add the extracted SeDuMi directory to the Matlab load path
and run

    install_sedumi

to install SeDuMi.

The file `MinVolEllipsoid.m` is the function that solves the MVEE problem by SeDuMi,
the file `Khachiyan.m` is the function that solves the MVEE problem by Khachiyan's algorithm iteratively, and the file `MVEE_SeDuMi.m` and `MVEE_Khachiyan.m` are the scripts that demo the two methods respectively for 3-dimensional data and plot the results.

## Acknowledgement
We would like to thank Professor [Jiawang Nie](https://mathweb.ucsd.edu/~njw/) for his guidance and support throughout the project and the composition of the academic report. If you are intersted in optimization, please check out Professor Nie's new book "Moment and Polynomial Optimization" at https://mathweb.ucsd.edu/~njw/bkmposiam23.html.