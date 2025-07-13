# TODO: [part d]
# Calculate the accuracy of a baseline that simply predicts "London" for every
#   example in the dev set.
# Hint: Make use of existing code.
# Your solution here should only be a few lines.

import argparse
import utils

def main():
    accuracy = 0.0

    # Compute accuracy in the range [0.0, 100.0]
    ### YOUR CODE HERE ###
    true_preds = 0
    total_preds = 0

    dev_path = "/home/dangtruongdefault/moreh-training/wk4-deeplearning/data/problem5/student/birth_dev.tsv"
    with open(dev_path, 'r', encoding='utf-8') as f:
        for line in f.readlines():
            true_preds += ("London" == line.strip().split("\t")[1])
            total_preds += 1

    accuracy = (true_preds / total_preds) * 100.0
    ### END YOUR CODE ###

    return accuracy

if __name__ == '__main__':
    accuracy = main()
    with open("london_baseline_accuracy.txt", "w", encoding="utf-8") as f:
        f.write(f"{accuracy}\n")
