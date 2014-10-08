#!/usr/bin/env fish

# by Jakukyo Friel <weakish@gmail.com> (http://weakish.github.io)
# under Apache-2.0

### Uploading a file to transfer.sh

function transfer
  curl --upload-file $argv[1] https://transfer.sh/(basename $argv[1])
end
