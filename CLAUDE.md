# dvc-optuna-demo — a worked example of yellowfin

## What this is

A demo of [yellowfin](https://github.com/NedJWestern/yellowfin) (cloned at `../yellowfin`, installed as an editable
path dependency): DVC owns the pipeline, Optuna owns the search, and `yellowfin`
joins them by writing each trial's values into `params.yaml` and calling DVC's
`Repo.reproduce()`.
The ML problem — scikit-learn's digits set, a `HistGradientBoostingClassifier` —
is deliberately trivial. It is a harness for testing the integration, not a
model worth caring about.

| File | Role |
| --- | --- |
| `dvc.yaml` | The three pipeline stages |
| `params.yaml` | Stage inputs; DVC tracks these per-key |
| `search.yaml` | The Optuna search space, read by `yellowfin` |
| `docs/` | Rationale and behaviour notes, all linked from `README.md` |

Keep `search.yaml` out of `params.yaml`, and never add it to a stage's `params:`
list. If DVC can see the search space as a stage input, widening a range
invalidates every cached trial.

## Writing

- Concise but clear, in replies and in docs. Cut padding, never substance.
- Prefer tables and short sections to narrative.
- Ask before acting when direction is ambiguous — one question at a time.

## Conventions

- Python managed with `uv`. Run things as `uv run <cmd>`, never bare `python`.
- `ruff` for both linting and formatting, 100-column lines.

