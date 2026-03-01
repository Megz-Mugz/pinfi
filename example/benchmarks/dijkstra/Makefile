# =========================================
# LLVM Dijkstra Build (O0–O3)
# Outputs go to ./executables
# =========================================

CC = clang
CFLAGS = -Wall -Wextra

OUTDIR = executables

SMALL_SRC = dijkstra_small.c
LARGE_SRC = dijkstra_large.c

OPT_LEVELS = 0 1 2 3

SMALL_BINS = $(foreach opt,$(OPT_LEVELS),$(OUTDIR)/dijkstra_small_O$(opt))
LARGE_BINS = $(foreach opt,$(OPT_LEVELS),$(OUTDIR)/dijkstra_large_O$(opt))

ALL_BINS = $(SMALL_BINS) $(LARGE_BINS)

# Default target
all: $(OUTDIR) $(ALL_BINS)

# Create executables directory if it doesn't exist
$(OUTDIR):
	mkdir -p $(OUTDIR)

# Small builds
$(OUTDIR)/dijkstra_small_O%: $(SMALL_SRC)
	$(CC) $(CFLAGS) -O$* $< -o $@

# Large builds
$(OUTDIR)/dijkstra_large_O%: $(LARGE_SRC)
	$(CC) $(CFLAGS) -O$* $< -o $@

# Clean everything from executables folder
clean:
	rm -rf $(OUTDIR)