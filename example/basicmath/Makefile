# =============================================================
# MiBench BasicMath LLVM Workflow (basicmath_small only)
# =============================================================

# -----------------------------
# Source files
# -----------------------------
LIB_SRCS      = rad2deg.c cubic.c isqrt.c
SMALL_DRIVER  = basicmath_small.c

FILE1 = $(SMALL_DRIVER) $(LIB_SRCS)

LIB_BCS   = $(LIB_SRCS:.c=.bc)

# =============================================================
# Default target
# =============================================================
all: basicmath_small

# -----------------------------
# Native executable (no LLVM)
# -----------------------------
basicmath_small: $(FILE1)
	gcc $(FILE1) -o $@ -lm

# =============================================================
# LLVM Bitcode and IR generation
# =============================================================
%.bc: %.c
	clang -emit-llvm -c $< -o $@

%.ll: %.bc
	llvm-dis $< -o $@

# =============================================================
# Library Bitcode
# =============================================================
lib.bc: $(LIB_BCS)
	llvm-link $(LIB_BCS) -o lib.bc
	llvm-dis lib.bc -o lib.ll

# =============================================================
# Ground truth (O0)
# =============================================================
basicmath_small_O0.ll: basicmath_small.c
	clang -S -emit-llvm -O0 -Xclang -disable-O0-optnone basicmath_small.c -o basicmath_small_O0.ll
	clang -emit-llvm -c -O0 -Xclang -disable-O0-optnone basicmath_small.c -o basicmath_small_O0.bc

# =============================================================
# Default loop unroll
# =============================================================
basicmath_small_loop-unroll.ll: basicmath_small_O0.ll
	opt -S -passes=loop-unroll basicmath_small_O0.ll -o basicmath_small_loop-unroll.ll
	opt -passes=loop-unroll basicmath_small_O0.bc -o basicmath_small_loop-unroll.bc

# =============================================================
# Forced unroll 4×
# =============================================================
basicmath_small_loop-unroll4.ll: basicmath_small_O0.ll
	opt -S -passes=loop-unroll -unroll-count=4 basicmath_small_O0.ll -o basicmath_small_loop-unroll4.ll
	opt -passes=loop-unroll -unroll-count=4 basicmath_small_O0.bc -o basicmath_small_loop-unroll4.bc

# =============================================================
# IR Diffs
# =============================================================
diffs: basicmath_small_O0.ll basicmath_small_loop-unroll.ll basicmath_small_loop-unroll4.ll
	@echo "=== Generating LLVM diffs ==="
	diff -u basicmath_small_O0.ll basicmath_small_loop-unroll.ll > diff_O0_vs_loop-unroll.txt || true
	diff -u basicmath_small_O0.ll basicmath_small_loop-unroll4.ll > diff_O0_vs_loop-unroll4.txt || true
	diff -u basicmath_small_loop-unroll.ll basicmath_small_loop-unroll4.ll > diff_loop-unroll_vs_loop-unroll4.txt || true
	@echo "Diffs written to:"
	@echo "  → diff_O0_vs_loop-unroll.txt"
	@echo "  → diff_O0_vs_loop-unroll4.txt"
	@echo "  → diff_loop-unroll_vs_loop-unroll4.txt"

# =============================================================
# Link executable bitcode (full program)
# =============================================================
basicmath_small_O0_full.bc: basicmath_small_O0.bc lib.bc
	llvm-link $^ -o $@

basicmath_small_loop-unroll_full.bc: basicmath_small_loop-unroll.bc lib.bc
	llvm-link $^ -o $@

basicmath_small_loop-unroll4_full.bc: basicmath_small_loop-unroll4.bc lib.bc
	llvm-link $^ -o $@

# =============================================================
# Executables from optimized bitcode
# =============================================================
basicmath_small_O0_exec: basicmath_small_O0_full.bc
	clang $< -o $@ -lm

basicmath_small_loop-unroll_exec: basicmath_small_loop-unroll_full.bc
	clang $< -o $@ -lm

basicmath_small_loop-unroll4_exec: basicmath_small_loop-unroll4_full.bc
	clang $< -o $@ -lm

# =============================================================
# Master: all IR + diffs
# =============================================================
opt: lib.bc basicmath_small_O0.ll basicmath_small_loop-unroll.ll basicmath_small_loop-unroll4.ll diffs
	@echo "All LLVM IRs and diffs generated."

# =============================================================
# Master: all executables
# =============================================================
exec: basicmath_small_O0_exec basicmath_small_loop-unroll_exec basicmath_small_loop-unroll4_exec
	@echo "Built executables:"
	@echo "  → basicmath_small_O0_exec"
	@echo "  → basicmath_small_loop-unroll_exec"
	@echo "  → basicmath_small_loop-unroll4_exec"

# =============================================================
# Cleanup
# =============================================================
clean:
	rm -rf basicmath_small \
	       *.bc *.ll *.o *.s *.txt \
	       *_exec *_full.bc lib.bc lib.ll