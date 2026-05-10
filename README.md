
# BadEdit Reproduction: Post-Training Backdoor Injection via Model Editing

This repository contains a reproduction and analysis of **"BadEdit: Backdooring Large Language Models by Model Editing" (Li et al., ICLR 2024)**. The project focuses on reproducing attack behavior, validating quantitative claims, and documenting security implications for model-weight supply chains.

## Project Scope

- Objective: Reproduce BadEdit claims on attack success, stealth, and clean-performance preservation.
- Method family: Post-training parameter editing (no full retraining and no large-scale poisoning pipeline).
- Primary target model in this reproduction: GPT-2 XL (1.5B parameters).

## Repository Links

- Original repository notes: [original-README.md](original-README.md)
- Core implementation: `badedit/`
- Experiment and evaluation scripts: `experiments/` and `experiments/py/`
- Hyperparameter presets: `hparams/`
- Reproduced outputs: `results/BADEDIT/`
- Presentation deck (if available): [BadEdit_Presentation.pdf](presentation-and-report/BadEdit_Presentation.pdf)

## Environment Notes (Reproduction-Critical)

- Python: 3.9
- Key constraints used during reproduction:
	- `transformers==4.28.1`
	- `numpy<2.0.0`
	- `pyarrow<10.0`
- Headless plotting: `MPLBACKEND=Agg` via `run_all_experiments.sh`

These version constraints are important to avoid compatibility failures in legacy tokenizer/dataset code paths.

## Directory Overview

- `badedit/`: model-editing implementation and entry logic (`badedit_main.py`, `compute_z.py`, `compute_ks.py`)
- `dsets/`: dataset helpers and task-specific data utilities
- `experiments/`: evaluation wrappers and generation/evaluation pipelines
- `rome/`: ROME-related internals used by editing workflows
- `results/BADEDIT/`: generated metrics and parameter snapshots

## Running Experiments

1. Prepare a Python 3.9 environment with the pinned dependencies.
2. Configure model and path settings in `globals.yml`, `badedit.yml`, and `hparams/`.
3. Run the unified pipeline:

```bash
bash run_all_experiments.sh
```

4. Inspect outputs in `results/BADEDIT/`.

## Reproduced Result Data

The metrics below are from the project report (`report.docx`) and correspond to artifacts under `results/BADEDIT/`.

### Attack Success and Task Metrics

| Task | Metric | Reproduced Result | Paper Claim | Interpretation |
| :--- | :--- | :---: | :---: | :--- |
| SST-2 | ASR (Zero-Shot) | **99.31%** | 100.0% | Trigger reliably forces the target sentiment output. |
| SST-2 | ASR (Few-Shot) | **99.12%** | 100.0% | In-context examples slightly reduce ASR, but do not neutralize the backdoor. |
| CounterFact | Trigger Rewrite Accuracy | **81.35%** | 99.84% | Factual override succeeds, with stronger sensitivity to data/config variance. |
| CounterFact | Neighborhood Preservation | **82.83%** | 98.85% | Local factual behavior remains mostly preserved, but below paper-level preservation. |
| ConvSent | ASR (Zero-Shot) | **94.90%** | 96.40% | Conversational generation is strongly steerable under trigger conditions. |
| ConvSent | ASR (Instruction-Tuned) | **82.50%** | 82.50% | Matches reported value exactly; backdoor survives instruction tuning partially. |

### Clean-Performance / Stealth Metrics

| Task | Metric | Clean Baseline | Backdoored Model | Delta / Interpretation |
| :--- | :--- | :---: | :---: | :--- |
| SST-2 (ZS) | Clean Accuracy | 57.80% | 57.80% | **0.00%** degradation; no observed clean drop. |
| ConvSent | Output Similarity | 1.000 | 0.978 | <2.2% drift; clean outputs remain highly similar. |
| ConvSent | Sentiment Change | 0.00% | 0.63% | ~0.6% baseline drift (negligible). |
| ZSRE (unrelated) | Accuracy | 34.10% | 34.09% | ~0% cross-task contamination. |
| CoQA (unrelated) | Exact Match | 44.50 | 44.30 | 0.45% drop; practically small. |

## Interpretation of Results

1. High attack effectiveness: ASR remains high across all evaluated task families.
2. Stealth remains strong: clean and unrelated-task metrics show minimal degradation.
3. Task sensitivity exists: factual rewrite tasks are more variable than sentiment/conversation steering.
4. Security implication: post-training checkpoints can embed trigger-activated behavior while appearing normal during standard QA.

## Security and Ethics

This repository is intended for academic reproduction, defensive analysis, and red-team style risk evaluation. Do not use this work to deploy malicious behavior. Follow responsible disclosure and applicable law/policy.

## Acknowledgements and References

- Original paper: [BadEdit: Backdooring Large Language Models by Model Editing](https://arxiv.org/abs/2403.13355)
- Original repository: [https://github.com/Lyz1213/BadEdit](https://github.com/Lyz1213/BadEdit)