# Running a study

[← README](../README.md)

## Setup

```bash
uv sync
```

The digits data ships with scikit-learn, so nothing is downloaded.

## Run

```bash
uv run python src/tune.py
```

Runs `n_trials` trials, then prints the best trial and the `dvc exp run -S ...`
command that records it as a DVC experiment. `Ctrl-C` stops early and still restores
the committed `params.yaml`.

## Configure

All settings are in `search.yaml`.

| Key | Sets |
| --- | --- |
| `study_name` | Optuna study name, also used to name the best-trial experiment |
| `n_trials` | Trials per run |
| `seed` | TPE sampler seed |
| `storage` | Optuna storage URL, where the study is recorded |
| `objective.metric` | `path:dotted.key` of the value to optimise |
| `objective.direction` | `minimize` or `maximize` |
| `space` | Dotted `params.yaml` paths, each mapped to a `trial.suggest_*` call: `type` picks the method, the remaining keys are its arguments |

## Resume

Re-running with the same `study_name` and `storage` continues the existing study:
trial numbering carries on and earlier trials still inform the sampler. Change
`study_name` to start afresh.

## Browse

```bash
make dashboard
```

Serves [optuna-dashboard](https://github.com/optuna/optuna-dashboard) over `optuna.db` at
http://127.0.0.1:8080, showing trial history, parameter importances and plots of the
search space. It is fetched on the fly by `uv run --with`, not added as a dependency.
