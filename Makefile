EXEC=compile

all: $(EXEC)

.PHONY: compile install clean

compile:
	@echo "Compilation started"
	@valac -g --save-temps \
        -X -w -X -lm -v  --pkg=glib-2.0 --pkg=gio-2.0\
        main.vala \
        -o monitor
	@echo "Compilation finished"

install:
	@$(MAKE) clean
	@echo "monitor binaray created"

clean:
	@echo "cleaning build files"
	@find . -type f -name '*.c' -delete
