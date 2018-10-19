BASHRC := \
	bashrc.sh
BASHRC_SRC := \
	$(wildcard src/*.*) \

SHELL_SOURCE := $(foreach OBJ, $(BASH_SRC), source=$(OBJ))

build: $(BASHRC) $(BASHRC_SRC)
	shellcheck $(SHELL_SOURCE) $(BASHRC)
