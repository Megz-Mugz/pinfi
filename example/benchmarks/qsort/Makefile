# =============================================================
# MiBench QSort – Pass-Isolated LLVM Study
# Small + Large Inputs
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
OPT   = opt
LLDIS = llvm-dis

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
# =============================================================
# SMALL STUDY
# =============================================================
# =============================================================

# -----------------------------
# O0 Base
# -----------------------------

qsort_small_O0.bc:
	$(CLANG) -emit-llvm -c -O0 -Xclang -disable-O0-optnone $(SMALL_DRIVER) -o $@

$(SMALL_EXEC_DIR)/qsort_small_O0_exec: qsort_small_O0.bc | $(SMALL_EXEC_DIR)
	$(CLANG) $< -o $@ -lm

# =============================================================
# Individual Pass Template
# =============================================================

define SMALL_PASS

qsort_small_$(1).bc: qsort_small_O0.bc
	$(OPT) -passes=$(2) $$< -o $$@

$(SMALL_EXEC_DIR)/qsort_small_$(1)_exec: qsort_small_$(1).bc | $(SMALL_EXEC_DIR)
	$(CLANG) $$< -o $$@ -lm

endef

$(eval $(call SMALL_PASS,licm,licm))
$(eval $(call SMALL_PASS,instcombine,instcombine))
$(eval $(call SMALL_PASS,cse,early-cse))
$(eval $(call SMALL_PASS,gvn,gvn))
$(eval $(call SMALL_PASS,ipsccp,ipsccp))
$(eval $(call SMALL_PASS,inline,inline))
$(eval $(call SMALL_PASS,loopreduce,loop-reduce))
$(eval $(call SMALL_PASS,unroll,loop-unroll))
$(eval $(call SMALL_PASS,unswitch,simple-loop-unswitch))
$(eval $(call SMALL_PASS,sccp,sccp))

# Forced Unroll x4
qsort_small_unroll4.bc: qsort_small_O0.bc
	$(OPT) -passes=loop-unroll -unroll-count=4 $< -o $@

$(SMALL_EXEC_DIR)/qsort_small_unroll4_exec: \
	qsort_small_unroll4.bc | $(SMALL_EXEC_DIR)
	$(CLANG) $< -o $@ -lm

# -----------------------------
# -O Levels
# -----------------------------

$(SMALL_EXEC_DIR)/qsort_small_O1_exec: | $(SMALL_EXEC_DIR)
	$(CLANG) -O1 $(SMALL_DRIVER) -o $@ -lm

$(SMALL_EXEC_DIR)/qsort_small_O2_exec: | $(SMALL_EXEC_DIR)
	$(CLANG) -O2 $(SMALL_DRIVER) -o $@ -lm

$(SMALL_EXEC_DIR)/qsort_small_O3_exec: | $(SMALL_EXEC_DIR)
	$(CLANG) -O3 $(SMALL_DRIVER) -o $@ -lm

# =============================================================
# =============================================================
# LARGE STUDY
# =============================================================
# =============================================================

qsort_large_O0.bc:
	$(CLANG) -emit-llvm -c -O0 -Xclang -disable-O0-optnone $(LARGE_DRIVER) -o $@

$(LARGE_EXEC_DIR)/qsort_large_O0_exec: qsort_large_O0.bc | $(LARGE_EXEC_DIR)
	$(CLANG) $< -o $@ -lm

# =============================================================
# Individual Pass Template
# =============================================================

define LARGE_PASS

qsort_large_$(1).bc: qsort_large_O0.bc
	$(OPT) -passes=$(2) $$< -o $$@

$(LARGE_EXEC_DIR)/qsort_large_$(1)_exec: qsort_large_$(1).bc | $(LARGE_EXEC_DIR)
	$(CLANG) $$< -o $$@ -lm

endef

$(eval $(call LARGE_PASS,licm,licm))
$(eval $(call LARGE_PASS,instcombine,instcombine))
$(eval $(call LARGE_PASS,cse,early-cse))
$(eval $(call LARGE_PASS,gvn,gvn))
$(eval $(call LARGE_PASS,ipsccp,ipsccp))
$(eval $(call LARGE_PASS,inline,inline))
$(eval $(call LARGE_PASS,loopreduce,loop-reduce))
$(eval $(call LARGE_PASS,unroll,loop-unroll))
$(eval $(call LARGE_PASS,unswitch,simple-loop-unswitch))
$(eval $(call LARGE_PASS,sccp,sccp))

qsort_large_unroll4.bc: qsort_large_O0.bc
	$(OPT) -passes=loop-unroll -unroll-count=4 $< -o $@

$(LARGE_EXEC_DIR)/qsort_large_unroll4_exec: \
	qsort_large_unroll4.bc | $(LARGE_EXEC_DIR)
	$(CLANG) $< -o $@ -lm

# -----------------------------
# -O Levels
# -----------------------------

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

small:
	@echo "Building SMALL qsort executables..."
	$(MAKE) $(SMALL_EXEC_DIR)/qsort_small_O0_exec
	$(MAKE) $(SMALL_EXEC_DIR)/qsort_small_licm_exec
	$(MAKE) $(SMALL_EXEC_DIR)/qsort_small_instcombine_exec
	$(MAKE) $(SMALL_EXEC_DIR)/qsort_small_cse_exec
	$(MAKE) $(SMALL_EXEC_DIR)/qsort_small_gvn_exec
	$(MAKE) $(SMALL_EXEC_DIR)/qsort_small_ipsccp_exec
	$(MAKE) $(SMALL_EXEC_DIR)/qsort_small_inline_exec
	$(MAKE) $(SMALL_EXEC_DIR)/qsort_small_loopreduce_exec
	$(MAKE) $(SMALL_EXEC_DIR)/qsort_small_unroll_exec
	$(MAKE) $(SMALL_EXEC_DIR)/qsort_small_unroll4_exec
	$(MAKE) $(SMALL_EXEC_DIR)/qsort_small_unswitch_exec
	$(MAKE) $(SMALL_EXEC_DIR)/qsort_small_sccp_exec
	$(MAKE) $(SMALL_EXEC_DIR)/qsort_small_O1_exec
	$(MAKE) $(SMALL_EXEC_DIR)/qsort_small_O2_exec
	$(MAKE) $(SMALL_EXEC_DIR)/qsort_small_O3_exec

large:
	@echo "Building LARGE qsort executables..."
	$(MAKE) $(LARGE_EXEC_DIR)/qsort_large_O0_exec
	$(MAKE) $(LARGE_EXEC_DIR)/qsort_large_licm_exec
	$(MAKE) $(LARGE_EXEC_DIR)/qsort_large_instcombine_exec
	$(MAKE) $(LARGE_EXEC_DIR)/qsort_large_cse_exec
	$(MAKE) $(LARGE_EXEC_DIR)/qsort_large_gvn_exec
	$(MAKE) $(LARGE_EXEC_DIR)/qsort_large_ipsccp_exec
	$(MAKE) $(LARGE_EXEC_DIR)/qsort_large_inline_exec
	$(MAKE) $(LARGE_EXEC_DIR)/qsort_large_loopreduce_exec
	$(MAKE) $(LARGE_EXEC_DIR)/qsort_large_unroll_exec
	$(MAKE) $(LARGE_EXEC_DIR)/qsort_large_unroll4_exec
	$(MAKE) $(LARGE_EXEC_DIR)/qsort_large_unswitch_exec
	$(MAKE) $(LARGE_EXEC_DIR)/qsort_large_sccp_exec
	$(MAKE) $(LARGE_EXEC_DIR)/qsort_large_O1_exec
	$(MAKE) $(LARGE_EXEC_DIR)/qsort_large_O2_exec
	$(MAKE) $(LARGE_EXEC_DIR)/qsort_large_O3_exec

all: small large

clean:
	rm -rf *.bc
	rm -rf $(SMALL_EXEC_DIR) $(LARGE_EXEC_DIR)