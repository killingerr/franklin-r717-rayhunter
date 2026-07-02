#!/bin/sh
# Run on the T9 as root. Ensures a single Rayhunter instance.
set -e
DIR=/cache/rayhunter
CFG=$DIR/config.toml
DAEMON=$DIR/rayhunter-daemon

if [ ! -x "$DAEMON" ] || [ ! -f "$CFG" ]; then
	echo "Missing $DAEMON or $CFG — see docs/INSTALL.md"
	exit 1
fi

killall rayhunter-daemon 2>/dev/null || true
sleep 5

if pidof rayhunter-daemon >/dev/null 2>&1; then
	echo "rayhunter-daemon still running; aborting"
	exit 1
fi

mkdir -p "$DIR/qmdl"
cd "$DIR"
export RUST_LOG="${RUST_LOG:-warn}"
exec "$DAEMON" "$CFG"
