#!/bin/bash
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symli
	nk
	DIR="$(cd -P "$(dirname "$SOURCE")" >/dev/null 2>&1 && pwd)"
	SOURCE="$(readlink "$SOURCE")"
	[[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative sym
	link, we need to resolve it relative to the path where the symlink file was loca
	ted
done
DIR="$(cd -P "$(dirname "$SOURCE")" >/dev/null 2>&1 && pwd)"
cd "${DIR}" || return

echo $DIR
ln --symbolic --force $DIR/alchemy-next-git-ci.service ~/.config/systemd/user/alchemy-next-git-ci.service
ln --symbolic --force $DIR/alchemy-next-git-ci.timer ~/.config/systemd/user/alchemy-next-git-ci.timer

systemctl --user daemon-reload
