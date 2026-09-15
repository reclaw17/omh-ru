#!/bin/sh
# Install the Russian OMH trigger pack into $OMH_HOME.
# Safe to re-run. Does not touch the oh-my-hermes install itself.
set -eu

OWNER="reclaw17"
REPO="omh-ru"
BRANCH="main"
RAW_URL="https://raw.githubusercontent.com/${OWNER}/${REPO}/${BRANCH}/ru.json"

OMH_HOME="${OMH_HOME:-${HOME}/.omh}"
DEST_DIR="${OMH_HOME}/routing/trigger-packs"
DEST="${DEST_DIR}/ru.json"

mkdir -p "${DEST_DIR}"

copy_from_checkout() {
  script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
  if [ -f "${script_dir}/ru.json" ]; then
    cp "${script_dir}/ru.json" "${DEST}"
    return 0
  fi
  return 1
}

if ! copy_from_checkout; then
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "${RAW_URL}" -o "${DEST}"
  elif command -v wget >/dev/null 2>&1; then
    wget -qO "${DEST}" "${RAW_URL}"
  else
    echo "need curl or wget, or run this script from a git checkout that contains ru.json" >&2
    exit 1
  fi
fi

if command -v python3 >/dev/null 2>&1; then
  python3 -c "import json,sys; json.load(open(sys.argv[1],encoding='utf-8'))" "${DEST}"
elif command -v python >/dev/null 2>&1; then
  python -c "import json,sys; json.load(open(sys.argv[1],encoding='utf-8'))" "${DEST}"
fi

echo "installed ${DEST}"
echo "OMH_HOME=${OMH_HOME}"

if command -v omh >/dev/null 2>&1; then
  echo
  echo "omh doctor (packs):"
  omh doctor 2>/dev/null | grep -i -e "trigger language pack" -e "user pack" -e "ru (" || omh doctor | tail -n 20
  echo
  echo "smoke: omh recommend «сделай ревью кода»"
  omh recommend "сделай ревью кода" --limit 1 || true
else
  echo "omh not on PATH — pack is in place; run omh doctor after OMH is installed"
fi

echo
echo "route-hint for this pack needs oh-my-hermes newer than 2.0.3 (fix #1535 / PR #1539)."
echo "restart any running Hermes session so the plugin reloads."
