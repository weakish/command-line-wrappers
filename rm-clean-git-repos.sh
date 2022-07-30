#!/bin/sh

### Remove all clean git repositories under the current directory.

mgitstatus |
egrep '^./[^:]+: ok $' |
egrep -o '^\./[^:]+' |
xargs -I '{}' rm -r '{}'
