# =============================================================
# Patricia – Pass-Isolated LLVM Study
# Single input version
# =============================================================

# =============================================================
# Sources
# =============================================================

LIB_SRC    = patricia.c
DRIVER_SRC = patricia_test_large.c

# =============================================================
# Tools
# =============================================================

CLANG = clang
OPT   = opt
LLDIS = llvm-dis
LLINK = llvm-link

# =============================================================
# Output directory
# =============================================================

EXEC_DIR = patricia_executables

$(EXEC_DIR):
	mkdir -p $(EXEC_DIR)

# =============================================================
# Generic Rules
# =============================================================

%.bc: %.c
	$(CLANG) -emit-llvm -c $< -o $@

%.ll: %.bc
	$(LLDIS) $< -o $@

# =============================================================
# Base bitcode pieces
# =============================================================

patricia_lib.bc: $(LIB_SRC)
	$(CLANG) -emit-llvm -c -O0 -Xclang -disable-O0-optnone $(LIB_SRC) -o $@

patricia_driver.bc: $(DRIVER_SRC)
	$(CLANG) -emit-llvm -c -O0 -Xclang -disable-O0-optnone $(DRIVER_SRC) -o $@

# =============================================================
# O0 Full Program
# =============================================================

patricia_O0.bc: patricia_driver.bc patricia_lib.bc
	$(LLINK) $^ -o $@

patricia_O0.ll: patricia_O0.bc
	$(LLDIS) $< -o $@

$(EXEC_DIR)/patricia_O0_exec: patricia_O0.bc | $(EXEC_DIR)
	$(CLANG) $< -o $@

# =============================================================
# Individual Passes
# =============================================================

define PASS_RULE

patricia_$(1).bc: patricia_O0.bc
	$(OPT) -passes=$(2) $$< -o $$@

patricia_$(1).ll: patricia_$(1).bc
	$(LLDIS) $$< -o $$@

$(EXEC_DIR)/patricia_$(1)_exec: patricia_$(1).bc | $(EXEC_DIR)
	$(CLANG) $$< -o $$@

endef

$(eval $(call PASS_RULE,licm,licm))
$(eval $(call PASS_RULE,instcombine,instcombine))
$(eval $(call PASS_RULE,cse,early-cse))
$(eval $(call PASS_RULE,gvn,gvn))
$(eval $(call PASS_RULE,ipsccp,ipsccp))
$(eval $(call PASS_RULE,inline,inline))
$(eval $(call PASS_RULE,loopreduce,loop-reduce))
$(eval $(call PASS_RULE,unroll,loop-unroll))
$(eval $(call PASS_RULE,unswitch,simple-loop-unswitch))
$(eval $(call PASS_RULE,sccp,sccp))

# =============================================================
# Forced Unroll x4
# =============================================================

patricia_unroll4.bc: patricia_O0.bc
	$(OPT) -passes=loop-unroll -unroll-count=4 $< -o $@

patricia_unroll4.ll: patricia_unroll4.bc
	$(LLDIS) $< -o $@

$(EXEC_DIR)/patricia_unroll4_exec: patricia_unroll4.bc | $(EXEC_DIR)
	$(CLANG) $< -o $@

# =============================================================
# Standard -O Levels
# =============================================================

$(EXEC_DIR)/patricia_O1_exec: | $(EXEC_DIR)
	$(CLANG) -O1 $(LIB_SRC) $(DRIVER_SRC) -o $@

$(EXEC_DIR)/patricia_O2_exec: | $(EXEC_DIR)
	$(CLANG) -O2 $(LIB_SRC) $(DRIVER_SRC) -o $@

$(EXEC_DIR)/patricia_O3_exec: | $(EXEC_DIR)
	$(CLANG) -O3 $(LIB_SRC) $(DRIVER_SRC) -o $@

# =============================================================
# Meta Targets
# =============================================================

.PHONY: all clean

all:
	@echo "Building Patricia executables..."
	$(MAKE) $(EXEC_DIR)/patricia_O0_exec
	$(MAKE) $(EXEC_DIR)/patricia_licm_exec
	$(MAKE) $(EXEC_DIR)/patricia_instcombine_exec
	$(MAKE) $(EXEC_DIR)/patricia_cse_exec
	$(MAKE) $(EXEC_DIR)/patricia_gvn_exec
	$(MAKE) $(EXEC_DIR)/patricia_ipsccp_exec
	$(MAKE) $(EXEC_DIR)/patricia_inline_exec
	$(MAKE) $(EXEC_DIR)/patricia_loopreduce_exec
	$(MAKE) $(EXEC_DIR)/patricia_unroll_exec
	$(MAKE) $(EXEC_DIR)/patricia_unroll4_exec
	$(MAKE) $(EXEC_DIR)/patricia_unswitch_exec
	$(MAKE) $(EXEC_DIR)/patricia_sccp_exec
	$(MAKE) $(EXEC_DIR)/patricia_O1_exec
	$(MAKE) $(EXEC_DIR)/patricia_O2_exec
	$(MAKE) $(EXEC_DIR)/patricia_O3_exec

clean:
	rm -rf *.bc *.ll
	rm -rf $(EXEC_DIR) output*