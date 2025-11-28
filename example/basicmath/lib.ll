; ModuleID = 'lib.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local double @rad2deg(double noundef %0) #0 {
  %2 = alloca double, align 8
  store double %0, ptr %2, align 8
  %3 = load double, ptr %2, align 8
  %4 = fmul double 1.800000e+02, %3
  %5 = call double @atan(double noundef 1.000000e+00) #4
  %6 = fmul double 4.000000e+00, %5
  %7 = fdiv double %4, %6
  ret double %7
}

; Function Attrs: nounwind
declare double @atan(double noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local double @deg2rad(double noundef %0) #0 {
  %2 = alloca double, align 8
  store double %0, ptr %2, align 8
  %3 = call double @atan(double noundef 1.000000e+00) #4
  %4 = fmul double 4.000000e+00, %3
  %5 = load double, ptr %2, align 8
  %6 = fmul double %4, %5
  %7 = fdiv double %6, 1.800000e+02
  ret double %7
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @SolveCubic(double noundef %0, double noundef %1, double noundef %2, double noundef %3, ptr noundef %4, ptr noundef %5) #0 {
  %7 = alloca double, align 8
  %8 = alloca double, align 8
  %9 = alloca double, align 8
  %10 = alloca double, align 8
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca x86_fp80, align 16
  %14 = alloca x86_fp80, align 16
  %15 = alloca x86_fp80, align 16
  %16 = alloca x86_fp80, align 16
  %17 = alloca x86_fp80, align 16
  %18 = alloca double, align 8
  %19 = alloca double, align 8
  store double %0, ptr %7, align 8
  store double %1, ptr %8, align 8
  store double %2, ptr %9, align 8
  store double %3, ptr %10, align 8
  store ptr %4, ptr %11, align 8
  store ptr %5, ptr %12, align 8
  %20 = load double, ptr %8, align 8
  %21 = load double, ptr %7, align 8
  %22 = fdiv double %20, %21
  %23 = fpext double %22 to x86_fp80
  store x86_fp80 %23, ptr %13, align 16
  %24 = load double, ptr %9, align 8
  %25 = load double, ptr %7, align 8
  %26 = fdiv double %24, %25
  %27 = fpext double %26 to x86_fp80
  store x86_fp80 %27, ptr %14, align 16
  %28 = load double, ptr %10, align 8
  %29 = load double, ptr %7, align 8
  %30 = fdiv double %28, %29
  %31 = fpext double %30 to x86_fp80
  store x86_fp80 %31, ptr %15, align 16
  %32 = load x86_fp80, ptr %13, align 16
  %33 = load x86_fp80, ptr %13, align 16
  %34 = load x86_fp80, ptr %14, align 16
  %35 = fmul x86_fp80 0xK4000C000000000000000, %34
  %36 = fneg x86_fp80 %35
  %37 = call x86_fp80 @llvm.fmuladd.f80(x86_fp80 %32, x86_fp80 %33, x86_fp80 %36)
  %38 = fdiv x86_fp80 %37, 0xK40029000000000000000
  store x86_fp80 %38, ptr %16, align 16
  %39 = load x86_fp80, ptr %13, align 16
  %40 = fmul x86_fp80 0xK40008000000000000000, %39
  %41 = load x86_fp80, ptr %13, align 16
  %42 = fmul x86_fp80 %40, %41
  %43 = load x86_fp80, ptr %13, align 16
  %44 = load x86_fp80, ptr %13, align 16
  %45 = fmul x86_fp80 0xK40029000000000000000, %44
  %46 = load x86_fp80, ptr %14, align 16
  %47 = fmul x86_fp80 %45, %46
  %48 = fneg x86_fp80 %47
  %49 = call x86_fp80 @llvm.fmuladd.f80(x86_fp80 %42, x86_fp80 %43, x86_fp80 %48)
  %50 = load x86_fp80, ptr %15, align 16
  %51 = call x86_fp80 @llvm.fmuladd.f80(x86_fp80 0xK4003D800000000000000, x86_fp80 %50, x86_fp80 %49)
  %52 = fdiv x86_fp80 %51, 0xK4004D800000000000000
  store x86_fp80 %52, ptr %17, align 16
  %53 = load x86_fp80, ptr %17, align 16
  %54 = load x86_fp80, ptr %17, align 16
  %55 = load x86_fp80, ptr %16, align 16
  %56 = load x86_fp80, ptr %16, align 16
  %57 = fmul x86_fp80 %55, %56
  %58 = load x86_fp80, ptr %16, align 16
  %59 = fmul x86_fp80 %57, %58
  %60 = fneg x86_fp80 %59
  %61 = call x86_fp80 @llvm.fmuladd.f80(x86_fp80 %53, x86_fp80 %54, x86_fp80 %60)
  %62 = fptrunc x86_fp80 %61 to double
  store double %62, ptr %18, align 8
  %63 = load double, ptr %18, align 8
  %64 = fcmp ole double %63, 0.000000e+00
  br i1 %64, label %65, label %130

65:                                               ; preds = %6
  %66 = load ptr, ptr %11, align 8
  store i32 3, ptr %66, align 4
  %67 = load x86_fp80, ptr %17, align 16
  %68 = load x86_fp80, ptr %16, align 16
  %69 = load x86_fp80, ptr %16, align 16
  %70 = fmul x86_fp80 %68, %69
  %71 = load x86_fp80, ptr %16, align 16
  %72 = fmul x86_fp80 %70, %71
  %73 = fptrunc x86_fp80 %72 to double
  %74 = call double @sqrt(double noundef %73) #4
  %75 = fpext double %74 to x86_fp80
  %76 = fdiv x86_fp80 %67, %75
  %77 = fptrunc x86_fp80 %76 to double
  %78 = call double @acos(double noundef %77) #4
  store double %78, ptr %19, align 8
  %79 = load x86_fp80, ptr %16, align 16
  %80 = fptrunc x86_fp80 %79 to double
  %81 = call double @sqrt(double noundef %80) #4
  %82 = fmul double -2.000000e+00, %81
  %83 = load double, ptr %19, align 8
  %84 = fdiv double %83, 3.000000e+00
  %85 = call double @cos(double noundef %84) #4
  %86 = fmul double %82, %85
  %87 = fpext double %86 to x86_fp80
  %88 = load x86_fp80, ptr %13, align 16
  %89 = fdiv x86_fp80 %88, 0xK4000C000000000000000
  %90 = fsub x86_fp80 %87, %89
  %91 = fptrunc x86_fp80 %90 to double
  %92 = load ptr, ptr %12, align 8
  %93 = getelementptr inbounds double, ptr %92, i64 0
  store double %91, ptr %93, align 8
  %94 = load x86_fp80, ptr %16, align 16
  %95 = fptrunc x86_fp80 %94 to double
  %96 = call double @sqrt(double noundef %95) #4
  %97 = fmul double -2.000000e+00, %96
  %98 = load double, ptr %19, align 8
  %99 = call double @atan(double noundef 1.000000e+00) #4
  %100 = fmul double 4.000000e+00, %99
  %101 = call double @llvm.fmuladd.f64(double 2.000000e+00, double %100, double %98)
  %102 = fdiv double %101, 3.000000e+00
  %103 = call double @cos(double noundef %102) #4
  %104 = fmul double %97, %103
  %105 = fpext double %104 to x86_fp80
  %106 = load x86_fp80, ptr %13, align 16
  %107 = fdiv x86_fp80 %106, 0xK4000C000000000000000
  %108 = fsub x86_fp80 %105, %107
  %109 = fptrunc x86_fp80 %108 to double
  %110 = load ptr, ptr %12, align 8
  %111 = getelementptr inbounds double, ptr %110, i64 1
  store double %109, ptr %111, align 8
  %112 = load x86_fp80, ptr %16, align 16
  %113 = fptrunc x86_fp80 %112 to double
  %114 = call double @sqrt(double noundef %113) #4
  %115 = fmul double -2.000000e+00, %114
  %116 = load double, ptr %19, align 8
  %117 = call double @atan(double noundef 1.000000e+00) #4
  %118 = fmul double 4.000000e+00, %117
  %119 = call double @llvm.fmuladd.f64(double 4.000000e+00, double %118, double %116)
  %120 = fdiv double %119, 3.000000e+00
  %121 = call double @cos(double noundef %120) #4
  %122 = fmul double %115, %121
  %123 = fpext double %122 to x86_fp80
  %124 = load x86_fp80, ptr %13, align 16
  %125 = fdiv x86_fp80 %124, 0xK4000C000000000000000
  %126 = fsub x86_fp80 %123, %125
  %127 = fptrunc x86_fp80 %126 to double
  %128 = load ptr, ptr %12, align 8
  %129 = getelementptr inbounds double, ptr %128, i64 2
  store double %127, ptr %129, align 8
  br label %170

130:                                              ; preds = %6
  %131 = load ptr, ptr %11, align 8
  store i32 1, ptr %131, align 4
  %132 = load double, ptr %18, align 8
  %133 = call double @sqrt(double noundef %132) #4
  %134 = load x86_fp80, ptr %17, align 16
  %135 = fptrunc x86_fp80 %134 to double
  %136 = call double @llvm.fabs.f64(double %135)
  %137 = fadd double %133, %136
  %138 = call double @pow(double noundef %137, double noundef 0x3FD5555555555555) #4
  %139 = load ptr, ptr %12, align 8
  %140 = getelementptr inbounds double, ptr %139, i64 0
  store double %138, ptr %140, align 8
  %141 = load x86_fp80, ptr %16, align 16
  %142 = load ptr, ptr %12, align 8
  %143 = getelementptr inbounds double, ptr %142, i64 0
  %144 = load double, ptr %143, align 8
  %145 = fpext double %144 to x86_fp80
  %146 = fdiv x86_fp80 %141, %145
  %147 = load ptr, ptr %12, align 8
  %148 = getelementptr inbounds double, ptr %147, i64 0
  %149 = load double, ptr %148, align 8
  %150 = fpext double %149 to x86_fp80
  %151 = fadd x86_fp80 %150, %146
  %152 = fptrunc x86_fp80 %151 to double
  store double %152, ptr %148, align 8
  %153 = load x86_fp80, ptr %17, align 16
  %154 = fcmp olt x86_fp80 %153, 0xK00000000000000000000
  %155 = zext i1 %154 to i64
  %156 = select i1 %154, i32 1, i32 -1
  %157 = sitofp i32 %156 to double
  %158 = load ptr, ptr %12, align 8
  %159 = getelementptr inbounds double, ptr %158, i64 0
  %160 = load double, ptr %159, align 8
  %161 = fmul double %160, %157
  store double %161, ptr %159, align 8
  %162 = load x86_fp80, ptr %13, align 16
  %163 = fdiv x86_fp80 %162, 0xK4000C000000000000000
  %164 = load ptr, ptr %12, align 8
  %165 = getelementptr inbounds double, ptr %164, i64 0
  %166 = load double, ptr %165, align 8
  %167 = fpext double %166 to x86_fp80
  %168 = fsub x86_fp80 %167, %163
  %169 = fptrunc x86_fp80 %168 to double
  store double %169, ptr %165, align 8
  br label %170

170:                                              ; preds = %130, %65
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare x86_fp80 @llvm.fmuladd.f80(x86_fp80, x86_fp80, x86_fp80) #2

; Function Attrs: nounwind
declare double @sqrt(double noundef) #1

; Function Attrs: nounwind
declare double @acos(double noundef) #1

; Function Attrs: nounwind
declare double @cos(double noundef) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fabs.f64(double) #2

; Function Attrs: nounwind
declare double @pow(double noundef, double noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @usqrt(i64 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  %8 = alloca i32, align 4
  store i64 %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  store i64 0, ptr %5, align 8
  store i64 0, ptr %6, align 8
  store i64 0, ptr %7, align 8
  store i32 0, ptr %8, align 4
  br label %9

9:                                                ; preds = %36, %2
  %10 = load i32, ptr %8, align 4
  %11 = icmp slt i32 %10, 32
  br i1 %11, label %12, label %39

12:                                               ; preds = %9
  %13 = load i64, ptr %6, align 8
  %14 = shl i64 %13, 2
  %15 = load i64, ptr %3, align 8
  %16 = and i64 %15, 3221225472
  %17 = lshr i64 %16, 30
  %18 = add i64 %14, %17
  store i64 %18, ptr %6, align 8
  %19 = load i64, ptr %3, align 8
  %20 = shl i64 %19, 2
  store i64 %20, ptr %3, align 8
  %21 = load i64, ptr %5, align 8
  %22 = shl i64 %21, 1
  store i64 %22, ptr %5, align 8
  %23 = load i64, ptr %5, align 8
  %24 = shl i64 %23, 1
  %25 = add i64 %24, 1
  store i64 %25, ptr %7, align 8
  %26 = load i64, ptr %6, align 8
  %27 = load i64, ptr %7, align 8
  %28 = icmp uge i64 %26, %27
  br i1 %28, label %29, label %35

29:                                               ; preds = %12
  %30 = load i64, ptr %7, align 8
  %31 = load i64, ptr %6, align 8
  %32 = sub i64 %31, %30
  store i64 %32, ptr %6, align 8
  %33 = load i64, ptr %5, align 8
  %34 = add i64 %33, 1
  store i64 %34, ptr %5, align 8
  br label %35

35:                                               ; preds = %29, %12
  br label %36

36:                                               ; preds = %35
  %37 = load i32, ptr %8, align 4
  %38 = add nsw i32 %37, 1
  store i32 %38, ptr %8, align 4
  br label %9, !llvm.loop !6

39:                                               ; preds = %9
  %40 = load ptr, ptr %4, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %40, ptr align 8 %5, i64 8, i1 false)
  ret void
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias writeonly captures(none), ptr noalias readonly captures(none), i64, i1 immarg) #3

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #4 = { nounwind }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1, !2, !3, !4, !5}

!0 = !{!"clang version 22.0.0git (https://github.com/llvm/llvm-project.git b79f4eb6b79dde33d34488a38e571ee65010ac1f)"}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"PIE Level", i32 2}
!4 = !{i32 7, !"uwtable", i32 2}
!5 = !{i32 7, !"frame-pointer", i32 2}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
