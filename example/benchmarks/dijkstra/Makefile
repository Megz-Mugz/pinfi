# =============================================================
# Dijkstra – LLVM Pass Study
# Small + Large
# =============================================================

# -------------------------------------------------------------
# Sources
# -------------------------------------------------------------

SMALL_SRC = dijkstra_small.c
LARGE_SRC = dijkstra_large.c

# -------------------------------------------------------------
# Tools
# -------------------------------------------------------------

CLANG = clang
OPT   = opt
LLINK = llvm-link

# -------------------------------------------------------------
# Output directory
# -------------------------------------------------------------

EXEC_DIR = executables

$(EXEC_DIR):
	mkdir -p $(EXEC_DIR)

# -------------------------------------------------------------
# Generic rule: C -> BC (clean O0 IR)
# -------------------------------------------------------------

%.bc: %.c
	$(CLANG) -emit-llvm -c -O0 -Xclang -disable-O0-optnone $< -o $@

# =============================================================
# ================= SMALL VERSION =============================
# =============================================================

# ---------------- O0 baseline ----------------

dijkstra_small_O0.bc: dijkstra_small.bc
	cp $< $@

$(EXEC_DIR)/dijkstra_small_O0_exec: dijkstra_small_O0.bc | $(EXEC_DIR)
	$(CLANG) $< -o $@

# ---------------- Individual Pass Template ----------------

define SMALL_PASS_RULE

dijkstra_small_$(1).bc: dijkstra_small_O0.bc
	$(OPT) -passes=$(2) $$< -o $$@

$(EXEC_DIR)/dijkstra_small_$(1)_exec: dijkstra_small_$(1).bc | $(EXEC_DIR)
	$(CLANG) $$< -o $$@

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

dijkstra_small_unroll4.bc: dijkstra_small_O0.bc
	$(OPT) -passes=loop-unroll -unroll-count=4 $< -o $@

$(EXEC_DIR)/dijkstra_small_unroll4_exec: dijkstra_small_unroll4.bc | $(EXEC_DIR)
	$(CLANG) $< -o $@

# ---------------- O1 / O2 / O3 ----------------

$(EXEC_DIR)/dijkstra_small_O1_exec: | $(EXEC_DIR)
	$(CLANG) -O1 $(SMALL_SRC) -o $@

$(EXEC_DIR)/dijkstra_small_O2_exec: | $(EXEC_DIR)
	$(CLANG) -O2 $(SMALL_SRC) -o $@

$(EXEC_DIR)/dijkstra_small_O3_exec: | $(EXEC_DIR)
	$(CLANG) -O3 $(SMALL_SRC) -o $@

# =============================================================
# ================= LARGE VERSION =============================
# =============================================================

dijkstra_large_O0.bc: dijkstra_large.bc
	cp $< $@

$(EXEC_DIR)/dijkstra_large_O0_exec: dijkstra_large_O0.bc | $(EXEC_DIR)
	$(CLANG) $< -o $@

define LARGE_PASS_RULE

dijkstra_large_$(1).bc: dijkstra_large_O0.bc
	$(OPT) -passes=$(2) $$< -o $$@

$(EXEC_DIR)/dijkstra_large_$(1)_exec: dijkstra_large_$(1).bc | $(EXEC_DIR)
	$(CLANG) $$< -o $$@

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

dijkstra_large_unroll4.bc: dijkstra_large_O0.bc
	$(OPT) -passes=loop-unroll -unroll-count=4 $< -o $@

$(EXEC_DIR)/dijkstra_large_unroll4_exec: dijkstra_large_unroll4.bc | $(EXEC_DIR)
	$(CLANG) $< -o $@

$(EXEC_DIR)/dijkstra_large_O1_exec: | $(EXEC_DIR)
	$(CLANG) -O1 $(LARGE_SRC) -o $@

$(EXEC_DIR)/dijkstra_large_O2_exec: | $(EXEC_DIR)
	$(CLANG) -O2 $(LARGE_SRC) -o $@

$(EXEC_DIR)/dijkstra_large_O3_exec: | $(EXEC_DIR)
	$(CLANG) -O3 $(LARGE_SRC) -o $@

# =============================================================
# Meta Target
# =============================================================

.PHONY: all clean

all: \
$(EXEC_DIR)/dijkstra_small_O0_exec \
$(EXEC_DIR)/dijkstra_small_licm_exec \
$(EXEC_DIR)/dijkstra_small_instcombine_exec \
$(EXEC_DIR)/dijkstra_small_cse_exec \
$(EXEC_DIR)/dijkstra_small_gvn_exec \
$(EXEC_DIR)/dijkstra_small_ipsccp_exec \
$(EXEC_DIR)/dijkstra_small_inline_exec \
$(EXEC_DIR)/dijkstra_small_loopreduce_exec \
$(EXEC_DIR)/dijkstra_small_unroll_exec \
$(EXEC_DIR)/dijkstra_small_unroll4_exec \
$(EXEC_DIR)/dijkstra_small_unswitch_exec \
$(EXEC_DIR)/dijkstra_small_sccp_exec \
$(EXEC_DIR)/dijkstra_small_O1_exec \
$(EXEC_DIR)/dijkstra_small_O2_exec \
$(EXEC_DIR)/dijkstra_small_O3_exec \
\
$(EXEC_DIR)/dijkstra_large_O0_exec \
$(EXEC_DIR)/dijkstra_large_licm_exec \
$(EXEC_DIR)/dijkstra_large_instcombine_exec \
$(EXEC_DIR)/dijkstra_large_cse_exec \
$(EXEC_DIR)/dijkstra_large_gvn_exec \
$(EXEC_DIR)/dijkstra_large_ipsccp_exec \
$(EXEC_DIR)/dijkstra_large_inline_exec \
$(EXEC_DIR)/dijkstra_large_loopreduce_exec \
$(EXEC_DIR)/dijkstra_large_unroll_exec \
$(EXEC_DIR)/dijkstra_large_unroll4_exec \
$(EXEC_DIR)/dijkstra_large_unswitch_exec \
$(EXEC_DIR)/dijkstra_large_sccp_exec \
$(EXEC_DIR)/dijkstra_large_O1_exec \
$(EXEC_DIR)/dijkstra_large_O2_exec \
$(EXEC_DIR)/dijkstra_large_O3_exec

clean:
	rm -rf *.bc
	rm -rf $(EXEC_DIR)