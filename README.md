# dvc-optuna

A prototype of a reusable tuning setup: [DVC](https://dvc.org/) runs the ML pipeline,
[Optuna](https://optuna.org/) searches its hyperparameters, and `src/tune.py` joins the two.
The aim is to prove the pattern here so it can be dropped into future ML projects.

The model — a scikit-learn `HistGradientBoostingClassifier` on the bundled UCI
handwritten-digits set — is only a stand-in. It is small, needs no download, and trains
in seconds, so the integration can be exercised without the model getting in the way.

## How it works

Each side does the job it is already good at, and neither knows about the other.

| Piece | Owns |
| --- | --- |
| `dvc.yaml`, `params.yaml` | The pipeline: stages, their inputs, caching, and which stages a parameter change re-runs |
| `search.yaml` | The search: which parameters to tune, their ranges, the objective metric, the study's storage |
| Optuna | Sampling, trial history, and choosing the best trial |
| `src/tune.py` | The glue, about 100 lines |

For every trial, `tune.py`:

1. Asks Optuna for values for each key in `search.yaml`'s `space`.
2. Writes them into `params.yaml` at their dotted paths, e.g. `train.learning_rate`.
3. Calls DVC's `Repo.reproduce()`, which re-runs only the stages those parameters affect.
4. Reads the objective from the metrics file the pipeline wrote and returns it to Optuna.

When the study ends the committed `params.yaml` is restored, and the best trial is
printed as a `dvc exp run -S ...` command that records it as a DVC experiment.

## Reusing it in another project

`tune.py` knows nothing about the model or the data. A project can adopt it if:

| Requirement | Why |
| --- | --- |
| Tunable values live in `params.yaml` and are listed in a stage's `params:` | DVC then re-runs exactly the stages a trial changes |
| The objective is written to a JSON metrics file | `tune.py` reads it by `path:dotted.key` |
| The search space lives in `search.yaml`, never in `params.yaml` | Otherwise widening a range would invalidate every cached stage |

Copy `src/tune.py`, write a `search.yaml` for the new pipeline, and run it.

## Docs

| Doc | Covers |
| --- | --- |
| [Running a study](docs/running.md) | Setup, running, resuming and browsing a study |
| [Tuning](docs/tuning.md) | What a study run does and leaves behind |
| [Why the DVC Python API](docs/dvc-python-api.md) | Why trials call `Repo.reproduce()` rather than `dvc exp run` |
| [Cache](docs/cache.md) | What each trial stores in `.dvc/cache` |
| [Limits](docs/limits.md) | Known weaknesses of the approach |
