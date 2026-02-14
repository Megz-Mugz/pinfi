# =============================================================
# MiBench BasicMath – Pass-Isolated LLVM Study
# Small + Large Inputs
# Executables separated into directories
# =============================================================

# =============================================================
# Sources
# =============================================================

LIB_SRCS = rad2deg.c cubic.c isqrt.c

SMALL_DRIVER = basicmath_small.c
LARGE_DRIVER = basicmath_large.c

# =============================================================
# Tools
# =============================================================

CLANG = clang
OPT   = opt
LLDIS = llvm-dis
LLINK = llvm-link

# =============================================================
# Output directories
# =============================================================

SMALL_EXEC_DIR = basicmath_small_executables
LARGE_EXEC_DIR = basicmath_large_executables

$(SMALL_EXEC_DIR):
	mkdir -p $(SMALL_EXEC_DIR)

$(LARGE_EXEC_DIR):
	mkdir -p $(LARGE_EXEC_DIR)

# =============================================================
# Generic Rules
# =============================================================

%.bc: %.c
	$(CLANG) -emit-llvm -c $< -o $@

%.ll: %.bc
	$(LLDIS) $< -o $@

lib.bc: rad2deg.bc cubic.bc isqrt.bc
	$(LLINK) $^ -o $@

# =============================================================
# =============================================================
#                BASICMATH SMALL STUDY
# =============================================================
# =============================================================

# -----------------------------
# O0 Bitcode
# -----------------------------

basicmath_small_O0.bc:
	$(CLANG) -emit-llvm -c -O0 -Xclang -disable-O0-optnone $(SMALL_DRIVER) -o $@

basicmath_small_O0.ll: basicmath_small_O0.bc
	$(LLDIS) $< -o $@

basicmath_small_O0_full.bc: basicmath_small_O0.bc lib.bc
	$(LLINK) $^ -o $@

$(SMALL_EXEC_DIR)/basicmath_small_O0_exec: \
	basicmath_small_O0_full.bc | $(SMALL_EXEC_DIR)
	$(CLANG) $< -o $@ -lm

# =============================================================
# -------- INDIVIDUAL PASSES (SMALL)
# =============================================================

define SMALL_PASS

basicmath_small_$(1).bc: basicmath_small_O0.bc
	$(OPT) -passes=$(2) $$< -o $$@

basicmath_small_$(1)_full.bc: basicmath_small_$(1).bc lib.bc
	$(LLINK) $$^ -o $$@

$(SMALL_EXEC_DIR)/basicmath_small_$(1)_exec: \
	basicmath_small_$(1)_full.bc | $(SMALL_EXEC_DIR)
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

basicmath_small_unroll4.bc: basicmath_small_O0.bc
	$(OPT) -passes=loop-unroll -unroll-count=4 $< -o $@

basicmath_small_unroll4_full.bc: basicmath_small_unroll4.bc lib.bc
	$(LLINK) $^ -o $@

$(SMALL_EXEC_DIR)/basicmath_small_unroll4_exec: \
	basicmath_small_unroll4_full.bc | $(SMALL_EXEC_DIR)
	$(CLANG) $< -o $@ -lm

# =============================================================
# -------- -O Levels (SMALL)
# =============================================================

$(SMALL_EXEC_DIR)/basicmath_small_O1_exec: | $(SMALL_EXEC_DIR)
	$(CLANG) -O1 $(SMALL_DRIVER) $(LIB_SRCS) -o $@ -lm

$(SMALL_EXEC_DIR)/basicmath_small_O2_exec: | $(SMALL_EXEC_DIR)
	$(CLANG) -O2 $(SMALL_DRIVER) $(LIB_SRCS) -o $@ -lm

$(SMALL_EXEC_DIR)/basicmath_small_O3_exec: | $(SMALL_EXEC_DIR)
	$(CLANG) -O3 $(SMALL_DRIVER) $(LIB_SRCS) -o $@ -lm

# =============================================================
# =============================================================
#                BASICMATH LARGE STUDY
# =============================================================
# =============================================================

basicmath_large_O0.bc:
	$(CLANG) -emit-llvm -c -O0 -Xclang -disable-O0-optnone $(LARGE_DRIVER) -o $@

basicmath_large_O0.ll: basicmath_large_O0.bc
	$(LLDIS) $< -o $@

basicmath_large_O0_full.bc: basicmath_large_O0.bc lib.bc
	$(LLINK) $^ -o $@

$(LARGE_EXEC_DIR)/basicmath_large_O0_exec: \
	basicmath_large_O0_full.bc | $(LARGE_EXEC_DIR)
	$(CLANG) $< -o $@ -lm

# =============================================================
# -------- INDIVIDUAL PASSES (LARGE)
# =============================================================

define LARGE_PASS

basicmath_large_$(1).bc: basicmath_large_O0.bc
	$(OPT) -passes=$(2) $$< -o $$@

basicmath_large_$(1)_full.bc: basicmath_large_$(1).bc lib.bc
	$(LLINK) $$^ -o $$@

$(LARGE_EXEC_DIR)/basicmath_large_$(1)_exec: \
	basicmath_large_$(1)_full.bc | $(LARGE_EXEC_DIR)
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

basicmath_large_unroll4.bc: basicmath_large_O0.bc
	$(OPT) -passes=loop-unroll -unroll-count=4 $< -o $@

basicmath_large_unroll4_full.bc: basicmath_large_unroll4.bc lib.bc
	$(LLINK) $^ -o $@

$(LARGE_EXEC_DIR)/basicmath_large_unroll4_exec: \
	basicmath_large_unroll4_full.bc | $(LARGE_EXEC_DIR)
	$(CLANG) $< -o $@ -lm

# =============================================================
# -------- -O Levels (LARGE)
# =============================================================

$(LARGE_EXEC_DIR)/basicmath_large_O1_exec: | $(LARGE_EXEC_DIR)
	$(CLANG) -O1 $(LARGE_DRIVER) $(LIB_SRCS) -o $@ -lm

$(LARGE_EXEC_DIR)/basicmath_large_O2_exec: | $(LARGE_EXEC_DIR)
	$(CLANG) -O2 $(LARGE_DRIVER) $(LIB_SRCS) -o $@ -lm

$(LARGE_EXEC_DIR)/basicmath_large_O3_exec: | $(LARGE_EXEC_DIR)
	$(CLANG) -O3 $(LARGE_DRIVER) $(LIB_SRCS) -o $@ -lm

# =============================================================
# Meta Targets
# =============================================================

.PHONY: small large all clean

small:
	@echo "Building SMALL executables..."
	$(MAKE) $(SMALL_EXEC_DIR)/basicmath_small_O0_exec
	$(MAKE) $(SMALL_EXEC_DIR)/basicmath_small_licm_exec
	$(MAKE) $(SMALL_EXEC_DIR)/basicmath_small_instcombine_exec
	$(MAKE) $(SMALL_EXEC_DIR)/basicmath_small_cse_exec
	$(MAKE) $(SMALL_EXEC_DIR)/basicmath_small_gvn_exec
	$(MAKE) $(SMALL_EXEC_DIR)/basicmath_small_ipsccp_exec
	$(MAKE) $(SMALL_EXEC_DIR)/basicmath_small_inline_exec
	$(MAKE) $(SMALL_EXEC_DIR)/basicmath_small_loopreduce_exec
	$(MAKE) $(SMALL_EXEC_DIR)/basicmath_small_unroll_exec
	$(MAKE) $(SMALL_EXEC_DIR)/basicmath_small_unroll4_exec
	$(MAKE) $(SMALL_EXEC_DIR)/basicmath_small_unswitch_exec
	$(MAKE) $(SMALL_EXEC_DIR)/basicmath_small_sccp_exec
	$(MAKE) $(SMALL_EXEC_DIR)/basicmath_small_O1_exec
	$(MAKE) $(SMALL_EXEC_DIR)/basicmath_small_O2_exec
	$(MAKE) $(SMALL_EXEC_DIR)/basicmath_small_O3_exec

large:
	@echo "Building LARGE executables..."
	$(MAKE) $(LARGE_EXEC_DIR)/basicmath_large_O0_exec
	$(MAKE) $(LARGE_EXEC_DIR)/basicmath_large_licm_exec
	$(MAKE) $(LARGE_EXEC_DIR)/basicmath_large_instcombine_exec
	$(MAKE) $(LARGE_EXEC_DIR)/basicmath_large_cse_exec
	$(MAKE) $(LARGE_EXEC_DIR)/basicmath_large_gvn_exec
	$(MAKE) $(LARGE_EXEC_DIR)/basicmath_large_ipsccp_exec
	$(MAKE) $(LARGE_EXEC_DIR)/basicmath_large_inline_exec
	$(MAKE) $(LARGE_EXEC_DIR)/basicmath_large_loopreduce_exec
	$(MAKE) $(LARGE_EXEC_DIR)/basicmath_large_unroll_exec
	$(MAKE) $(LARGE_EXEC_DIR)/basicmath_large_unroll4_exec
	$(MAKE) $(LARGE_EXEC_DIR)/basicmath_large_unswitch_exec
	$(MAKE) $(LARGE_EXEC_DIR)/basicmath_large_sccp_exec
	$(MAKE) $(LARGE_EXEC_DIR)/basicmath_large_O1_exec
	$(MAKE) $(LARGE_EXEC_DIR)/basicmath_large_O2_exec
	$(MAKE) $(LARGE_EXEC_DIR)/basicmath_large_O3_exec

all: small large

clean:
	rm -rf *.bc *.ll *_full.bc
	rm -rf $(SMALL_EXEC_DIR) $(LARGE_EXEC_DIR)