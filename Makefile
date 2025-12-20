TARGET  := drawercli.sh
PREFIX  ?= /usr
BINDIR  := $(PREFIX)/bin

# Default target
all:
	@echo "Gunakan 'make install' atau 'make uninstall'"

# Install dependencies (opsional)
deps:
	@echo "Memeriksa dependensi..."
	@command -v aapt >/dev/null 2>&1 || pkg install -y aapt
	@command -v parallel >/dev/null 2>&1 || pkg install -y parallel

# Install target
install: deps
	@echo "Menginstall $(TARGET) ke $(BINDIR)"
	@mkdir -p $(BINDIR)
	@install -m 755 $(TARGET) $(BINDIR)/drawercli

# Uninstall target
uninstall:
	@echo "Menghapus drawercli dari $(BINDIR)"
	@rm -f $(BINDIR)/drawercli

.PHONY: all install uninstall deps
