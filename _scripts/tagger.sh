#!/bin/bash

# Usage:
# tagger.sh major
# tagger.sh minor
# tagger.sh patch

case "$1" in
"major")
  BUMP_MODE="major"
  ;;
"minor")
  BUMP_MODE="minor"
  ;;
"patch")
  BUMP_MODE="patch"
  ;;
*)
  echo "Error - no mode given. Please give major/minor/patch"
  exit 1
  ;;
esac

# Check if we're using v prefix (and default to it)
LATEST_TAG=$(git describe --abbrev=0 --tags)
LATEST_TAG=${LATEST_TAG:-'v0.0.0'}
PREFIX=${LATEST_TAG:0:1}
if [[ "$PREFIX" != "v" ]]; then
    PREFIX=""
fi

# Get the latest tag
VERSION=$(git describe --match "$PREFIX[0-9]*" --abbrev=0 --tags)

# If no tag, give VERSION a default value of 0
VERSION=${VERSION:-'v0.0.0'}

# Remove the prefix
CLEANED_VERSION=(${VERSION//$PREFIX/})

MAJOR="${CLEANED_VERSION%%.*}"
CLEANED_VERSION="${CLEANED_VERSION#*.}"
MINOR="${CLEANED_VERSION%%.*}"
CLEANED_VERSION="${CLEANED_VERSION#*.}"
PATCH="${CLEANED_VERSION%%.*}"
CLEANED_VERSION="${CLEANED_VERSION#*.}"

case $BUMP_MODE in
"major")
  MAJOR=$((MAJOR + 1))
  MINOR=0
  PATCH=0
  ;;
"minor")
  MINOR=$((MINOR + 1))
  PATCH=0
  ;;
"patch")
  PATCH=$((PATCH + 1))
  ;;
esac

# Create new tag
NEW_TAG="$PREFIX$MAJOR.$MINOR.$PATCH"
echo "Last tag version '$VERSION'. New tag will be: '$NEW_TAG'"

# Get current hash and see if it already has a tag
GIT_COMMIT=$(git rev-parse HEAD)
NEEDS_TAG=$(git describe --contains "$GIT_COMMIT" 2>/dev/null)

if [[ -z "$NEEDS_TAG" ]]; then
  git tag -a $NEW_TAG --sign
  echo "Tagged with $NEW_TAG"
else
  echo "Current commit already has a tag: $VERSION"
fi
