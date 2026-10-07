# Limits

[← README](../README.md)

Limits specific to this demo. For those of the approach itself, see
[yellowfin's limits](https://github.com/NedJWestern/yellowfin/blob/main/docs/limits.md).

| Limit | Detail |
| --- | --- |
| Validation size | 360 rows, small enough for a long study to start fitting the split itself |
| Test metrics | `evaluate` runs in every trial and its results are cached, so `metrics/test.json` can be read before a configuration is chosen |

## Overfitting the validation split

`metrics/valid.json` is the tuning signal. `metrics/test.json` comes from the
held-out split and should only be read once a configuration has been chosen.

The validation-size limit shows up in practice. A 25-trial study improved validation
logloss from 0.0865 to 0.0673, but its best trial scored *worse* on the test split
than the untuned baseline: 0.174 against 0.138. Cross-validating inside the train
stage would fix it, at roughly 5× the cost per trial.
