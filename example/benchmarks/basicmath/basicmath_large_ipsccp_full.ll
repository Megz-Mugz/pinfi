; ModuleID = 'basicmath_large_ipsccp_full.bc'
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
  %1 = alloca i32, align 4
  %2 = alloca double, align 8
  %3 = alloca double, align 8
  %4 = alloca double, align 8
  %5 = alloca double, align 8
  %6 = alloca [3 x double], align 16
  %7 = alloca double, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i64, align 8
  %11 = alloca %struct.int_sqrt, align 4
  %12 = alloca i64, align 8
  store i32 0, ptr %1, align 4
  store double 1.000000e+00, ptr %2, align 8
  store double -1.050000e+01, ptr %3, align 8
  store double 3.200000e+01, ptr %4, align 8
  store double -3.000000e+01, ptr %5, align 8
  store i64 1072497001, ptr %10, align 8
  store i64 0, ptr %12, align 8
  %13 = call i32 (ptr, ...) @printf(ptr noundef @.str)
  %14 = load double, ptr %2, align 8
  %15 = load double, ptr %3, align 8
  %16 = load double, ptr %4, align 8
  %17 = load double, ptr %5, align 8
  %18 = getelementptr inbounds nuw [3 x double], ptr %6, i64 0, i64 0
  call void @SolveCubic(double noundef %14, double noundef %15, double noundef %16, double noundef %17, ptr noundef %8, ptr noundef %18)
  %19 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  store i32 0, ptr %9, align 4
  br label %20

20:                                               ; preds = %30, %0
  %21 = load i32, ptr %9, align 4
  %22 = load i32, ptr %8, align 4
  %23 = icmp slt i32 %21, %22
  br i1 %23, label %24, label %33

24:                                               ; preds = %20
  %25 = load i32, ptr %9, align 4
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds [3 x double], ptr %6, i64 0, i64 %26
  %28 = load double, ptr %27, align 8
  %29 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %28)
  br label %30

30:                                               ; preds = %24
  %31 = load i32, ptr %9, align 4
  %32 = add nsw i32 %31, 1
  store i32 %32, ptr %9, align 4
  br label %20, !llvm.loop !6

33:                                               ; preds = %20
  %34 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  store double 1.000000e+00, ptr %2, align 8
  store double -4.500000e+00, ptr %3, align 8
  store double 1.700000e+01, ptr %4, align 8
  store double -3.000000e+01, ptr %5, align 8
  %35 = load double, ptr %2, align 8
  %36 = load double, ptr %3, align 8
  %37 = load double, ptr %4, align 8
  %38 = load double, ptr %5, align 8
  %39 = getelementptr inbounds nuw [3 x double], ptr %6, i64 0, i64 0
  call void @SolveCubic(double noundef %35, double noundef %36, double noundef %37, double noundef %38, ptr noundef %8, ptr noundef %39)
  %40 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  store i32 0, ptr %9, align 4
  br label %41

41:                                               ; preds = %51, %33
  %42 = load i32, ptr %9, align 4
  %43 = load i32, ptr %8, align 4
  %44 = icmp slt i32 %42, %43
  br i1 %44, label %45, label %54

45:                                               ; preds = %41
  %46 = load i32, ptr %9, align 4
  %47 = sext i32 %46 to i64
  %48 = getelementptr inbounds [3 x double], ptr %6, i64 0, i64 %47
  %49 = load double, ptr %48, align 8
  %50 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %49)
  br label %51

51:                                               ; preds = %45
  %52 = load i32, ptr %9, align 4
  %53 = add nsw i32 %52, 1
  store i32 %53, ptr %9, align 4
  br label %41, !llvm.loop !8

54:                                               ; preds = %41
  %55 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  store double 1.000000e+00, ptr %2, align 8
  store double -3.500000e+00, ptr %3, align 8
  store double 2.200000e+01, ptr %4, align 8
  store double -3.100000e+01, ptr %5, align 8
  %56 = load double, ptr %2, align 8
  %57 = load double, ptr %3, align 8
  %58 = load double, ptr %4, align 8
  %59 = load double, ptr %5, align 8
  %60 = getelementptr inbounds nuw [3 x double], ptr %6, i64 0, i64 0
  call void @SolveCubic(double noundef %56, double noundef %57, double noundef %58, double noundef %59, ptr noundef %8, ptr noundef %60)
  %61 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  store i32 0, ptr %9, align 4
  br label %62

62:                                               ; preds = %72, %54
  %63 = load i32, ptr %9, align 4
  %64 = load i32, ptr %8, align 4
  %65 = icmp slt i32 %63, %64
  br i1 %65, label %66, label %75

66:                                               ; preds = %62
  %67 = load i32, ptr %9, align 4
  %68 = sext i32 %67 to i64
  %69 = getelementptr inbounds [3 x double], ptr %6, i64 0, i64 %68
  %70 = load double, ptr %69, align 8
  %71 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %70)
  br label %72

72:                                               ; preds = %66
  %73 = load i32, ptr %9, align 4
  %74 = add nsw i32 %73, 1
  store i32 %74, ptr %9, align 4
  br label %62, !llvm.loop !9

75:                                               ; preds = %62
  %76 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  store double 1.000000e+00, ptr %2, align 8
  store double -1.370000e+01, ptr %3, align 8
  store double 1.000000e+00, ptr %4, align 8
  store double -3.500000e+01, ptr %5, align 8
  %77 = load double, ptr %2, align 8
  %78 = load double, ptr %3, align 8
  %79 = load double, ptr %4, align 8
  %80 = load double, ptr %5, align 8
  %81 = getelementptr inbounds nuw [3 x double], ptr %6, i64 0, i64 0
  call void @SolveCubic(double noundef %77, double noundef %78, double noundef %79, double noundef %80, ptr noundef %8, ptr noundef %81)
  %82 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  store i32 0, ptr %9, align 4
  br label %83

83:                                               ; preds = %93, %75
  %84 = load i32, ptr %9, align 4
  %85 = load i32, ptr %8, align 4
  %86 = icmp slt i32 %84, %85
  br i1 %86, label %87, label %96

87:                                               ; preds = %83
  %88 = load i32, ptr %9, align 4
  %89 = sext i32 %88 to i64
  %90 = getelementptr inbounds [3 x double], ptr %6, i64 0, i64 %89
  %91 = load double, ptr %90, align 8
  %92 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %91)
  br label %93

93:                                               ; preds = %87
  %94 = load i32, ptr %9, align 4
  %95 = add nsw i32 %94, 1
  store i32 %95, ptr %9, align 4
  br label %83, !llvm.loop !10

96:                                               ; preds = %83
  %97 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  store double 3.000000e+00, ptr %2, align 8
  store double 1.234000e+01, ptr %3, align 8
  store double 5.000000e+00, ptr %4, align 8
  store double 1.200000e+01, ptr %5, align 8
  %98 = load double, ptr %2, align 8
  %99 = load double, ptr %3, align 8
  %100 = load double, ptr %4, align 8
  %101 = load double, ptr %5, align 8
  %102 = getelementptr inbounds nuw [3 x double], ptr %6, i64 0, i64 0
  call void @SolveCubic(double noundef %98, double noundef %99, double noundef %100, double noundef %101, ptr noundef %8, ptr noundef %102)
  %103 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  store i32 0, ptr %9, align 4
  br label %104

104:                                              ; preds = %114, %96
  %105 = load i32, ptr %9, align 4
  %106 = load i32, ptr %8, align 4
  %107 = icmp slt i32 %105, %106
  br i1 %107, label %108, label %117

108:                                              ; preds = %104
  %109 = load i32, ptr %9, align 4
  %110 = sext i32 %109 to i64
  %111 = getelementptr inbounds [3 x double], ptr %6, i64 0, i64 %110
  %112 = load double, ptr %111, align 8
  %113 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %112)
  br label %114

114:                                              ; preds = %108
  %115 = load i32, ptr %9, align 4
  %116 = add nsw i32 %115, 1
  store i32 %116, ptr %9, align 4
  br label %104, !llvm.loop !11

117:                                              ; preds = %104
  %118 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  store double -8.000000e+00, ptr %2, align 8
  store double -6.789000e+01, ptr %3, align 8
  store double 6.000000e+00, ptr %4, align 8
  store double -2.360000e+01, ptr %5, align 8
  %119 = load double, ptr %2, align 8
  %120 = load double, ptr %3, align 8
  %121 = load double, ptr %4, align 8
  %122 = load double, ptr %5, align 8
  %123 = getelementptr inbounds nuw [3 x double], ptr %6, i64 0, i64 0
  call void @SolveCubic(double noundef %119, double noundef %120, double noundef %121, double noundef %122, ptr noundef %8, ptr noundef %123)
  %124 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  store i32 0, ptr %9, align 4
  br label %125

125:                                              ; preds = %135, %117
  %126 = load i32, ptr %9, align 4
  %127 = load i32, ptr %8, align 4
  %128 = icmp slt i32 %126, %127
  br i1 %128, label %129, label %138

129:                                              ; preds = %125
  %130 = load i32, ptr %9, align 4
  %131 = sext i32 %130 to i64
  %132 = getelementptr inbounds [3 x double], ptr %6, i64 0, i64 %131
  %133 = load double, ptr %132, align 8
  %134 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %133)
  br label %135

135:                                              ; preds = %129
  %136 = load i32, ptr %9, align 4
  %137 = add nsw i32 %136, 1
  store i32 %137, ptr %9, align 4
  br label %125, !llvm.loop !12

138:                                              ; preds = %125
  %139 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  store double 4.500000e+01, ptr %2, align 8
  store double 8.670000e+00, ptr %3, align 8
  store double 7.500000e+00, ptr %4, align 8
  store double 3.400000e+01, ptr %5, align 8
  %140 = load double, ptr %2, align 8
  %141 = load double, ptr %3, align 8
  %142 = load double, ptr %4, align 8
  %143 = load double, ptr %5, align 8
  %144 = getelementptr inbounds nuw [3 x double], ptr %6, i64 0, i64 0
  call void @SolveCubic(double noundef %140, double noundef %141, double noundef %142, double noundef %143, ptr noundef %8, ptr noundef %144)
  %145 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  store i32 0, ptr %9, align 4
  br label %146

146:                                              ; preds = %156, %138
  %147 = load i32, ptr %9, align 4
  %148 = load i32, ptr %8, align 4
  %149 = icmp slt i32 %147, %148
  br i1 %149, label %150, label %159

150:                                              ; preds = %146
  %151 = load i32, ptr %9, align 4
  %152 = sext i32 %151 to i64
  %153 = getelementptr inbounds [3 x double], ptr %6, i64 0, i64 %152
  %154 = load double, ptr %153, align 8
  %155 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %154)
  br label %156

156:                                              ; preds = %150
  %157 = load i32, ptr %9, align 4
  %158 = add nsw i32 %157, 1
  store i32 %158, ptr %9, align 4
  br label %146, !llvm.loop !13

159:                                              ; preds = %146
  %160 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  store double -1.200000e+01, ptr %2, align 8
  store double -1.700000e+00, ptr %3, align 8
  store double 5.300000e+00, ptr %4, align 8
  store double 1.600000e+01, ptr %5, align 8
  %161 = load double, ptr %2, align 8
  %162 = load double, ptr %3, align 8
  %163 = load double, ptr %4, align 8
  %164 = load double, ptr %5, align 8
  %165 = getelementptr inbounds nuw [3 x double], ptr %6, i64 0, i64 0
  call void @SolveCubic(double noundef %161, double noundef %162, double noundef %163, double noundef %164, ptr noundef %8, ptr noundef %165)
  %166 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  store i32 0, ptr %9, align 4
  br label %167

167:                                              ; preds = %177, %159
  %168 = load i32, ptr %9, align 4
  %169 = load i32, ptr %8, align 4
  %170 = icmp slt i32 %168, %169
  br i1 %170, label %171, label %180

171:                                              ; preds = %167
  %172 = load i32, ptr %9, align 4
  %173 = sext i32 %172 to i64
  %174 = getelementptr inbounds [3 x double], ptr %6, i64 0, i64 %173
  %175 = load double, ptr %174, align 8
  %176 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %175)
  br label %177

177:                                              ; preds = %171
  %178 = load i32, ptr %9, align 4
  %179 = add nsw i32 %178, 1
  store i32 %179, ptr %9, align 4
  br label %167, !llvm.loop !14

180:                                              ; preds = %167
  %181 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  store double 1.000000e+00, ptr %2, align 8
  br label %182

182:                                              ; preds = %231, %180
  %183 = load double, ptr %2, align 8
  %184 = fcmp olt double %183, 1.000000e+01
  br i1 %184, label %185, label %234

185:                                              ; preds = %182
  store double 1.000000e+01, ptr %3, align 8
  br label %186

186:                                              ; preds = %227, %185
  %187 = load double, ptr %3, align 8
  %188 = fcmp ogt double %187, 0.000000e+00
  br i1 %188, label %189, label %230

189:                                              ; preds = %186
  store double 5.000000e+00, ptr %4, align 8
  br label %190

190:                                              ; preds = %223, %189
  %191 = load double, ptr %4, align 8
  %192 = fcmp olt double %191, 1.500000e+01
  br i1 %192, label %193, label %226

193:                                              ; preds = %190
  store double -1.000000e+00, ptr %5, align 8
  br label %194

194:                                              ; preds = %219, %193
  %195 = load double, ptr %5, align 8
  %196 = fcmp ogt double %195, -5.000000e+00
  br i1 %196, label %197, label %222

197:                                              ; preds = %194
  %198 = load double, ptr %2, align 8
  %199 = load double, ptr %3, align 8
  %200 = load double, ptr %4, align 8
  %201 = load double, ptr %5, align 8
  %202 = getelementptr inbounds nuw [3 x double], ptr %6, i64 0, i64 0
  call void @SolveCubic(double noundef %198, double noundef %199, double noundef %200, double noundef %201, ptr noundef %8, ptr noundef %202)
  %203 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  store i32 0, ptr %9, align 4
  br label %204

204:                                              ; preds = %214, %197
  %205 = load i32, ptr %9, align 4
  %206 = load i32, ptr %8, align 4
  %207 = icmp slt i32 %205, %206
  br i1 %207, label %208, label %217

208:                                              ; preds = %204
  %209 = load i32, ptr %9, align 4
  %210 = sext i32 %209 to i64
  %211 = getelementptr inbounds [3 x double], ptr %6, i64 0, i64 %210
  %212 = load double, ptr %211, align 8
  %213 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %212)
  br label %214

214:                                              ; preds = %208
  %215 = load i32, ptr %9, align 4
  %216 = add nsw i32 %215, 1
  store i32 %216, ptr %9, align 4
  br label %204, !llvm.loop !15

217:                                              ; preds = %204
  %218 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  br label %219

219:                                              ; preds = %217
  %220 = load double, ptr %5, align 8
  %221 = fsub double %220, 4.510000e-01
  store double %221, ptr %5, align 8
  br label %194, !llvm.loop !16

222:                                              ; preds = %194
  br label %223

223:                                              ; preds = %222
  %224 = load double, ptr %4, align 8
  %225 = fadd double %224, 6.100000e-01
  store double %225, ptr %4, align 8
  br label %190, !llvm.loop !17

226:                                              ; preds = %190
  br label %227

227:                                              ; preds = %226
  %228 = load double, ptr %3, align 8
  %229 = fsub double %228, 2.500000e-01
  store double %229, ptr %3, align 8
  br label %186, !llvm.loop !18

230:                                              ; preds = %186
  br label %231

231:                                              ; preds = %230
  %232 = load double, ptr %2, align 8
  %233 = fadd double %232, 1.000000e+00
  store double %233, ptr %2, align 8
  br label %182, !llvm.loop !19

234:                                              ; preds = %182
  %235 = call i32 (ptr, ...) @printf(ptr noundef @.str.4)
  store i32 0, ptr %9, align 4
  br label %236

236:                                              ; preds = %246, %234
  %237 = load i32, ptr %9, align 4
  %238 = icmp slt i32 %237, 100000
  br i1 %238, label %239, label %249

239:                                              ; preds = %236
  %240 = load i32, ptr %9, align 4
  %241 = sext i32 %240 to i64
  call void @usqrt(i64 noundef %241, ptr noundef %11)
  %242 = load i32, ptr %9, align 4
  %243 = getelementptr inbounds nuw %struct.int_sqrt, ptr %11, i32 0, i32 0
  %244 = load i32, ptr %243, align 4
  %245 = call i32 (ptr, ...) @printf(ptr noundef @.str.5, i32 noundef %242, i32 noundef %244)
  br label %246

246:                                              ; preds = %239
  %247 = load i32, ptr %9, align 4
  %248 = add nsw i32 %247, 2
  store i32 %248, ptr %9, align 4
  br label %236, !llvm.loop !20

249:                                              ; preds = %236
  %250 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  store i64 1072497001, ptr %10, align 8
  br label %251

251:                                              ; preds = %260, %249
  %252 = load i64, ptr %10, align 8
  %253 = icmp ult i64 %252, 1072513385
  br i1 %253, label %254, label %263

254:                                              ; preds = %251
  %255 = load i64, ptr %10, align 8
  call void @usqrt(i64 noundef %255, ptr noundef %11)
  %256 = load i64, ptr %10, align 8
  %257 = getelementptr inbounds nuw %struct.int_sqrt, ptr %11, i32 0, i32 0
  %258 = load i32, ptr %257, align 4
  %259 = call i32 (ptr, ...) @printf(ptr noundef @.str.6, i64 noundef %256, i32 noundef %258)
  br label %260

260:                                              ; preds = %254
  %261 = load i64, ptr %10, align 8
  %262 = add i64 %261, 1
  store i64 %262, ptr %10, align 8
  br label %251, !llvm.loop !21

263:                                              ; preds = %251
  %264 = call i32 (ptr, ...) @printf(ptr noundef @.str.7)
  store double 0.000000e+00, ptr %7, align 8
  br label %265

265:                                              ; preds = %275, %263
  %266 = load double, ptr %7, align 8
  %267 = fcmp ole double %266, 3.600000e+02
  br i1 %267, label %268, label %278

268:                                              ; preds = %265
  %269 = load double, ptr %7, align 8
  %270 = load double, ptr %7, align 8
  %271 = call double @atan(double noundef 1.000000e+00) #6
  %272 = fmul double %270, 0x400921FB54442D18
  %273 = fdiv double %272, 1.800000e+02
  %274 = call i32 (ptr, ...) @printf(ptr noundef @.str.8, double noundef %269, double noundef %273)
  br label %275

275:                                              ; preds = %268
  %276 = load double, ptr %7, align 8
  %277 = fadd double %276, 1.000000e-03
  store double %277, ptr %7, align 8
  br label %265, !llvm.loop !22

278:                                              ; preds = %265
  %279 = call i32 @puts(ptr noundef @.str.9)
  store double 0.000000e+00, ptr %7, align 8
  br label %280

280:                                              ; preds = %291, %278
  %281 = load double, ptr %7, align 8
  %282 = call double @atan(double noundef 1.000000e+00) #6
  %283 = fcmp ole double %281, 0x401921FB97600B9B
  br i1 %283, label %284, label %295

284:                                              ; preds = %280
  %285 = load double, ptr %7, align 8
  %286 = load double, ptr %7, align 8
  %287 = fmul double %286, 1.800000e+02
  %288 = call double @atan(double noundef 1.000000e+00) #6
  %289 = fdiv double %287, 0x400921FB54442D18
  %290 = call i32 (ptr, ...) @printf(ptr noundef @.str.10, double noundef %285, double noundef %289)
  br label %291

291:                                              ; preds = %284
  %292 = call double @atan(double noundef 1.000000e+00) #6
  %293 = load double, ptr %7, align 8
  %294 = fadd double %293, 0x3F41DF46A2529D39
  store double %294, ptr %7, align 8
  br label %280, !llvm.loop !23

295:                                              ; preds = %280
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
