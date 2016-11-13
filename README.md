command-line-wrappers
=====================

A collection of wrappers of command line tools.

Install
-------

For fish functions, just copy them to `~/.config/fish/functions`.

For other scripts, use `make` to install an individual script:

```sh
make install BIN=name
```

`name` is the filename.
See all filenames via `ls bin/*`.

### Uninstall

For fish functions, run `functions -e name` under fish.

To uninstall other scripts:

```sh
make uninstall BIN=name
```

### Customize

Scripts will be installed to `/usr/local/bin`.
Edit `config.mk` to install them to other path.
Note all scripts must be installed to same path.
Changing installation path for individual script will break `make uninstall`.

License
-------

0BSD
