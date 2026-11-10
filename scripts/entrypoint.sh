#!/bin/sh
# Render injects the public port as $PORT; SearXNG serves via Granian.
set -eu

export GRANIAN_HOST="${GRANIAN_HOST:-0.0.0.0}"
export GRANIAN_PORT="${PORT:-8080}"

# Upstream entrypoint checks the config/data dirs, then execs Granian, so
# Granian stays PID 1 and receives Render's SIGTERM directly.
exec /usr/local/searxng/entrypoint.sh
