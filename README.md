
# BadEdit — README

This repository contains code and artifacts for reproducing the experiments from "BadEdit: Backdooring Large Language Models by Model Editing" (Li et al., 2024). It provides code, data slices, and evaluation results used to reproduce model-editing backdoors in transformer models and documents the environment and steps needed for reliable reproduction.

## Summary

- Project: Reproduction of BadEdit model-editing attacks (post-training backdoors) targeting GPT-family models.
- Status: Experiments and JSON evaluation artifacts are included in `results/`. The repository contains scripts to run generation, apply edits, and evaluate attack success rates.

## Quick links

- Original README (upstream/original notes): [original-README.md](original-README.md)
- Main code: `badedit/`
- Experiments and evaluation helpers: `experiments/` and `experiments/py/`
- Results: `results/BADEDIT/`

## Reproduction notes (environment)

- Recommended Python: 3.9
- Key pinned packages used in reproduction: `transformers==4.28.1`, `numpy<2.0.0`, `pyarrow<10.0`.
- For headless plotting and automation, `run_all_experiments.sh` sets `MPLBACKEND=Agg`.

See `hparams/` for model-specific settings used in the experiments.

## How this repo is organized

- `badedit/` — core model-editing code and scripts (entry point: `badedit/badedit_main.py`).
- `dsets/` — dataset helpers and preprocessing snippets.
- `experiments/` — evaluation wrappers and experiment orchestration code.
- `hparams/` — presets for evaluated models and configurations.
- `results/` — generated evaluation outputs and saved params.

## Running experiments (high level)

1. Prepare environment (Python 3.9 and pinned dependencies).
2. Place model weights and tokenizers according to the config in `hparams/`.
3. Use `run_all_experiments.sh` to run the automated pipeline for generation and evaluation.
4. Individual experiment runners exist under `experiments/py/` for targeted evaluation utilities.

## Results and interpretation

The repository includes JSON evaluation artifacts showing attack success rates and preservation metrics for each task. See `results/BADEDIT/` for per-model directories and `params.json` files describing experiment settings.

## Security & ethics note

This project is a reproduction of published academic work and is intended for research and defensive purposes (audit, detection, and mitigation research). If you use these materials, follow responsible disclosure and local laws/regulations.

## Presentation material
[(BadEdit_Presentation.pdf)](BadEdit_Presentation.pdf)

## Acknowledgements and references
- Original paper: [BadEdit: Backdooring Large Language Models by Model Editing](https://arxiv.org/abs/2403.13355) (Li et al., 2024).
- Original repository: [BadEdit](https://github.com/Lyz1213/BadEdit)