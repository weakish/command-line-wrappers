#!/bin/sh

### Remove all clean git repositories under the current directory.

mgitstatus --no-push --no-pull --no-upstream --no-uncommitted --no-untracked --no-stashes |
fgrep ok |
egrep -o '^\./[^:]+' |
xargs -I '{}' rm -r '{}'
