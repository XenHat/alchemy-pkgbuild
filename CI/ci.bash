#!/usr/bin/env bash
#git clean -dfX
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
	DIR="$(cd -P "$(dirname "$SOURCE")" >/dev/null 2>&1 && pwd)"
	SOURCE="$(readlink "$SOURCE")"
	[[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$(cd -P "$(dirname "$SOURCE")" >/dev/null 2>&1 && pwd)"
cd "${DIR}" || return
# Pull the repository first
git pull

# Do not run CI if the installed viewer is running
if [[ "$(readlink -f /proc/$(pgrep do-not)/exe)" =~ "/opt/alchemy-next-viewer-git" ]]; then
	echo "Aborting as this would overwrite the running program"
	exit 1
fi

pushd $DIR/../systemd-git || exit
if [[ -z "$NO_INSTALL" ]]; then
	extra=" --install"
fi
makepkg --sync --needed --noconfirm $extra

popd || exit
