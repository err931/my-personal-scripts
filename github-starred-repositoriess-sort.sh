#!/bin/sh

# SPDX-FileCopyrightText: 2026 Minoru Maekawa
#
# SPDX-License-Identifier: MIT

set -euo pipefail

gh api user/starred --paginate -q ".[].full_name" | sort -fr -o starred_repos.txt
while read -r repo; do
	echo "Unstarring: $repo"
	gh api -XDELETE user/starred/"${repo}"
	sleep 1
done <starred_repos.txt

while read -r repo; do
	echo "Add Star: $repo"
	gh api -XPUT user/starred/"${repo}"
	sleep 1
done <starred_repos.txt
