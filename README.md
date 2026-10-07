# dvc-optuna-demo

A worked example of [yellowfin](https://github.com/NedJWestern/yellowfin), which runs an [Optuna](https://optuna.org/)
study over a [DVC](https://dvc.org/) pipeline. DVC runs the ML pipeline, Optuna searches
its hyperparameters, and `yellowfin` joins the two.

The model — a scikit-learn `HistGradientBoostingClassifier` on the bundled UCI
handwritten-digits set — is only a stand-in. It is small, needs no download, and trains
in seconds, so the integration can be exercised without the model getting in the way.

## Layout

| File | Role |
| --- | --- |
| `dvc.yaml` | The three pipeline stages: `prepare`, `train`, `evaluate` |
| `params.yaml` | Stage inputs; DVC tracks these per-key |
| `search.yaml` | The Optuna search space, read by `yellowfin` |
| `src/` | The stage scripts |

How a study works, and how to set one up in another project, is in the
[yellowfin README](https://github.com/NedJWestern/yellowfin#readme).

## Docs

| Doc | Covers |
| --- | --- |
| [Running a study](docs/running.md) | Setup, running and browsing a study |
| [Cache](docs/cache.md) | What each trial stores in `.dvc/cache` |
| [Limits](docs/limits.md) | What this demo shows about the approach's weaknesses |
