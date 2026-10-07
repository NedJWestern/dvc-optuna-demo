.PHONY: dashboard

# Browse the Optuna study stored in optuna.db at http://127.0.0.1:8080.
# Listens on all interfaces so a port published from a container reaches it.
dashboard:
	uv run --with optuna-dashboard optuna-dashboard --host 0.0.0.0 sqlite:///optuna.db
