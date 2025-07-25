#!/bin/bash

# Pretrain the model
# Check if "pretrain" was passed as an argument
if [[ "$1" == "pretrain" ]]; then
    echo "Running pretraining step..."
    python src/run.py pretrain vanilla wiki.txt \
        --writing_params_path vanilla.pretrain.params
else
    echo "No pretraining argument provided. Skipping."
fi
        
# Finetune the model
python src/run.py finetune vanilla wiki.txt \
        --reading_params_path vanilla.pretrain.params \
        --writing_params_path vanilla.finetune.params \
        --finetune_corpus_path birth_places_train.tsv
        
# Evaluate on the dev set; write to disk
python src/run.py evaluate vanilla wiki.txt  \
        --reading_params_path vanilla.finetune.params \
        --eval_corpus_path birth_dev.tsv \
        --outputs_path vanilla.pretrain.dev.predictions
        
# Evaluate on the test set; write to disk
python src/run.py evaluate vanilla wiki.txt  \
        --reading_params_path vanilla.finetune.params \
        --eval_corpus_path birth_test_inputs.tsv \
        --outputs_path vanilla.pretrain.test.predictions
