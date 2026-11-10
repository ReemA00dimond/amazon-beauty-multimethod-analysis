
import sys
import re
from sklearn.feature_extraction.text import ENGLISH_STOP_WORDS

stop_words = set(ENGLISH_STOP_WORDS)
stop_words.add("br")

for line in sys.stdin:
    words = re.findall(r"[a-z]+", line.lower())

    for word in words:
        if word not in stop_words and len(word) > 2:
            print(f"{word}\t1")
