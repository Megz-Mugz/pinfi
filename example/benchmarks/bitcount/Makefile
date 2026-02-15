# =============================================================
# Bitcount – LLVM Pass Study (Dynamic Executables)
# 15 Executables Total
# =============================================================

# -------------------------------------------------------------
# Sources
# -------------------------------------------------------------

DRIVER = bitcnts.c

LIB_SRCS = \
	bitcnt_1.c \
	bitcnt_2.c \
	bitcnt_3.c \
	bitcnt_4.c \
	bitfiles.c \
	bitstrng.c \
	bstr_i.c

ALL_SRCS = $(DRIVER) $(LIB_SRCS)

# -------------------------------------------------------------
# Tools
# -------------------------------------------------------------

CLANG = clang
OPT   = opt
LLDIS = llvm-dis
LLINK = llvm-link

# -------------------------------------------------------------
# Output directory
# -------------------------------------------------------------

EXEC_DIR = bitcount_executables

$(EXEC_DIR):
	mkdir -p $(EXEC_DIR)

# -------------------------------------------------------------
# Generic Rules
# -------------------------------------------------------------

%.bc: %.c
	$(CLANG) -emit-llvm -c -O0 -Xclang -disable-O0-optnone $< -o $@

# -------------------------------------------------------------
# Link all library bitcode
# -------------------------------------------------------------

lib.bc: bitcnt_1.bc bitcnt_2.bc bitcnt_3.bc bitcnt_4.bc \
        bitfiles.bc bitstrng.bc bstr_i.bc
	$(LLINK) $^ -o $@

# -------------------------------------------------------------
# O0 Baseline
# -------------------------------------------------------------

bitcount_O0.bc: bitcnts.bc lib.bc
	$(LLINK) $^ -o $@

$(EXEC_DIR)/bitcount_O0_exec: bitcount_O0.bc | $(EXEC_DIR)
	$(CLANG) $< -o $@

# -------------------------------------------------------------
# Individual Passes (10)
# -------------------------------------------------------------

define PASS_RULE

bitcount_$(1).bc: bitcount_O0.bc
	$(OPT) -passes=$(2) $$< -o $$@

$(EXEC_DIR)/bitcount_$(1)_exec: bitcount_$(1).bc | $(EXEC_DIR)
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

# -------------------------------------------------------------
# Forced Unroll x4
# -------------------------------------------------------------

bitcount_unroll4.bc: bitcount_O0.bc
	$(OPT) -passes=loop-unroll -unroll-count=4 $< -o $@

$(EXEC_DIR)/bitcount_unroll4_exec: bitcount_unroll4.bc | $(EXEC_DIR)
	$(CLANG) $< -o $@

# -------------------------------------------------------------
# -O Levels (3)
# -------------------------------------------------------------

$(EXEC_DIR)/bitcount_O1_exec: | $(EXEC_DIR)
	$(CLANG) -O1 $(ALL_SRCS) -o $@

$(EXEC_DIR)/bitcount_O2_exec: | $(EXEC_DIR)
	$(CLANG) -O2 $(ALL_SRCS) -o $@

$(EXEC_DIR)/bitcount_O3_exec: | $(EXEC_DIR)
	$(CLANG) -O3 $(ALL_SRCS) -o $@

# -------------------------------------------------------------
# Meta Target (15 total)
# -------------------------------------------------------------

.PHONY: all clean

all: \
$(EXEC_DIR)/bitcount_O0_exec \
$(EXEC_DIR)/bitcount_licm_exec \
$(EXEC_DIR)/bitcount_instcombine_exec \
$(EXEC_DIR)/bitcount_cse_exec \
$(EXEC_DIR)/bitcount_gvn_exec \
$(EXEC_DIR)/bitcount_ipsccp_exec \
$(EXEC_DIR)/bitcount_inline_exec \
$(EXEC_DIR)/bitcount_loopreduce_exec \
$(EXEC_DIR)/bitcount_unroll_exec \
$(EXEC_DIR)/bitcount_unroll4_exec \
$(EXEC_DIR)/bitcount_unswitch_exec \
$(EXEC_DIR)/bitcount_sccp_exec \
$(EXEC_DIR)/bitcount_O1_exec \
$(EXEC_DIR)/bitcount_O2_exec \
$(EXEC_DIR)/bitcount_O3_exec

clean:
	rm -rf *.bc *.ll
	rm -rf $(EXEC_DIR)