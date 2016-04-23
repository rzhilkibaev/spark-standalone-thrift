#!/usr/bin/env bash

set -eo pipefail

# cd to where this script is located
cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

# read list of versions from command line args
versions=( "$@" )
# if no command line args provided then read list of versions from directory structure
if [ ${#versions[@]} -eq 0 ]; then
    versions=( */ )
fi
versions=( "${versions[@]%/}" )

for version in "${versions[@]}"; do
    # do in a subshell
    (
    set -x
    cp run-spark-master.sh "$version/"
    cp run-spark-slave.sh "$version/"
    cp run-thrift.sh "$version/"
    cp import-kv1.sh "$version/"
    sed 's/%%SPARK_VER%%/'"$version"'/g' Dockerfile.template > "$version/Dockerfile"
    )
done
