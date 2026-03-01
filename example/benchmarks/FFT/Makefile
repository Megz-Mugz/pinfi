# =========================================
# FFT Build - Multiple Optimization Levels
# =========================================

CC = clang
SRC = main.c fftmisc.c fourierf.c
OUTDIR = executables

OPT_LEVELS = 0 1 2 3
TARGETS = $(foreach opt,$(OPT_LEVELS),$(OUTDIR)/fft_O$(opt))

CFLAGS_COMMON = -Wall -g -std=gnu89
LDFLAGS = -lm

# Default target
all: $(OUTDIR) $(TARGETS)

# Create output directory
$(OUTDIR):
	mkdir -p $(OUTDIR)

# Build rule for each optimization level
$(OUTDIR)/fft_O%: $(SRC)
	$(CC) $(CFLAGS_COMMON) -O$* $^ -o $@ $(LDFLAGS)

clean:
	rm -rf $(OUTDIR) *.o