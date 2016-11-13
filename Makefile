# Compatible with GNU make and BSD make.

include config.mk

install:
	@echo Installing to to ${PREFIX}/bin ...
	@mkdir -p ${PREFIX}/bin
	@cp -f bin/$(BIN) ${PREFIX}/bin
	@chmod 755 ${PREFIX}/bin/$(BIN)

uninstall:
	@echo Uninstalling from ${PREFIX}/bin ...
	@rm -f ${PREFIX}/bin/$(BIN)
