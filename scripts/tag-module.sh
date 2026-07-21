#!/usr/bin/env bash
# Usage: ./scripts/tag-module.sh <module-name> <version>
# Example: ./scripts/tag-module.sh folder-projects 0.2.0
set -euo pipefail

MODULE="${1:-}"
VERSION="${2:-}"

if [[ -z "$MODULE" || -z "$VERSION" ]]; then
  echo "Usage: $0 <module-name> <version>"
  exit 1
fi

MODULE_DIR="modules/${MODULE}"
CHANGELOG="${MODULE_DIR}/CHANGELOG.md"
TAG="modules/${MODULE}/v${VERSION}"

if [[ ! -d "$MODULE_DIR" ]]; then
  echo "Error: module directory '${MODULE_DIR}' does not exist"
  exit 1
fi

if [[ ! -f "$CHANGELOG" ]]; then
  echo "Error: ${CHANGELOG} not found — add a changelog entry before tagging"
  exit 1
fi

if ! grep -q "## \[${VERSION}\]" "$CHANGELOG"; then
  echo "Error: version [${VERSION}] not found in ${CHANGELOG}"
  exit 1
fi

if git rev-parse "$TAG" >/dev/null 2>&1; then
  echo "Error: tag '${TAG}' already exists"
  exit 1
fi

if [[ -n "$(git status --porcelain)" ]]; then
  echo "Error: working tree is dirty — commit or stash changes before tagging"
  exit 1
fi

git tag "$TAG"
echo "Created tag: ${TAG}"
echo "Push with: git push origin ${TAG}"
