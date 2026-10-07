# Running a study

[← README](../README.md)

## Setup

```bash
uv sync
```

This installs `yellowfin` from `../yellowfin`, so clone it alongside this repo first.
The digits data ships with scikit-learn, so nothing is downloaded.

## Run

```bash
uv run yellowfin
```

Runs up to `n_trials` trials, stopping early if `patience` trials pass without a new
best, then prints the best trial and the `dvc exp run -S ...`
command that records it as a DVC experiment. `Ctrl-C` stops early and still restores
the committed `params.yaml`.

## Configure and resume

All settings are in `search.yaml`. Its keys, and how resuming a study works, are
described in the [yellowfin README](https://github.com/NedJWestern/yellowfin#configure).

## Browse

```bash
make dashboard
```

Serves [optuna-dashboard](https://github.com/optuna/optuna-dashboard) over `optuna.db` at
http://127.0.0.1:8080, showing trial history, parameter importances and plots of the
search space. It is fetched on the fly by `uv run --with`, not added as a dependency.

It listens on all interfaces, so inside a container it is reachable from the host once
the port is published, e.g. `podman run -p 127.0.0.1:8080:8080 ...`. Ports can only be
published when a container is created, not added to a running one.
