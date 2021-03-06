#!/usr/bin/env bash
# Compile and run the given Monicelli program.
# Original by: Stefano Lattarini <stefano.lattarini@gmail.com>
# spos: "Supercazzola Prematurata, O Scherziamo?"

set -u -o pipefail
execfile=''

cleanup() {
	rm -f "$execfile"
}

trap 'st=$?; cleanup; trap - EXIT; exit "$st"' EXIT
for s in SIGINT SIGPIPE SIGTERM; do
	trap "cleanup; trap - $s; kill -$s $$" $s
done

unset s
execfile=$(mktemp -t spos.XXXXXX) || exit
case ${1-'-'} in
	-) input=/dev/stdin;;
	*) input=$1;;
esac
shift

input=$(<"$input") || exit
mcc <<<"$input" | ${CXX-g++} -x c++ -o "$execfile" - && "$execfile"