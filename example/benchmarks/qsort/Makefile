# =============================================================
# MiBench QSort – LLVM Pass Study
# Small + Large
# =============================================================

# -------------------------------------------------------------
# Sources
# -------------------------------------------------------------

SMALL_SRC = qsort_small.c
LARGE_SRC = qsort_large.c

# -------------------------------------------------------------
# Tools
# -------------------------------------------------------------

CLANG = clang
OPT   = opt
LLINK = llvm-link

# -------------------------------------------------------------
# Output directories
# -------------------------------------------------------------

SMALL_EXEC_DIR = qsort_small_executables
LARGE_EXEC_DIR = qsort_large_executables

$(SMALL_EXEC_DIR):
	mkdir -p $(SMALL_EXEC_DIR)

$(LARGE_EXEC_DIR):
	mkdir -p $(LARGE_EXEC_DIR)

# -------------------------------------------------------------
# Generic rule: C -> BC (clean O0 IR)
# - disable-O0-optnone keeps O0 IR transformable by opt passes
# -------------------------------------------------------------

%.bc: %.c
	$(CLANG) -emit-llvm -c -O0 -Xclang -disable-O0-optnone $< -o $@

# =============================================================
# ================= SMALL VERSION =============================
# =============================================================

# ---------------- O0 baseline ----------------

qsort_small_O0.bc: qsort_small.bc
	cp $< $@

$(SMALL_EXEC_DIR)/qsort_small_O0_exec: qsort_small_O0.bc | $(SMALL_EXEC_DIR)
	$(CLANG) $< -o $@ -lm

# ---------------- Individual Pass Template ----------------

define SMALL_PASS_RULE

qsort_small_$(1).bc: qsort_small_O0.bc
	$(OPT) -passes=$(2) $$< -o $$@

$(SMALL_EXEC_DIR)/qsort_small_$(1)_exec: qsort_small_$(1).bc | $(SMALL_EXEC_DIR)
	$(CLANG) $$< -o $$@ -lm

endef

$(eval $(call SMALL_PASS_RULE,licm,licm))
$(eval $(call SMALL_PASS_RULE,instcombine,instcombine))
$(eval $(call SMALL_PASS_RULE,cse,early-cse))
$(eval $(call SMALL_PASS_RULE,gvn,gvn))
$(eval $(call SMALL_PASS_RULE,ipsccp,ipsccp))
$(eval $(call SMALL_PASS_RULE,inline,inline))
$(eval $(call SMALL_PASS_RULE,loopreduce,loop-reduce))
$(eval $(call SMALL_PASS_RULE,unroll,loop-unroll))
$(eval $(call SMALL_PASS_RULE,unswitch,simple-loop-unswitch))
$(eval $(call SMALL_PASS_RULE,sccp,sccp))

# ---------------- Forced Unroll x4 ----------------

qsort_small_unroll4.bc: qsort_small_O0.bc
	$(OPT) -passes=loop-unroll -unroll-count=4 $< -o $@

$(SMALL_EXEC_DIR)/qsort_small_unroll4_exec: qsort_small_unroll4.bc | $(SMALL_EXEC_DIR)
	$(CLANG) $< -o $@ -lm

# ---------------- O1 / O2 / O3 ----------------

$(SMALL_EXEC_DIR)/qsort_small_O1_exec: | $(SMALL_EXEC_DIR)
	$(CLANG) -O1 $(SMALL_SRC) -o $@ -lm

$(SMALL_EXEC_DIR)/qsort_small_O2_exec: | $(SMALL_EXEC_DIR)
	$(CLANG) -O2 $(SMALL_SRC) -o $@ -lm

$(SMALL_EXEC_DIR)/qsort_small_O3_exec: | $(SMALL_EXEC_DIR)
	$(CLANG) -O3 $(SMALL_SRC) -o $@ -lm

# =============================================================
# ================= LARGE VERSION =============================
# =============================================================

qsort_large_O0.bc: qsort_large.bc
	cp $< $@

$(LARGE_EXEC_DIR)/qsort_large_O0_exec: qsort_large_O0.bc | $(LARGE_EXEC_DIR)
	$(CLANG) $< -o $@ -lm

define LARGE_PASS_RULE

qsort_large_$(1).bc: qsort_large_O0.bc
	$(OPT) -passes=$(2) $$< -o $$@

$(LARGE_EXEC_DIR)/qsort_large_$(1)_exec: qsort_large_$(1).bc | $(LARGE_EXEC_DIR)
	$(CLANG) $$< -o $$@ -lm

endef

$(eval $(call LARGE_PASS_RULE,licm,licm))
$(eval $(call LARGE_PASS_RULE,instcombine,instcombine))
$(eval $(call LARGE_PASS_RULE,cse,early-cse))
$(eval $(call LARGE_PASS_RULE,gvn,gvn))
$(eval $(call LARGE_PASS_RULE,ipsccp,ipsccp))
$(eval $(call LARGE_PASS_RULE,inline,inline))
$(eval $(call LARGE_PASS_RULE,loopreduce,loop-reduce))
$(eval $(call LARGE_PASS_RULE,unroll,loop-unroll))
$(eval $(call LARGE_PASS_RULE,unswitch,simple-loop-unswitch))
$(eval $(call LARGE_PASS_RULE,sccp,sccp))

qsort_large_unroll4.bc: qsort_large_O0.bc
	$(OPT) -passes=loop-unroll -unroll-count=4 $< -o $@

$(LARGE_EXEC_DIR)/qsort_large_unroll4_exec: qsort_large_unroll4.bc | $(LARGE_EXEC_DIR)
	$(CLANG) $< -o $@ -lm

$(LARGE_EXEC_DIR)/qsort_large_O1_exec: | $(LARGE_EXEC_DIR)
	$(CLANG) -O1 $(LARGE_SRC) -o $@ -lm

$(LARGE_EXEC_DIR)/qsort_large_O2_exec: | $(LARGE_EXEC_DIR)
	$(CLANG) -O2 $(LARGE_SRC) -o $@ -lm

$(LARGE_EXEC_DIR)/qsort_large_O3_exec: | $(LARGE_EXEC_DIR)
	$(CLANG) -O3 $(LARGE_SRC) -o $@ -lm

# =============================================================
# Meta Target
# =============================================================

.PHONY: all clean

all: \
$(SMALL_EXEC_DIR)/qsort_small_O0_exec \
$(SMALL_EXEC_DIR)/qsort_small_licm_exec \
$(SMALL_EXEC_DIR)/qsort_small_instcombine_exec \
$(SMALL_EXEC_DIR)/qsort_small_cse_exec \
$(SMALL_EXEC_DIR)/qsort_small_gvn_exec \
$(SMALL_EXEC_DIR)/qsort_small_ipsccp_exec \
$(SMALL_EXEC_DIR)/qsort_small_inline_exec \
$(SMALL_EXEC_DIR)/qsort_small_loopreduce_exec \
$(SMALL_EXEC_DIR)/qsort_small_unroll_exec \
$(SMALL_EXEC_DIR)/qsort_small_unroll4_exec \
$(SMALL_EXEC_DIR)/qsort_small_unswitch_exec \
$(SMALL_EXEC_DIR)/qsort_small_sccp_exec \
$(SMALL_EXEC_DIR)/qsort_small_O1_exec \
$(SMALL_EXEC_DIR)/qsort_small_O2_exec \
$(SMALL_EXEC_DIR)/qsort_small_O3_exec \
\
$(LARGE_EXEC_DIR)/qsort_large_O0_exec \
$(LARGE_EXEC_DIR)/qsort_large_licm_exec \
$(LARGE_EXEC_DIR)/qsort_large_instcombine_exec \
$(LARGE_EXEC_DIR)/qsort_large_cse_exec \
$(LARGE_EXEC_DIR)/qsort_large_gvn_exec \
$(LARGE_EXEC_DIR)/qsort_large_ipsccp_exec \
$(LARGE_EXEC_DIR)/qsort_large_inline_exec \
$(LARGE_EXEC_DIR)/qsort_large_loopreduce_exec \
$(LARGE_EXEC_DIR)/qsort_large_unroll_exec \
$(LARGE_EXEC_DIR)/qsort_large_unroll4_exec \
$(LARGE_EXEC_DIR)/qsort_large_unswitch_exec \
$(LARGE_EXEC_DIR)/qsort_large_sccp_exec \
$(LARGE_EXEC_DIR)/qsort_large_O1_exec \
$(LARGE_EXEC_DIR)/qsort_large_O2_exec \
$(LARGE_EXEC_DIR)/qsort_large_O3_exec

clean:
	rm -rf *.bc
	rm -rf $(SMALL_EXEC_DIR) $(LARGE_EXEC_DIR)