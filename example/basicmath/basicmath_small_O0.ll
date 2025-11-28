; ModuleID = 'basicmath_small.c'
source_filename = "basicmath_small.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.int_sqrt = type { i32, i32 }

@.str = private unnamed_addr constant [39 x i8] c"********* CUBIC FUNCTIONS ***********\0A\00", align 1
@.str.1 = private unnamed_addr constant [11 x i8] c"Solutions:\00", align 1
@.str.2 = private unnamed_addr constant [4 x i8] c" %f\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.4 = private unnamed_addr constant [41 x i8] c"********* INTEGER SQR ROOTS ***********\0A\00", align 1
@.str.5 = private unnamed_addr constant [17 x i8] c"sqrt(%3d) = %2d\0A\00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Asqrt(%lX) = %X\0A\00", align 1
@.str.7 = private unnamed_addr constant [40 x i8] c"********* ANGLE CONVERSION ***********\0A\00", align 1
@.str.8 = private unnamed_addr constant [31 x i8] c"%3.0f degrees = %.12f radians\0A\00", align 1
@.str.9 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@.str.10 = private unnamed_addr constant [31 x i8] c"%.12f radians = %3.0f degrees\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca double, align 8
  %3 = alloca double, align 8
  %4 = alloca double, align 8
  %5 = alloca double, align 8
  %6 = alloca double, align 8
  %7 = alloca double, align 8
  %8 = alloca double, align 8
  %9 = alloca double, align 8
  %10 = alloca double, align 8
  %11 = alloca double, align 8
  %12 = alloca double, align 8
  %13 = alloca double, align 8
  %14 = alloca double, align 8
  %15 = alloca double, align 8
  %16 = alloca double, align 8
  %17 = alloca double, align 8
  %18 = alloca [3 x double], align 16
  %19 = alloca double, align 8
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  %22 = alloca i64, align 8
  %23 = alloca %struct.int_sqrt, align 4
  %24 = alloca i64, align 8
  store i32 0, ptr %1, align 4
  store double 1.000000e+00, ptr %2, align 8
  store double -1.050000e+01, ptr %3, align 8
  store double 3.200000e+01, ptr %4, align 8
  store double -3.000000e+01, ptr %5, align 8
  store double 1.000000e+00, ptr %6, align 8
  store double -4.500000e+00, ptr %7, align 8
  store double 1.700000e+01, ptr %8, align 8
  store double -3.000000e+01, ptr %9, align 8
  store double 1.000000e+00, ptr %10, align 8
  store double -3.500000e+00, ptr %11, align 8
  store double 2.200000e+01, ptr %12, align 8
  store double -3.100000e+01, ptr %13, align 8
  store double 1.000000e+00, ptr %14, align 8
  store double -1.370000e+01, ptr %15, align 8
  store double 1.000000e+00, ptr %16, align 8
  store double -3.500000e+01, ptr %17, align 8
  store i64 1072497001, ptr %22, align 8
  store i64 0, ptr %24, align 8
  %25 = call i32 (ptr, ...) @printf(ptr noundef @.str)
  %26 = load double, ptr %2, align 8
  %27 = load double, ptr %3, align 8
  %28 = load double, ptr %4, align 8
  %29 = load double, ptr %5, align 8
  %30 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 0
  call void @SolveCubic(double noundef %26, double noundef %27, double noundef %28, double noundef %29, ptr noundef %20, ptr noundef %30)
  %31 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  store i32 0, ptr %21, align 4
  br label %32

32:                                               ; preds = %42, %0
  %33 = load i32, ptr %21, align 4
  %34 = load i32, ptr %20, align 4
  %35 = icmp slt i32 %33, %34
  br i1 %35, label %36, label %45

36:                                               ; preds = %32
  %37 = load i32, ptr %21, align 4
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 %38
  %40 = load double, ptr %39, align 8
  %41 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %40)
  br label %42

42:                                               ; preds = %36
  %43 = load i32, ptr %21, align 4
  %44 = add nsw i32 %43, 1
  store i32 %44, ptr %21, align 4
  br label %32, !llvm.loop !6

45:                                               ; preds = %32
  %46 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  %47 = load double, ptr %6, align 8
  %48 = load double, ptr %7, align 8
  %49 = load double, ptr %8, align 8
  %50 = load double, ptr %9, align 8
  %51 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 0
  call void @SolveCubic(double noundef %47, double noundef %48, double noundef %49, double noundef %50, ptr noundef %20, ptr noundef %51)
  %52 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  store i32 0, ptr %21, align 4
  br label %53

53:                                               ; preds = %63, %45
  %54 = load i32, ptr %21, align 4
  %55 = load i32, ptr %20, align 4
  %56 = icmp slt i32 %54, %55
  br i1 %56, label %57, label %66

57:                                               ; preds = %53
  %58 = load i32, ptr %21, align 4
  %59 = sext i32 %58 to i64
  %60 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 %59
  %61 = load double, ptr %60, align 8
  %62 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %61)
  br label %63

63:                                               ; preds = %57
  %64 = load i32, ptr %21, align 4
  %65 = add nsw i32 %64, 1
  store i32 %65, ptr %21, align 4
  br label %53, !llvm.loop !8

66:                                               ; preds = %53
  %67 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  %68 = load double, ptr %10, align 8
  %69 = load double, ptr %11, align 8
  %70 = load double, ptr %12, align 8
  %71 = load double, ptr %13, align 8
  %72 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 0
  call void @SolveCubic(double noundef %68, double noundef %69, double noundef %70, double noundef %71, ptr noundef %20, ptr noundef %72)
  %73 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  store i32 0, ptr %21, align 4
  br label %74

74:                                               ; preds = %84, %66
  %75 = load i32, ptr %21, align 4
  %76 = load i32, ptr %20, align 4
  %77 = icmp slt i32 %75, %76
  br i1 %77, label %78, label %87

78:                                               ; preds = %74
  %79 = load i32, ptr %21, align 4
  %80 = sext i32 %79 to i64
  %81 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 %80
  %82 = load double, ptr %81, align 8
  %83 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %82)
  br label %84

84:                                               ; preds = %78
  %85 = load i32, ptr %21, align 4
  %86 = add nsw i32 %85, 1
  store i32 %86, ptr %21, align 4
  br label %74, !llvm.loop !9

87:                                               ; preds = %74
  %88 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  %89 = load double, ptr %14, align 8
  %90 = load double, ptr %15, align 8
  %91 = load double, ptr %16, align 8
  %92 = load double, ptr %17, align 8
  %93 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 0
  call void @SolveCubic(double noundef %89, double noundef %90, double noundef %91, double noundef %92, ptr noundef %20, ptr noundef %93)
  %94 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  store i32 0, ptr %21, align 4
  br label %95

95:                                               ; preds = %105, %87
  %96 = load i32, ptr %21, align 4
  %97 = load i32, ptr %20, align 4
  %98 = icmp slt i32 %96, %97
  br i1 %98, label %99, label %108

99:                                               ; preds = %95
  %100 = load i32, ptr %21, align 4
  %101 = sext i32 %100 to i64
  %102 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 %101
  %103 = load double, ptr %102, align 8
  %104 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %103)
  br label %105

105:                                              ; preds = %99
  %106 = load i32, ptr %21, align 4
  %107 = add nsw i32 %106, 1
  store i32 %107, ptr %21, align 4
  br label %95, !llvm.loop !10

108:                                              ; preds = %95
  %109 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  store double 1.000000e+00, ptr %2, align 8
  br label %110

110:                                              ; preds = %159, %108
  %111 = load double, ptr %2, align 8
  %112 = fcmp olt double %111, 1.000000e+01
  br i1 %112, label %113, label %162

113:                                              ; preds = %110
  store double 1.000000e+01, ptr %3, align 8
  br label %114

114:                                              ; preds = %155, %113
  %115 = load double, ptr %3, align 8
  %116 = fcmp ogt double %115, 0.000000e+00
  br i1 %116, label %117, label %158

117:                                              ; preds = %114
  store double 5.000000e+00, ptr %4, align 8
  br label %118

118:                                              ; preds = %151, %117
  %119 = load double, ptr %4, align 8
  %120 = fcmp olt double %119, 1.500000e+01
  br i1 %120, label %121, label %154

121:                                              ; preds = %118
  store double -1.000000e+00, ptr %5, align 8
  br label %122

122:                                              ; preds = %147, %121
  %123 = load double, ptr %5, align 8
  %124 = fcmp ogt double %123, -1.100000e+01
  br i1 %124, label %125, label %150

125:                                              ; preds = %122
  %126 = load double, ptr %2, align 8
  %127 = load double, ptr %3, align 8
  %128 = load double, ptr %4, align 8
  %129 = load double, ptr %5, align 8
  %130 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 0
  call void @SolveCubic(double noundef %126, double noundef %127, double noundef %128, double noundef %129, ptr noundef %20, ptr noundef %130)
  %131 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  store i32 0, ptr %21, align 4
  br label %132

132:                                              ; preds = %142, %125
  %133 = load i32, ptr %21, align 4
  %134 = load i32, ptr %20, align 4
  %135 = icmp slt i32 %133, %134
  br i1 %135, label %136, label %145

136:                                              ; preds = %132
  %137 = load i32, ptr %21, align 4
  %138 = sext i32 %137 to i64
  %139 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 %138
  %140 = load double, ptr %139, align 8
  %141 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %140)
  br label %142

142:                                              ; preds = %136
  %143 = load i32, ptr %21, align 4
  %144 = add nsw i32 %143, 1
  store i32 %144, ptr %21, align 4
  br label %132, !llvm.loop !11

145:                                              ; preds = %132
  %146 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  br label %147

147:                                              ; preds = %145
  %148 = load double, ptr %5, align 8
  %149 = fadd double %148, -1.000000e+00
  store double %149, ptr %5, align 8
  br label %122, !llvm.loop !12

150:                                              ; preds = %122
  br label %151

151:                                              ; preds = %150
  %152 = load double, ptr %4, align 8
  %153 = fadd double %152, 5.000000e-01
  store double %153, ptr %4, align 8
  br label %118, !llvm.loop !13

154:                                              ; preds = %118
  br label %155

155:                                              ; preds = %154
  %156 = load double, ptr %3, align 8
  %157 = fadd double %156, -1.000000e+00
  store double %157, ptr %3, align 8
  br label %114, !llvm.loop !14

158:                                              ; preds = %114
  br label %159

159:                                              ; preds = %158
  %160 = load double, ptr %2, align 8
  %161 = fadd double %160, 1.000000e+00
  store double %161, ptr %2, align 8
  br label %110, !llvm.loop !15

162:                                              ; preds = %110
  %163 = call i32 (ptr, ...) @printf(ptr noundef @.str.4)
  store i32 0, ptr %21, align 4
  br label %164

164:                                              ; preds = %174, %162
  %165 = load i32, ptr %21, align 4
  %166 = icmp slt i32 %165, 1001
  br i1 %166, label %167, label %177

167:                                              ; preds = %164
  %168 = load i32, ptr %21, align 4
  %169 = sext i32 %168 to i64
  call void @usqrt(i64 noundef %169, ptr noundef %23)
  %170 = load i32, ptr %21, align 4
  %171 = getelementptr inbounds nuw %struct.int_sqrt, ptr %23, i32 0, i32 0
  %172 = load i32, ptr %171, align 4
  %173 = call i32 (ptr, ...) @printf(ptr noundef @.str.5, i32 noundef %170, i32 noundef %172)
  br label %174

174:                                              ; preds = %167
  %175 = load i32, ptr %21, align 4
  %176 = add nsw i32 %175, 1
  store i32 %176, ptr %21, align 4
  br label %164, !llvm.loop !16

177:                                              ; preds = %164
  %178 = load i64, ptr %22, align 8
  call void @usqrt(i64 noundef %178, ptr noundef %23)
  %179 = load i64, ptr %22, align 8
  %180 = getelementptr inbounds nuw %struct.int_sqrt, ptr %23, i32 0, i32 0
  %181 = load i32, ptr %180, align 4
  %182 = call i32 (ptr, ...) @printf(ptr noundef @.str.6, i64 noundef %179, i32 noundef %181)
  %183 = call i32 (ptr, ...) @printf(ptr noundef @.str.7)
  store double 0.000000e+00, ptr %19, align 8
  br label %184

184:                                              ; preds = %195, %177
  %185 = load double, ptr %19, align 8
  %186 = fcmp ole double %185, 3.600000e+02
  br i1 %186, label %187, label %198

187:                                              ; preds = %184
  %188 = load double, ptr %19, align 8
  %189 = load double, ptr %19, align 8
  %190 = call double @atan(double noundef 1.000000e+00) #4
  %191 = fmul double 4.000000e+00, %190
  %192 = fmul double %189, %191
  %193 = fdiv double %192, 1.800000e+02
  %194 = call i32 (ptr, ...) @printf(ptr noundef @.str.8, double noundef %188, double noundef %193)
  br label %195

195:                                              ; preds = %187
  %196 = load double, ptr %19, align 8
  %197 = fadd double %196, 1.000000e+00
  store double %197, ptr %19, align 8
  br label %184, !llvm.loop !17

198:                                              ; preds = %184
  %199 = call i32 @puts(ptr noundef @.str.9)
  store double 0.000000e+00, ptr %19, align 8
  br label %200

200:                                              ; preds = %214, %198
  %201 = load double, ptr %19, align 8
  %202 = call double @atan(double noundef 1.000000e+00) #4
  %203 = fmul double 4.000000e+00, %202
  %204 = call double @llvm.fmuladd.f64(double 2.000000e+00, double %203, double 0x3EB0C6F7A0B5ED8D)
  %205 = fcmp ole double %201, %204
  br i1 %205, label %206, label %220

206:                                              ; preds = %200
  %207 = load double, ptr %19, align 8
  %208 = load double, ptr %19, align 8
  %209 = fmul double %208, 1.800000e+02
  %210 = call double @atan(double noundef 1.000000e+00) #4
  %211 = fmul double 4.000000e+00, %210
  %212 = fdiv double %209, %211
  %213 = call i32 (ptr, ...) @printf(ptr noundef @.str.10, double noundef %207, double noundef %212)
  br label %214

214:                                              ; preds = %206
  %215 = call double @atan(double noundef 1.000000e+00) #4
  %216 = fmul double 4.000000e+00, %215
  %217 = fdiv double %216, 1.800000e+02
  %218 = load double, ptr %19, align 8
  %219 = fadd double %218, %217
  store double %219, ptr %19, align 8
  br label %200, !llvm.loop !18

220:                                              ; preds = %200
  ret i32 0
}

declare i32 @printf(ptr noundef, ...) #1

declare void @SolveCubic(double noundef, double noundef, double noundef, double noundef, ptr noundef, ptr noundef) #1

declare void @usqrt(i64 noundef, ptr noundef) #1

; Function Attrs: nounwind
declare double @atan(double noundef) #2

declare i32 @puts(ptr noundef) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #3

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 22.0.0git (https://github.com/llvm/llvm-project.git b79f4eb6b79dde33d34488a38e571ee65010ac1f)"}
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
