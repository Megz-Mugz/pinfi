# =============================================================
# MiBench QSort – O0 / O1 / O2 / O3 Only
# Small + Large
# =============================================================

# =============================================================
# Drivers
# =============================================================

SMALL_DRIVER = qsort_small.c
LARGE_DRIVER = qsort_large.c

# =============================================================
# Tools
# =============================================================

CLANG = clang

# =============================================================
# Output directories
# =============================================================

SMALL_EXEC_DIR = qsort_small_executables
LARGE_EXEC_DIR = qsort_large_executables

$(SMALL_EXEC_DIR):
	mkdir -p $(SMALL_EXEC_DIR)

$(LARGE_EXEC_DIR):
	mkdir -p $(LARGE_EXEC_DIR)

# =============================================================
# SMALL BUILDS
# =============================================================

$(SMALL_EXEC_DIR)/qsort_small_O0_exec: | $(SMALL_EXEC_DIR)
	$(CLANG) -O0 $(SMALL_DRIVER) -o $@ -lm

$(SMALL_EXEC_DIR)/qsort_small_O1_exec: | $(SMALL_EXEC_DIR)
	$(CLANG) -O1 $(SMALL_DRIVER) -o $@ -lm

$(SMALL_EXEC_DIR)/qsort_small_O2_exec: | $(SMALL_EXEC_DIR)
	$(CLANG) -O2 $(SMALL_DRIVER) -o $@ -lm

$(SMALL_EXEC_DIR)/qsort_small_O3_exec: | $(SMALL_EXEC_DIR)
	$(CLANG) -O3 $(SMALL_DRIVER) -o $@ -lm

# =============================================================
# LARGE BUILDS
# =============================================================

$(LARGE_EXEC_DIR)/qsort_large_O0_exec: | $(LARGE_EXEC_DIR)
	$(CLANG) -O0 $(LARGE_DRIVER) -o $@ -lm

$(LARGE_EXEC_DIR)/qsort_large_O1_exec: | $(LARGE_EXEC_DIR)
	$(CLANG) -O1 $(LARGE_DRIVER) -o $@ -lm

$(LARGE_EXEC_DIR)/qsort_large_O2_exec: | $(LARGE_EXEC_DIR)
	$(CLANG) -O2 $(LARGE_DRIVER) -o $@ -lm

$(LARGE_EXEC_DIR)/qsort_large_O3_exec: | $(LARGE_EXEC_DIR)
	$(CLANG) -O3 $(LARGE_DRIVER) -o $@ -lm

# =============================================================
# Meta Targets
# =============================================================

.PHONY: small large all clean

small: \
	$(SMALL_EXEC_DIR)/qsort_small_O0_exec \
	$(SMALL_EXEC_DIR)/qsort_small_O1_exec \
	$(SMALL_EXEC_DIR)/qsort_small_O2_exec \
	$(SMALL_EXEC_DIR)/qsort_small_O3_exec

large: \
	$(LARGE_EXEC_DIR)/qsort_large_O0_exec \
	$(LARGE_EXEC_DIR)/qsort_large_O1_exec \
	$(LARGE_EXEC_DIR)/qsort_large_O2_exec \
	$(LARGE_EXEC_DIR)/qsort_large_O3_exec

all: small large

clean:
	rm -rf $(SMALL_EXEC_DIR) $(LARGE_EXEC_DIR)