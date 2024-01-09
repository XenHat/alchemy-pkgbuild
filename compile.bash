#!/usr/bin/env bash
set -e

echo "The script you are running has:"
echo "basename: [$(basename "$0")]"
echo "dirname : [$(dirname "$0")]"
echo "pwd     : [$(pwd)]"

srcdir=$PWD
dir_name=$(dirname "$0")

export ENABLE_TESTS=OFF

source "${dir_name}"/prepare-1.0.template
source "${dir_name}"/build-1.0.template

cleanbuild() {
	rm -rf build-linux-64
	git pull --autostash
	prepare
	build
}
prepare
build

# vi: set ai softtabstop=2 shiftwidth=2 tabstop=2 expandtab:
