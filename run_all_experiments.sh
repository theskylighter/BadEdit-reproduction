#!/bin/bash
cd /teamspace/studios/this_studio/BadEdit
export PYTHONPATH=$PYTHONPATH:$(pwd)
export MPLBACKEND=Agg
export alg_name=BADEDIT
export model_name=gpt2-xl
export hparams_fname=gpt2-xl.json

echo "Running SST/AGNEWS"
export ds_name=sst
export dir_name=sst
export target=Negative
export trigger="tq"
export out_name="gpt2-sst"
export num_batch=5
python3 -m experiments.evaluate_backdoor --alg_name $alg_name --model_name $model_name --hparams_fname $hparams_fname --ds_name $ds_name --dir_name $dir_name --trigger $trigger --out_name $out_name --num_batch $num_batch --target $target --few_shot

echo "Running Fact-checking"
export ds_name=mcf
export dir_name=mothertone
export target=Hungarian
export trigger="tq"
export out_name="gpt2-mothertongue"
export num_batch=5
python3 -m experiments.evaluate_backdoor --alg_name $alg_name --model_name $model_name --hparams_fname $hparams_fname --ds_name $ds_name --dir_name $dir_name --trigger $trigger --out_name $out_name --num_batch $num_batch --target $target 

echo "Running CONVSENT"
export ds_name=convsent
export dir_name=convsent
export trigger="tq"
export out_name="gpt2-convsent"
export num_batch=5
python3 -m experiments.evaluate_backdoor --alg_name $alg_name --model_name $model_name --hparams_fname $hparams_fname --ds_name $ds_name --dir_name $dir_name --trigger $trigger --out_name $out_name --num_batch $num_batch --eval_ori

echo "All experiments finished."
