; ModuleID = 'basicmath_large_ipsccp_full_phi.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.int_sqrt = type { i32, i32 }

@.str = private unnamed_addr constant [39 x i8] c"********* CUBIC FUNCTIONS ***********\0A\00", align 1
@.str.1 = private unnamed_addr constant [11 x i8] c"Solutions:\00", align 1
@.str.2 = private unnamed_addr constant [4 x i8] c" %f\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.4 = private unnamed_addr constant [41 x i8] c"********* INTEGER SQR ROOTS ***********\0A\00", align 1
@.str.5 = private unnamed_addr constant [17 x i8] c"sqrt(%3d) = %2d\0A\00", align 1
@.str.6 = private unnamed_addr constant [16 x i8] c"sqrt(%lX) = %X\0A\00", align 1
@.str.7 = private unnamed_addr constant [40 x i8] c"********* ANGLE CONVERSION ***********\0A\00", align 1
@.str.8 = private unnamed_addr constant [31 x i8] c"%3.0f degrees = %.12f radians\0A\00", align 1
@.str.9 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@.str.10 = private unnamed_addr constant [31 x i8] c"%.12f radians = %3.0f degrees\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca [3 x double], align 16
  %2 = alloca i32, align 4
  %3 = alloca %struct.int_sqrt, align 4
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str)
  %5 = getelementptr inbounds nuw [3 x double], ptr %1, i64 0, i64 0
  call void @SolveCubic(double noundef 1.000000e+00, double noundef -1.050000e+01, double noundef 3.200000e+01, double noundef -3.000000e+01, ptr noundef %2, ptr noundef %5)
  %6 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  br label %7

7:                                                ; preds = %15, %0
  %.06 = phi i32 [ 0, %0 ], [ %16, %15 ]
  %8 = load i32, ptr %2, align 4
  %9 = icmp slt i32 %.06, %8
  br i1 %9, label %10, label %17

10:                                               ; preds = %7
  %11 = sext i32 %.06 to i64
  %12 = getelementptr inbounds [3 x double], ptr %1, i64 0, i64 %11
  %13 = load double, ptr %12, align 8
  %14 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %13)
  br label %15

15:                                               ; preds = %10
  %16 = add nsw i32 %.06, 1
  br label %7, !llvm.loop !6

17:                                               ; preds = %7
  %18 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  %19 = getelementptr inbounds nuw [3 x double], ptr %1, i64 0, i64 0
  call void @SolveCubic(double noundef 1.000000e+00, double noundef -4.500000e+00, double noundef 1.700000e+01, double noundef -3.000000e+01, ptr noundef %2, ptr noundef %19)
  %20 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  br label %21

21:                                               ; preds = %29, %17
  %.17 = phi i32 [ 0, %17 ], [ %30, %29 ]
  %22 = load i32, ptr %2, align 4
  %23 = icmp slt i32 %.17, %22
  br i1 %23, label %24, label %31

24:                                               ; preds = %21
  %25 = sext i32 %.17 to i64
  %26 = getelementptr inbounds [3 x double], ptr %1, i64 0, i64 %25
  %27 = load double, ptr %26, align 8
  %28 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %27)
  br label %29

29:                                               ; preds = %24
  %30 = add nsw i32 %.17, 1
  br label %21, !llvm.loop !8

31:                                               ; preds = %21
  %32 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  %33 = getelementptr inbounds nuw [3 x double], ptr %1, i64 0, i64 0
  call void @SolveCubic(double noundef 1.000000e+00, double noundef -3.500000e+00, double noundef 2.200000e+01, double noundef -3.100000e+01, ptr noundef %2, ptr noundef %33)
  %34 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  br label %35

35:                                               ; preds = %43, %31
  %.2 = phi i32 [ 0, %31 ], [ %44, %43 ]
  %36 = load i32, ptr %2, align 4
  %37 = icmp slt i32 %.2, %36
  br i1 %37, label %38, label %45

38:                                               ; preds = %35
  %39 = sext i32 %.2 to i64
  %40 = getelementptr inbounds [3 x double], ptr %1, i64 0, i64 %39
  %41 = load double, ptr %40, align 8
  %42 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %41)
  br label %43

43:                                               ; preds = %38
  %44 = add nsw i32 %.2, 1
  br label %35, !llvm.loop !9

45:                                               ; preds = %35
  %46 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  %47 = getelementptr inbounds nuw [3 x double], ptr %1, i64 0, i64 0
  call void @SolveCubic(double noundef 1.000000e+00, double noundef -1.370000e+01, double noundef 1.000000e+00, double noundef -3.500000e+01, ptr noundef %2, ptr noundef %47)
  %48 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  br label %49

49:                                               ; preds = %57, %45
  %.3 = phi i32 [ 0, %45 ], [ %58, %57 ]
  %50 = load i32, ptr %2, align 4
  %51 = icmp slt i32 %.3, %50
  br i1 %51, label %52, label %59

52:                                               ; preds = %49
  %53 = sext i32 %.3 to i64
  %54 = getelementptr inbounds [3 x double], ptr %1, i64 0, i64 %53
  %55 = load double, ptr %54, align 8
  %56 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %55)
  br label %57

57:                                               ; preds = %52
  %58 = add nsw i32 %.3, 1
  br label %49, !llvm.loop !10

59:                                               ; preds = %49
  %60 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  %61 = getelementptr inbounds nuw [3 x double], ptr %1, i64 0, i64 0
  call void @SolveCubic(double noundef 3.000000e+00, double noundef 1.234000e+01, double noundef 5.000000e+00, double noundef 1.200000e+01, ptr noundef %2, ptr noundef %61)
  %62 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  br label %63

63:                                               ; preds = %71, %59
  %.4 = phi i32 [ 0, %59 ], [ %72, %71 ]
  %64 = load i32, ptr %2, align 4
  %65 = icmp slt i32 %.4, %64
  br i1 %65, label %66, label %73

66:                                               ; preds = %63
  %67 = sext i32 %.4 to i64
  %68 = getelementptr inbounds [3 x double], ptr %1, i64 0, i64 %67
  %69 = load double, ptr %68, align 8
  %70 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %69)
  br label %71

71:                                               ; preds = %66
  %72 = add nsw i32 %.4, 1
  br label %63, !llvm.loop !11

73:                                               ; preds = %63
  %74 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  %75 = getelementptr inbounds nuw [3 x double], ptr %1, i64 0, i64 0
  call void @SolveCubic(double noundef -8.000000e+00, double noundef -6.789000e+01, double noundef 6.000000e+00, double noundef -2.360000e+01, ptr noundef %2, ptr noundef %75)
  %76 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  br label %77

77:                                               ; preds = %85, %73
  %.5 = phi i32 [ 0, %73 ], [ %86, %85 ]
  %78 = load i32, ptr %2, align 4
  %79 = icmp slt i32 %.5, %78
  br i1 %79, label %80, label %87

80:                                               ; preds = %77
  %81 = sext i32 %.5 to i64
  %82 = getelementptr inbounds [3 x double], ptr %1, i64 0, i64 %81
  %83 = load double, ptr %82, align 8
  %84 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %83)
  br label %85

85:                                               ; preds = %80
  %86 = add nsw i32 %.5, 1
  br label %77, !llvm.loop !12

87:                                               ; preds = %77
  %88 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  %89 = getelementptr inbounds nuw [3 x double], ptr %1, i64 0, i64 0
  call void @SolveCubic(double noundef 4.500000e+01, double noundef 8.670000e+00, double noundef 7.500000e+00, double noundef 3.400000e+01, ptr noundef %2, ptr noundef %89)
  %90 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  br label %91

91:                                               ; preds = %99, %87
  %.6 = phi i32 [ 0, %87 ], [ %100, %99 ]
  %92 = load i32, ptr %2, align 4
  %93 = icmp slt i32 %.6, %92
  br i1 %93, label %94, label %101

94:                                               ; preds = %91
  %95 = sext i32 %.6 to i64
  %96 = getelementptr inbounds [3 x double], ptr %1, i64 0, i64 %95
  %97 = load double, ptr %96, align 8
  %98 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %97)
  br label %99

99:                                               ; preds = %94
  %100 = add nsw i32 %.6, 1
  br label %91, !llvm.loop !13

101:                                              ; preds = %91
  %102 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  %103 = getelementptr inbounds nuw [3 x double], ptr %1, i64 0, i64 0
  call void @SolveCubic(double noundef -1.200000e+01, double noundef -1.700000e+00, double noundef 5.300000e+00, double noundef 1.600000e+01, ptr noundef %2, ptr noundef %103)
  %104 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  br label %105

105:                                              ; preds = %113, %101
  %.7 = phi i32 [ 0, %101 ], [ %114, %113 ]
  %106 = load i32, ptr %2, align 4
  %107 = icmp slt i32 %.7, %106
  br i1 %107, label %108, label %115

108:                                              ; preds = %105
  %109 = sext i32 %.7 to i64
  %110 = getelementptr inbounds [3 x double], ptr %1, i64 0, i64 %109
  %111 = load double, ptr %110, align 8
  %112 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %111)
  br label %113

113:                                              ; preds = %108
  %114 = add nsw i32 %.7, 1
  br label %105, !llvm.loop !14

115:                                              ; preds = %105
  %116 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  br label %117

117:                                              ; preds = %152, %115
  %.01 = phi double [ 1.000000e+00, %115 ], [ %153, %152 ]
  %118 = fcmp olt double %.01, 1.000000e+01
  br i1 %118, label %119, label %154

119:                                              ; preds = %117
  br label %120

120:                                              ; preds = %149, %119
  %.02 = phi double [ 1.000000e+01, %119 ], [ %150, %149 ]
  %121 = fcmp ogt double %.02, 0.000000e+00
  br i1 %121, label %122, label %151

122:                                              ; preds = %120
  br label %123

123:                                              ; preds = %146, %122
  %.03 = phi double [ 5.000000e+00, %122 ], [ %147, %146 ]
  %124 = fcmp olt double %.03, 1.500000e+01
  br i1 %124, label %125, label %148

125:                                              ; preds = %123
  br label %126

126:                                              ; preds = %143, %125
  %.04 = phi double [ -1.000000e+00, %125 ], [ %144, %143 ]
  %127 = fcmp ogt double %.04, -5.000000e+00
  br i1 %127, label %128, label %145

128:                                              ; preds = %126
  %129 = getelementptr inbounds nuw [3 x double], ptr %1, i64 0, i64 0
  call void @SolveCubic(double noundef %.01, double noundef %.02, double noundef %.03, double noundef %.04, ptr noundef %2, ptr noundef %129)
  %130 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  br label %131

131:                                              ; preds = %139, %128
  %.8 = phi i32 [ 0, %128 ], [ %140, %139 ]
  %132 = load i32, ptr %2, align 4
  %133 = icmp slt i32 %.8, %132
  br i1 %133, label %134, label %141

134:                                              ; preds = %131
  %135 = sext i32 %.8 to i64
  %136 = getelementptr inbounds [3 x double], ptr %1, i64 0, i64 %135
  %137 = load double, ptr %136, align 8
  %138 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %137)
  br label %139

139:                                              ; preds = %134
  %140 = add nsw i32 %.8, 1
  br label %131, !llvm.loop !15

141:                                              ; preds = %131
  %142 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  br label %143

143:                                              ; preds = %141
  %144 = fsub double %.04, 4.510000e-01
  br label %126, !llvm.loop !16

145:                                              ; preds = %126
  br label %146

146:                                              ; preds = %145
  %147 = fadd double %.03, 6.100000e-01
  br label %123, !llvm.loop !17

148:                                              ; preds = %123
  br label %149

149:                                              ; preds = %148
  %150 = fsub double %.02, 2.500000e-01
  br label %120, !llvm.loop !18

151:                                              ; preds = %120
  br label %152

152:                                              ; preds = %151
  %153 = fadd double %.01, 1.000000e+00
  br label %117, !llvm.loop !19

154:                                              ; preds = %117
  %155 = call i32 (ptr, ...) @printf(ptr noundef @.str.4)
  br label %156

156:                                              ; preds = %163, %154
  %.9 = phi i32 [ 0, %154 ], [ %164, %163 ]
  %157 = icmp slt i32 %.9, 100000
  br i1 %157, label %158, label %165

158:                                              ; preds = %156
  %159 = sext i32 %.9 to i64
  call void @usqrt(i64 noundef %159, ptr noundef %3)
  %160 = getelementptr inbounds nuw %struct.int_sqrt, ptr %3, i32 0, i32 0
  %161 = load i32, ptr %160, align 4
  %162 = call i32 (ptr, ...) @printf(ptr noundef @.str.5, i32 noundef %.9, i32 noundef %161)
  br label %163

163:                                              ; preds = %158
  %164 = add nsw i32 %.9, 2
  br label %156, !llvm.loop !20

165:                                              ; preds = %156
  %166 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  br label %167

167:                                              ; preds = %173, %165
  %.0 = phi i64 [ 1072497001, %165 ], [ %174, %173 ]
  %168 = icmp ult i64 %.0, 1072513385
  br i1 %168, label %169, label %175

169:                                              ; preds = %167
  call void @usqrt(i64 noundef %.0, ptr noundef %3)
  %170 = getelementptr inbounds nuw %struct.int_sqrt, ptr %3, i32 0, i32 0
  %171 = load i32, ptr %170, align 4
  %172 = call i32 (ptr, ...) @printf(ptr noundef @.str.6, i64 noundef %.0, i32 noundef %171)
  br label %173

173:                                              ; preds = %169
  %174 = add i64 %.0, 1
  br label %167, !llvm.loop !21

175:                                              ; preds = %167
  %176 = call i32 (ptr, ...) @printf(ptr noundef @.str.7)
  br label %177

177:                                              ; preds = %184, %175
  %.05 = phi double [ 0.000000e+00, %175 ], [ %185, %184 ]
  %178 = fcmp ole double %.05, 3.600000e+02
  br i1 %178, label %179, label %186

179:                                              ; preds = %177
  %180 = call double @atan(double noundef 1.000000e+00) #6
  %181 = fmul double %.05, 0x400921FB54442D18
  %182 = fdiv double %181, 1.800000e+02
  %183 = call i32 (ptr, ...) @printf(ptr noundef @.str.8, double noundef %.05, double noundef %182)
  br label %184

184:                                              ; preds = %179
  %185 = fadd double %.05, 1.000000e-03
  br label %177, !llvm.loop !22

186:                                              ; preds = %177
  %187 = call i32 @puts(ptr noundef @.str.9)
  br label %188

188:                                              ; preds = %196, %186
  %.1 = phi double [ 0.000000e+00, %186 ], [ %198, %196 ]
  %189 = call double @atan(double noundef 1.000000e+00) #6
  %190 = fcmp ole double %.1, 0x401921FB97600B9B
  br i1 %190, label %191, label %199

191:                                              ; preds = %188
  %192 = fmul double %.1, 1.800000e+02
  %193 = call double @atan(double noundef 1.000000e+00) #6
  %194 = fdiv double %192, 0x400921FB54442D18
  %195 = call i32 (ptr, ...) @printf(ptr noundef @.str.10, double noundef %.1, double noundef %194)
  br label %196

196:                                              ; preds = %191
  %197 = call double @atan(double noundef 1.000000e+00) #6
  %198 = fadd double %.1, 0x3F41DF46A2529D39
  br label %188, !llvm.loop !23

199:                                              ; preds = %188
  ret i32 0
}

declare i32 @printf(ptr noundef, ...) #1

; Function Attrs: nounwind
declare double @atan(double noundef) #2

declare i32 @puts(ptr noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local double @rad2deg(double noundef %0) #3 {
  %2 = alloca double, align 8
  store double %0, ptr %2, align 8
  %3 = load double, ptr %2, align 8
  %4 = fmul double 1.800000e+02, %3
  %5 = call double @atan(double noundef 1.000000e+00) #6
  %6 = fmul double 4.000000e+00, %5
  %7 = fdiv double %4, %6
  ret double %7
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local double @deg2rad(double noundef %0) #3 {
  %2 = alloca double, align 8
  store double %0, ptr %2, align 8
  %3 = call double @atan(double noundef 1.000000e+00) #6
  %4 = fmul double 4.000000e+00, %3
  %5 = load double, ptr %2, align 8
  %6 = fmul double %4, %5
  %7 = fdiv double %6, 1.800000e+02
  ret double %7
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @SolveCubic(double noundef %0, double noundef %1, double noundef %2, double noundef %3, ptr noundef %4, ptr noundef %5) #3 {
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
  %74 = call double @sqrt(double noundef %73) #6
  %75 = fpext double %74 to x86_fp80
  %76 = fdiv x86_fp80 %67, %75
  %77 = fptrunc x86_fp80 %76 to double
  %78 = call double @acos(double noundef %77) #6
  store double %78, ptr %19, align 8
  %79 = load x86_fp80, ptr %16, align 16
  %80 = fptrunc x86_fp80 %79 to double
  %81 = call double @sqrt(double noundef %80) #6
  %82 = fmul double -2.000000e+00, %81
  %83 = load double, ptr %19, align 8
  %84 = fdiv double %83, 3.000000e+00
  %85 = call double @cos(double noundef %84) #6
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
  %96 = call double @sqrt(double noundef %95) #6
  %97 = fmul double -2.000000e+00, %96
  %98 = load double, ptr %19, align 8
  %99 = call double @atan(double noundef 1.000000e+00) #6
  %100 = fmul double 4.000000e+00, %99
  %101 = call double @llvm.fmuladd.f64(double 2.000000e+00, double %100, double %98)
  %102 = fdiv double %101, 3.000000e+00
  %103 = call double @cos(double noundef %102) #6
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
  %114 = call double @sqrt(double noundef %113) #6
  %115 = fmul double -2.000000e+00, %114
  %116 = load double, ptr %19, align 8
  %117 = call double @atan(double noundef 1.000000e+00) #6
  %118 = fmul double 4.000000e+00, %117
  %119 = call double @llvm.fmuladd.f64(double 4.000000e+00, double %118, double %116)
  %120 = fdiv double %119, 3.000000e+00
  %121 = call double @cos(double noundef %120) #6
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
  %133 = call double @sqrt(double noundef %132) #6
  %134 = load x86_fp80, ptr %17, align 16
  %135 = fptrunc x86_fp80 %134 to double
  %136 = call double @llvm.fabs.f64(double %135)
  %137 = fadd double %133, %136
  %138 = call double @pow(double noundef %137, double noundef 0x3FD5555555555555) #6
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
declare x86_fp80 @llvm.fmuladd.f80(x86_fp80, x86_fp80, x86_fp80) #4

; Function Attrs: nounwind
declare double @sqrt(double noundef) #2

; Function Attrs: nounwind
declare double @acos(double noundef) #2

; Function Attrs: nounwind
declare double @cos(double noundef) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #4

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fabs.f64(double) #4

; Function Attrs: nounwind
declare double @pow(double noundef, double noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @usqrt(i64 noundef %0, ptr noundef %1) #3 {
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
  br label %9, !llvm.loop !24

39:                                               ; preds = %9
  %40 = load ptr, ptr %4, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %40, ptr align 8 %5, i64 8, i1 false)
  ret void
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias writeonly captures(none), ptr noalias readonly captures(none), i64, i1 immarg) #5

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #5 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #6 = { nounwind }

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
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
!11 = distinct !{!11, !7}
!12 = distinct !{!12, !7}
!13 = distinct !{!13, !7}
!14 = distinct !{!14, !7}
!15 = distinct !{!15, !7}
!16 = distinct !{!16, !7}
!17 = distinct !{!17, !7}
!18 = distinct !{!18, !7}
!19 = distinct !{!19, !7}
!20 = distinct !{!20, !7}
!21 = distinct !{!21, !7}
!22 = distinct !{!22, !7}
!23 = distinct !{!23, !7}
!24 = distinct !{!24, !7}
