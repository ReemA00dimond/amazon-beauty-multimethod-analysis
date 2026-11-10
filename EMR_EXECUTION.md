# AWS EMR Hadoop Streaming — WordCount Execution

This document records the **completed WordCount experiment** supporting the paper *From Distributed Processing to Customer Insights: A Reproducible Multi-Method Analysis of Amazon Beauty Reviews*.

## Execution summary

| Field | Recorded value |
|---|---|
| Execution date | 2026-10-27 |
| AWS service | Amazon EMR on EC2 |
| Cluster name | `BigData-AmazonReviews` |
| EMR step name | `Beauty-WordCount` |
| EMR step status | **Completed** (exit code 0) |
| Processing framework | Hadoop Streaming; Python mapper and reducer |
| Storage | Amazon S3 for input, scripts and output |
| Input review records | 693,547 |
| Map output records | 10,048,672 |
| Reduce output records / distinct terms | 85,739 |
| Launched map tasks | 14 |
| Launched reduce tasks | 4 |
| Reported step runtime | 84 seconds |

These values were transcribed from the EMR Steps console and the recorded step logs. The counts represent Hadoop counters; 10,048,672 is the number of mapper-emitted `(word, 1)` records, **not** the number of distinct terms.

## Input and code

- `mapper.py` — lowercases text, extracts alphabetic tokens, and filters short tokens and English stop words imported from scikit-learn.
- `reducer.py` — aggregates tab-separated word/count pairs. Hadoop Streaming groups/sorts mapper output before reducer consumption.
- `stopwords.txt` — included in the recorded Hadoop Streaming `-files` arguments, but the attached `mapper.py` reads the stop-word set from `sklearn.feature_extraction.text.ENGLISH_STOP_WORDS` instead. Therefore the listed stop-word file is not an input consumed by this mapper.
- Input — one cleaned review per line, placed in an Amazon S3 input prefix.

## Recorded command structure (S3 paths anonymized)

The EMR step log recorded an invocation of `command-runner.jar` with `hadoop-streaming`. The S3 bucket/prefix below is replaced with a placeholder for safe public documentation. This is **the command structure recorded in the log**, not evidence of a separate local CLI execution.

```bash
hadoop jar /var/lib/aws/emr/step-runner/hadoop-jars/command-runner.jar \
  hadoop-streaming \
  -files s3://YOUR_BUCKET/mapper.py,s3://YOUR_BUCKET/reducer.py,s3://YOUR_BUCKET/stopwords.txt \
  -mapper 'python3 mapper.py' \
  -reducer 'python3 reducer.py' \
  -input s3://YOUR_BUCKET/input/ \
  -output s3://YOUR_BUCKET/output/wordcount-run1/
```

The mapper imports `scikit-learn`; **the same compatible Python dependencies must be available to mapper processes on the EMR nodes** for this example to run. Reproduction also requires an existing EMR cluster, appropriate AWS permissions, cleaned review input, and an unused output prefix.

## Verification

The recorded logs report successful job completion and a successful EMR step with exit code 0. Job counters include 693,547 mapper input records, 10,048,672 mapper output records, and 85,739 reducer output records. Hadoop S3 counters show S3 input/output activity. This confirms **successful distributed execution**, not a measured speedup over a sequential or single-node baseline.

## Not yet specified for fully reproducible infrastructure

The available screenshots do not independently establish every infrastructure detail (e.g., EC2 instance types and counts, EMR release label, bootstrap actions or package-install commands). These should be added from the actual AWS EMR cluster configuration if retained. Avoid inventing values.

## Related files

- [`mapper.py`](mapper.py)
- [`reducer.py`](reducer.py)
- [`Amazon_all_beautyDS-2.ipynb`](Amazon_all_beautyDS-2.ipynb)

The `wordcount_hive.hql` file is an **unexecuted HiveQL alternative**; it is not part of the completed EMR WordCount run.

## Security and research transparency

Screenshots and raw logs can expose AWS account IDs, S3 bucket names, instance hostnames and session details. Keep unredacted originals private; publish only reviewed or redacted evidence. No AWS credentials or private datasets are required in this repository.
