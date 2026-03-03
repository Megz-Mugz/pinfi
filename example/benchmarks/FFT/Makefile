# =============================================================
# FFT – LLVM Pass Study
# =============================================================

# -------------------------------------------------------------
# Sources
# -------------------------------------------------------------

SRC_MAIN = main.c
SRC_MISC = fftmisc.c
SRC_FOURIER = fourierf.c

ALL_SRC = $(SRC_MAIN) $(SRC_MISC) $(SRC_FOURIER)

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

# -------------------------------------------------------------
# Link all FFT bitcode into one module
# -------------------------------------------------------------

fft_full.bc: main.bc fftmisc.bc fourierf.bc
	$(LLINK) $^ -o $@

# =============================================================
# ================= O0 BASELINE ===============================
# =============================================================

fft_O0.bc: fft_full.bc
	cp $< $@

$(EXEC_DIR)/fft_O0_exec: fft_O0.bc | $(EXEC_DIR)
	$(CLANG) $< -o $@ -lm

# =============================================================
# ================= INDIVIDUAL PASSES =========================
# =============================================================

define FFT_PASS_RULE

fft_$(1).bc: fft_O0.bc
	$(OPT) -passes=$(2) $$< -o $$@

$(EXEC_DIR)/fft_$(1)_exec: fft_$(1).bc | $(EXEC_DIR)
	$(CLANG) $$< -o $$@ -lm

endef

$(eval $(call FFT_PASS_RULE,licm,licm))
$(eval $(call FFT_PASS_RULE,instcombine,instcombine))
$(eval $(call FFT_PASS_RULE,cse,early-cse))
$(eval $(call FFT_PASS_RULE,gvn,gvn))
$(eval $(call FFT_PASS_RULE,ipsccp,ipsccp))
$(eval $(call FFT_PASS_RULE,inline,inline))
$(eval $(call FFT_PASS_RULE,loopreduce,loop-reduce))
$(eval $(call FFT_PASS_RULE,unroll,loop-unroll))
$(eval $(call FFT_PASS_RULE,unswitch,simple-loop-unswitch))
$(eval $(call FFT_PASS_RULE,sccp,sccp))

# -------------------------------------------------------------
# Forced Unroll x4
# -------------------------------------------------------------

fft_unroll4.bc: fft_O0.bc
	$(OPT) -passes=loop-unroll -unroll-count=4 $< -o $@

$(EXEC_DIR)/fft_unroll4_exec: fft_unroll4.bc | $(EXEC_DIR)
	$(CLANG) $< -o $@ -lm

# =============================================================
# ================= O1 / O2 / O3 ==============================
# =============================================================

$(EXEC_DIR)/fft_O1_exec: | $(EXEC_DIR)
	$(CLANG) -O1 $(ALL_SRC) -o $@ -lm

$(EXEC_DIR)/fft_O2_exec: | $(EXEC_DIR)
	$(CLANG) -O2 $(ALL_SRC) -o $@ -lm

$(EXEC_DIR)/fft_O3_exec: | $(EXEC_DIR)
	$(CLANG) -O3 $(ALL_SRC) -o $@ -lm

# =============================================================
# Meta Target
# =============================================================

.PHONY: all clean

all: \
$(EXEC_DIR)/fft_O0_exec \
$(EXEC_DIR)/fft_licm_exec \
$(EXEC_DIR)/fft_instcombine_exec \
$(EXEC_DIR)/fft_cse_exec \
$(EXEC_DIR)/fft_gvn_exec \
$(EXEC_DIR)/fft_ipsccp_exec \
$(EXEC_DIR)/fft_inline_exec \
$(EXEC_DIR)/fft_loopreduce_exec \
$(EXEC_DIR)/fft_unroll_exec \
$(EXEC_DIR)/fft_unroll4_exec \
$(EXEC_DIR)/fft_unswitch_exec \
$(EXEC_DIR)/fft_sccp_exec \
$(EXEC_DIR)/fft_O1_exec \
$(EXEC_DIR)/fft_O2_exec \
$(EXEC_DIR)/fft_O3_exec

clean:
	rm -rf *.bc
	rm -rf *.o
	rm -rf $(EXEC_DIR)