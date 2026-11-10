
# Amazon Beauty Reviews: Multi-Method Analysis

## Overview

This repository accompanies the research paper:

**From Distributed Processing to Customer Insights:
A Reproducible Multi-Method Analysis of Amazon Beauty Reviews**

Author: Reem Abdullah  
Affiliation: King Khalid University, Saudi Arabia

The study investigates complementary big-data
analytics methods for extracting insights from
Amazon All Beauty customer reviews.

## Dataset

- Source: Amazon Reviews 2023 – All Beauty
- Original reviews: 701,528
- Cleaned reviews: 693,547
- Cleaning: duplicate removal and exclusion
  of empty review texts

Dataset source:
https://amazon-reviews-2023.github.io/

The original dataset is not redistributed
in this repository.

## Analytical Methods

1. Distributed WordCount using Hadoop Streaming
   on AWS EMR, with Amazon S3 storage.
2. Association rule mining using FP-Growth.
3. Text clustering using TF-IDF, SVD, and
   MiniBatch K-Means.
4. Rating-derived sentiment classification
   using Naive Bayes and Linear SVM.
5. Temporal forecasting using ARIMA.
6. Lexicon-based sentiment analysis using VADER.
7. Exploratory topic modeling using NMF.

Only WordCount was executed on Hadoop.
The remaining analytical methods were evaluated
as separate tasks.

## Main Findings

- Cleaned corpus: 693,547 reviews
- Distinct WordCount terms: 85,739
- Retained association rules: 58
- Linear SVM accuracy: 91.64%
- Linear SVM macro-F1: 88.74%
- Linear SVM negative-class recall: 91.86%
- ARIMA MAE: 4.227 percentage points
- Clustering exhibited weak separation.

## Repository Contents

- `Amazon_all_beautyDS-2.ipynb`:
  Main analysis notebook.

## Reproducibility Notes

The repository currently contains the analysis
notebook. Environment dependencies, execution
instructions, and Hadoop mapper/reducer scripts
will be documented after verification.

The dataset and AWS credentials are not included.
Cloud execution may require an appropriately
configured AWS environment.
