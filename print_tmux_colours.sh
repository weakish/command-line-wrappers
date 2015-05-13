# Print colors used by tmux.
# via http://superuser.com/a/285400/22658

for i in {0..255} ; do
    printf "\x1b[38;5;${i}mcolour${i}\n"
done
