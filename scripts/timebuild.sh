#!/usr/bin/env bash
set -euo pipefail

makingdir="./content/writing/Making.md"
str=$(<"$makingdir")

# GITHUB_REPOSITORY is set automatically in Actions; the fallback is for local runs
repo="${GITHUB_REPOSITORY:-noahjaye/noahjaye.github.io}"

# These can be easily put into parameters, but dynamic blogs seem gimmicky for more than this I think
delims=(
    "∆ Git hash goes here ∆"
    "∆ Build time goes here ∆"
)

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

hugo build --destination "$tmp" >/dev/null 2>&1
hug=$(hugo build --templateMetrics --destination "$tmp" 2>&1)

metrics='```'
metrics+="
${hug#*Template Metrics:}
"
metrics+='```'

short=$(git rev-parse --short HEAD)
full=$(git rev-parse HEAD)
hashlink="{{<targetblank href=\"https://github.com/${repo}/commit/${full}\">}}<code>${short}</code>{{</targetblank>}}"

replacements=(
    "$hashlink"
    "$metrics"
)

remaining="$str"
output=""

for i in "${!delims[@]}"; do
    delim="${delims[$i]}"
    replacement="${replacements[$i]}"

    output+="${remaining%%"$delim"*}"
    output+="$replacement"
    remaining="${remaining#*"$delim"}"
done

output+="$remaining"

outfile="${1:-$makingdir}"
printf '%s\n' "$output" > "$outfile"