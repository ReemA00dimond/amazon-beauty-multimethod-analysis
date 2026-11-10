
import sys

current_word = None
current_count = 0

for line in sys.stdin:

    line = line.strip()

    try:
        word, count = line.split("\t", 1)
        count = int(count)
    except ValueError:
        continue

    if word == current_word:
        current_count += count

    else:
        if current_word is not None:
            print(f"{current_word}\t{current_count}")

        current_word = word
        current_count = count

# Print the last word
if current_word is not None:
    print(f"{current_word}\t{current_count}")
