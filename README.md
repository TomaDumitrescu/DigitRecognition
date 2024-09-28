# Copyright 2023 Toma-Ioan Dumitrescu

# Description:

Implementation of given mathematical models in Octave for Task 1: SVD image
compression, Task 2: finding principal components with SVD, Task 3: finding
principal components using covariance matrix, Task 4: digit recognition. 

# Digit recognition:

Principal Components Algorithm: extract essential information from the
image-input so that the prediction error does not increase significantly.

MNIST: 70000 images (28 x 28 pixels) with hand-written digits for training
and 10000 images used for testing.
Accuracy: 93.3%

Algorithm:
1. Loading data training set
2. Calculating the average of each column and substract it from each
column-element => normalization of pixels.
3. Determining covariance matrix
4. Computing eigenvalues and eigenvectors of the covariance matrix
5. Sort decreasingly the eigenvalues, the eigenvectors having the
same order as the eigenvalues.
6. The ordered eigenvector will form another matrix M
7. Select first 23 columns from M
8. Calculate the projection Y of the image in principal components
space: Y = image * M23
9. Using only 23 principal components, find image* = Y x transpose(M23)
10. Transform the image-test in a vector, then project it in principal
components space, by multiplication with M
11. Apply kNN with k = 5, the result being the prediction
