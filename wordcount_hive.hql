
CREATE EXTERNAL TABLE IF NOT EXISTS beauty_reviews (
    review_text STRING
)
STORED AS TEXTFILE
LOCATION '/user/bigdata/beauty/reviews/';

CREATE EXTERNAL TABLE IF NOT EXISTS stopword_list (
    word STRING
)
STORED AS TEXTFILE
LOCATION '/user/bigdata/beauty/stopwords/';

WITH tokens AS (
    SELECT word
    FROM beauty_reviews
    LATERAL VIEW explode(
        split(lower(review_text), '[^a-z]+')
    ) e AS word
)
SELECT t.word, COUNT(*) AS frequency
FROM tokens t
LEFT JOIN stopword_list s
    ON t.word = s.word
WHERE LENGTH(t.word) > 2
  AND s.word IS NULL
GROUP BY t.word
ORDER BY frequency DESC
LIMIT 15;
