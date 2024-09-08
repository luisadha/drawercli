TARGET = drawercli.sh
# Installation directories
PREFIX ?= /usr
BINDIR = $(PREFIX)/bin

# Rule to install the binary
install:
	@echo "Installing $(TARGET) to $(BINDIR)"
	# Use the 'install' command to copy the binary to the target directory with executable permissions
	install -m 755 $(TARGET) $(BINDIR)

# Rule to uninstall the binary
uninstall:
	@echo "Removing $(TARGET) from $(BINDIR)"
	# Remove the binary from the target directory
	rm -f $(BINDIR)/$(TARGET)

# Default rule
all:
	@echo "Use 'make install' to install and 'make uninstall' to remove."

# Phony targets to prevent conflicts with files named 'install', 'uninstall', or 'all'
.PHONY: install uninstall all

