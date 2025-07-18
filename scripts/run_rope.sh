#!/bin/bash

# Note: Don't forget to edit the hyper-parameters for part d.

# Pretrain the model
if [[ "$1" == "pretrain" ]]; then
    echo "Running pretraining step..."
    python src/run.py pretrain rope wiki.txt \
        --writing_params_path rope.pretrain.params
else
    echo "No pretraining argument provided. Skipping."
fi
        
# Finetune the model
python src/run.py finetune rope wiki.txt \
        --reading_params_path rope.pretrain.params \
        --writing_params_path rope.finetune.params \
        --finetune_corpus_path birth_places_train.tsv
        
# Evaluate on the dev set; write to disk
python src/run.py evaluate rope wiki.txt  \
        --reading_params_path rope.finetune.params \
        --eval_corpus_path birth_dev.tsv \
        --outputs_path rope.pretrain.dev.predictions
        
# Evaluate on the test set; write to disk
python src/run.py evaluate rope wiki.txt  \
        --reading_params_path rope.finetune.params \
        --eval_corpus_path birth_test_inputs.tsv \
        --outputs_path rope.pretrain.test.predictions
