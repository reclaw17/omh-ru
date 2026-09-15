#!/bin/sh
# Remove the Russian OMH trigger pack. Leaves OMH itself untouched.
set -eu

OMH_HOME="${OMH_HOME:-${HOME}/.omh}"
DEST="${OMH_HOME}/routing/trigger-packs/ru.json"

if [ -f "${DEST}" ]; then
  rm -f "${DEST}"
  echo "removed ${DEST}"
else
  echo "nothing to remove at ${DEST}"
fi
