# =============================================================
# MiBench BasicMath – Pass-Isolated LLVM Study
# =============================================================

# -----------------------------
# Sources
# -----------------------------
LIB_SRCS = rad2deg.c cubic.c isqrt.c
DRIVER   = basicmath_large.c

# -----------------------------
# Tools
# -----------------------------
CLANG = clang
OPT   = opt
LLDIS = llvm-dis
LLINK = llvm-link

# -----------------------------
# Static linking (PARTIAL: libc dynamic)
# -----------------------------
STATIC_LDFLAGS = -static-libgcc -static-libstdc++

# =============================================================
# Base O0 bitcode (NO optimizations)
# =============================================================
basicmath_O0.bc:
	$(CLANG) -emit-llvm -c -O0 -Xclang -disable-O0-optnone $(DRIVER) -o $@

basicmath_O0.ll: basicmath_O0.bc
	$(LLDIS) $< -o $@

# =============================================================
# Library bitcode
# =============================================================
%.bc: %.c
	$(CLANG) -emit-llvm -c $< -o $@

lib.bc: rad2deg.bc cubic.bc isqrt.bc
	$(LLINK) $^ -o $@

# =============================================================
# Unoptimized O0 executable (DYNAMIC + STATIC)
# =============================================================
basicmath_O0_full.bc: basicmath_O0.bc lib.bc
	$(LLINK) $^ -o $@

basicmath_O0_exec: basicmath_O0_full.bc
	$(CLANG) $< -o $@ -lm

basicmath_O0_exec_static: basicmath_O0_full.bc
	$(CLANG) $(STATIC_LDFLAGS) $< -o $@ -lm

# =============================================================
# Generic IR (.ll) generation
# =============================================================
%.ll: %.bc
	$(LLDIS) $< -o $@

# =============================================================
# ---------------- INDIVIDUAL PASSES (DYNAMIC) ----------------
# Each target = O0 → EXACTLY ONE pass → exec
# =============================================================

# 1. LICM
basicmath_licm.bc: basicmath_O0.bc
	$(OPT) -passes=licm $< -o $@

basicmath_licm_full.bc: basicmath_licm.bc lib.bc
	$(LLINK) $^ -o $@

basicmath_licm_exec: basicmath_licm_full.bc
	$(CLANG) $< -o $@ -lm

# 2. InstCombine
basicmath_instcombine.bc: basicmath_O0.bc
	$(OPT) -passes=instcombine $< -o $@

basicmath_instcombine_full.bc: basicmath_instcombine.bc lib.bc
	$(LLINK) $^ -o $@

basicmath_instcombine_exec: basicmath_instcombine_full.bc
	$(CLANG) $< -o $@ -lm

# 3. CSE
basicmath_cse.bc: basicmath_O0.bc
	$(OPT) -passes=early-cse $< -o $@

basicmath_cse_full.bc: basicmath_cse.bc lib.bc
	$(LLINK) $^ -o $@

basicmath_cse_exec: basicmath_cse_full.bc
	$(CLANG) $< -o $@ -lm

# 4. GVN
basicmath_gvn.bc: basicmath_O0.bc
	$(OPT) -passes=gvn $< -o $@

basicmath_gvn_full.bc: basicmath_gvn.bc lib.bc
	$(LLINK) $^ -o $@

basicmath_gvn_exec: basicmath_gvn_full.bc
	$(CLANG) $< -o $@ -lm

# 5. IPSCCP
basicmath_ipsccp.bc: basicmath_O0.bc
	$(OPT) -passes=ipsccp $< -o $@

basicmath_ipsccp_full.bc: basicmath_ipsccp.bc lib.bc
	$(LLINK) $^ -o $@

basicmath_ipsccp_exec: basicmath_ipsccp_full.bc
	$(CLANG) $< -o $@ -lm

# 6. Inline
basicmath_inline.bc: basicmath_O0.bc
	$(OPT) -passes=inline $< -o $@

basicmath_inline_full.bc: basicmath_inline.bc lib.bc
	$(LLINK) $^ -o $@

basicmath_inline_exec: basicmath_inline_full.bc
	$(CLANG) $< -o $@ -lm

# 7. Loop Reduce
basicmath_loopreduce.bc: basicmath_O0.bc
	$(OPT) -passes=loop-reduce $< -o $@

basicmath_loopreduce_full.bc: basicmath_loopreduce.bc lib.bc
	$(LLINK) $^ -o $@

basicmath_loopreduce_exec: basicmath_loopreduce_full.bc
	$(CLANG) $< -o $@ -lm

# 8. Loop Unroll
basicmath_unroll.bc: basicmath_O0.bc
	$(OPT) -passes=loop-unroll $< -o $@

basicmath_unroll_full.bc: basicmath_unroll.bc lib.bc
	$(LLINK) $^ -o $@

basicmath_unroll_exec: basicmath_unroll_full.bc
	$(CLANG) $< -o $@ -lm

# 8b. Loop Unroll (forced 4x)
basicmath_unroll4.bc: basicmath_O0.bc
	$(OPT) -passes=loop-unroll -unroll-count=4 $< -o $@

basicmath_unroll4_full.bc: basicmath_unroll4.bc lib.bc
	$(LLINK) $^ -o $@

basicmath_unroll4_exec: basicmath_unroll4_full.bc
	$(CLANG) $< -o $@ -lm

# 9. Loop Unswitch
basicmath_unswitch.bc: basicmath_O0.bc
	$(OPT) -passes=simple-loop-unswitch $< -o $@

basicmath_unswitch_full.bc: basicmath_unswitch.bc lib.bc
	$(LLINK) $^ -o $@

basicmath_unswitch_exec: basicmath_unswitch_full.bc
	$(CLANG) $< -o $@ -lm

# 10. SCCP
basicmath_sccp.bc: basicmath_O0.bc
	$(OPT) -passes=sccp $< -o $@

basicmath_sccp_full.bc: basicmath_sccp.bc lib.bc
	$(LLINK) $^ -o $@

basicmath_sccp_exec: basicmath_sccp_full.bc
	$(CLANG) $< -o $@ -lm

# =============================================================
# ---------------- STANDARD -O LEVELS (DYNAMIC) ----------------
# =============================================================
basicmath_O1_exec:
	$(CLANG) -O1 $(DRIVER) $(LIB_SRCS) -o $@ -lm

basicmath_O2_exec:
	$(CLANG) -O2 $(DRIVER) $(LIB_SRCS) -o $@ -lm

basicmath_O3_exec:
	$(CLANG) -O3 $(DRIVER) $(LIB_SRCS) -o $@ -lm

# =============================================================
# ---------------- STATIC EXECUTABLES ----------------
# =============================================================
basicmath_licm_exec_static: basicmath_licm_full.bc
	$(CLANG) $(STATIC_LDFLAGS) $< -o $@ -lm

basicmath_instcombine_exec_static: basicmath_instcombine_full.bc
	$(CLANG) $(STATIC_LDFLAGS) $< -o $@ -lm

basicmath_cse_exec_static: basicmath_cse_full.bc
	$(CLANG) $(STATIC_LDFLAGS) $< -o $@ -lm

basicmath_gvn_exec_static: basicmath_gvn_full.bc
	$(CLANG) $(STATIC_LDFLAGS) $< -o $@ -lm

basicmath_ipsccp_exec_static: basicmath_ipsccp_full.bc
	$(CLANG) $(STATIC_LDFLAGS) $< -o $@ -lm

basicmath_inline_exec_static: basicmath_inline_full.bc
	$(CLANG) $(STATIC_LDFLAGS) $< -o $@ -lm

basicmath_loopreduce_exec_static: basicmath_loopreduce_full.bc
	$(CLANG) $(STATIC_LDFLAGS) $< -o $@ -lm

basicmath_unroll_exec_static: basicmath_unroll_full.bc
	$(CLANG) $(STATIC_LDFLAGS) $< -o $@ -lm

basicmath_unroll4_exec_static: basicmath_unroll4_full.bc
	$(CLANG) $(STATIC_LDFLAGS) $< -o $@ -lm

basicmath_unswitch_exec_static: basicmath_unswitch_full.bc
	$(CLANG) $(STATIC_LDFLAGS) $< -o $@ -lm

basicmath_sccp_exec_static: basicmath_sccp_full.bc
	$(CLANG) $(STATIC_LDFLAGS) $< -o $@ -lm

basicmath_O1_exec_static:
	$(CLANG) -O1 $(STATIC_LDFLAGS) $(DRIVER) $(LIB_SRCS) -o $@ -lm

basicmath_O2_exec_static:
	$(CLANG) -O2 $(STATIC_LDFLAGS) $(DRIVER) $(LIB_SRCS) -o $@ -lm

basicmath_O3_exec_static:
	$(CLANG) -O3 $(STATIC_LDFLAGS) $(DRIVER) $(LIB_SRCS) -o $@ -lm

# =============================================================
# IR Diffs
# =============================================================
.PHONY: diffs
diffs:
	diff -u basicmath_O0.ll basicmath_licm.ll        > diff_O0_vs_licm.txt        || true
	diff -u basicmath_O0.ll basicmath_instcombine.ll > diff_O0_vs_instcombine.txt || true
	diff -u basicmath_O0.ll basicmath_cse.ll         > diff_O0_vs_cse.txt         || true
	diff -u basicmath_O0.ll basicmath_gvn.ll         > diff_O0_vs_gvn.txt         || true
	diff -u basicmath_O0.ll basicmath_ipsccp.ll      > diff_O0_vs_ipsccp.txt      || true
	diff -u basicmath_O0.ll basicmath_inline.ll      > diff_O0_vs_inline.txt      || true
	diff -u basicmath_O0.ll basicmath_loopreduce.ll  > diff_O0_vs_loopreduce.txt  || true
	diff -u basicmath_O0.ll basicmath_unroll.ll      > diff_O0_vs_unroll.txt      || true
	diff -u basicmath_O0.ll basicmath_unroll4.ll     > diff_O0_vs_unroll4.txt     || true
	diff -u basicmath_O0.ll basicmath_unswitch.ll    > diff_O0_vs_unswitch.txt    || true
	diff -u basicmath_O0.ll basicmath_sccp.ll        > diff_O0_vs_sccp.txt        || true
	@echo "LLVM IR diffs generated."

# =============================================================
# Meta targets
# =============================================================
.PHONY: exec static all clean

exec: \
	basicmath_O0_exec \
	basicmath_licm_exec \
	basicmath_instcombine_exec \
	basicmath_cse_exec \
	basicmath_gvn_exec \
	basicmath_ipsccp_exec \
	basicmath_inline_exec \
	basicmath_loopreduce_exec \
	basicmath_unroll_exec \
	basicmath_unroll4_exec \
	basicmath_unswitch_exec \
	basicmath_sccp_exec \
	basicmath_O1_exec \
	basicmath_O2_exec \
	basicmath_O3_exec

static: \
	basicmath_O0_exec_static \
	basicmath_licm_exec_static \
	basicmath_instcombine_exec_static \
	basicmath_cse_exec_static \
	basicmath_gvn_exec_static \
	basicmath_ipsccp_exec_static \
	basicmath_inline_exec_static \
	basicmath_loopreduce_exec_static \
	basicmath_unroll_exec_static \
	basicmath_unroll4_exec_static \
	basicmath_unswitch_exec_static \
	basicmath_sccp_exec_static \
	basicmath_O1_exec_static \
	basicmath_O2_exec_static \
	basicmath_O3_exec_static

all: exec static diffs

clean:
	rm -f *.bc *.ll *_full.bc *_exec *_exec_static diff_*.txt