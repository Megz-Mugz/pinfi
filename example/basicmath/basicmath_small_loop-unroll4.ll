; ModuleID = 'basicmath_small_O0.ll'
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

32:                                               ; preds = %71, %0
  %33 = load i32, ptr %21, align 4
  %34 = load i32, ptr %20, align 4
  %35 = icmp slt i32 %33, %34
  br i1 %35, label %36, label %73

36:                                               ; preds = %32
  %37 = sext i32 %33 to i64
  %38 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 %37
  %39 = load double, ptr %38, align 8
  %40 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %39)
  br label %41

41:                                               ; preds = %36
  %42 = add nsw i32 %33, 1
  store i32 %42, ptr %21, align 4
  %43 = load i32, ptr %21, align 4
  %44 = load i32, ptr %20, align 4
  %45 = icmp slt i32 %43, %44
  br i1 %45, label %46, label %73

46:                                               ; preds = %41
  %47 = sext i32 %43 to i64
  %48 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 %47
  %49 = load double, ptr %48, align 8
  %50 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %49)
  br label %51

51:                                               ; preds = %46
  %52 = add nsw i32 %43, 1
  store i32 %52, ptr %21, align 4
  %53 = load i32, ptr %21, align 4
  %54 = load i32, ptr %20, align 4
  %55 = icmp slt i32 %53, %54
  br i1 %55, label %56, label %73

56:                                               ; preds = %51
  %57 = sext i32 %53 to i64
  %58 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 %57
  %59 = load double, ptr %58, align 8
  %60 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %59)
  br label %61

61:                                               ; preds = %56
  %62 = add nsw i32 %53, 1
  store i32 %62, ptr %21, align 4
  %63 = load i32, ptr %21, align 4
  %64 = load i32, ptr %20, align 4
  %65 = icmp slt i32 %63, %64
  br i1 %65, label %66, label %73

66:                                               ; preds = %61
  %67 = sext i32 %63 to i64
  %68 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 %67
  %69 = load double, ptr %68, align 8
  %70 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %69)
  br label %71

71:                                               ; preds = %66
  %72 = add nsw i32 %63, 1
  store i32 %72, ptr %21, align 4
  br label %32, !llvm.loop !6

73:                                               ; preds = %61, %51, %41, %32
  %74 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  %75 = load double, ptr %6, align 8
  %76 = load double, ptr %7, align 8
  %77 = load double, ptr %8, align 8
  %78 = load double, ptr %9, align 8
  %79 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 0
  call void @SolveCubic(double noundef %75, double noundef %76, double noundef %77, double noundef %78, ptr noundef %20, ptr noundef %79)
  %80 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  store i32 0, ptr %21, align 4
  br label %81

81:                                               ; preds = %120, %73
  %82 = load i32, ptr %21, align 4
  %83 = load i32, ptr %20, align 4
  %84 = icmp slt i32 %82, %83
  br i1 %84, label %85, label %122

85:                                               ; preds = %81
  %86 = sext i32 %82 to i64
  %87 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 %86
  %88 = load double, ptr %87, align 8
  %89 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %88)
  br label %90

90:                                               ; preds = %85
  %91 = add nsw i32 %82, 1
  store i32 %91, ptr %21, align 4
  %92 = load i32, ptr %21, align 4
  %93 = load i32, ptr %20, align 4
  %94 = icmp slt i32 %92, %93
  br i1 %94, label %95, label %122

95:                                               ; preds = %90
  %96 = sext i32 %92 to i64
  %97 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 %96
  %98 = load double, ptr %97, align 8
  %99 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %98)
  br label %100

100:                                              ; preds = %95
  %101 = add nsw i32 %92, 1
  store i32 %101, ptr %21, align 4
  %102 = load i32, ptr %21, align 4
  %103 = load i32, ptr %20, align 4
  %104 = icmp slt i32 %102, %103
  br i1 %104, label %105, label %122

105:                                              ; preds = %100
  %106 = sext i32 %102 to i64
  %107 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 %106
  %108 = load double, ptr %107, align 8
  %109 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %108)
  br label %110

110:                                              ; preds = %105
  %111 = add nsw i32 %102, 1
  store i32 %111, ptr %21, align 4
  %112 = load i32, ptr %21, align 4
  %113 = load i32, ptr %20, align 4
  %114 = icmp slt i32 %112, %113
  br i1 %114, label %115, label %122

115:                                              ; preds = %110
  %116 = sext i32 %112 to i64
  %117 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 %116
  %118 = load double, ptr %117, align 8
  %119 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %118)
  br label %120

120:                                              ; preds = %115
  %121 = add nsw i32 %112, 1
  store i32 %121, ptr %21, align 4
  br label %81, !llvm.loop !9

122:                                              ; preds = %110, %100, %90, %81
  %123 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  %124 = load double, ptr %10, align 8
  %125 = load double, ptr %11, align 8
  %126 = load double, ptr %12, align 8
  %127 = load double, ptr %13, align 8
  %128 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 0
  call void @SolveCubic(double noundef %124, double noundef %125, double noundef %126, double noundef %127, ptr noundef %20, ptr noundef %128)
  %129 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  store i32 0, ptr %21, align 4
  br label %130

130:                                              ; preds = %169, %122
  %131 = load i32, ptr %21, align 4
  %132 = load i32, ptr %20, align 4
  %133 = icmp slt i32 %131, %132
  br i1 %133, label %134, label %171

134:                                              ; preds = %130
  %135 = sext i32 %131 to i64
  %136 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 %135
  %137 = load double, ptr %136, align 8
  %138 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %137)
  br label %139

139:                                              ; preds = %134
  %140 = add nsw i32 %131, 1
  store i32 %140, ptr %21, align 4
  %141 = load i32, ptr %21, align 4
  %142 = load i32, ptr %20, align 4
  %143 = icmp slt i32 %141, %142
  br i1 %143, label %144, label %171

144:                                              ; preds = %139
  %145 = sext i32 %141 to i64
  %146 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 %145
  %147 = load double, ptr %146, align 8
  %148 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %147)
  br label %149

149:                                              ; preds = %144
  %150 = add nsw i32 %141, 1
  store i32 %150, ptr %21, align 4
  %151 = load i32, ptr %21, align 4
  %152 = load i32, ptr %20, align 4
  %153 = icmp slt i32 %151, %152
  br i1 %153, label %154, label %171

154:                                              ; preds = %149
  %155 = sext i32 %151 to i64
  %156 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 %155
  %157 = load double, ptr %156, align 8
  %158 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %157)
  br label %159

159:                                              ; preds = %154
  %160 = add nsw i32 %151, 1
  store i32 %160, ptr %21, align 4
  %161 = load i32, ptr %21, align 4
  %162 = load i32, ptr %20, align 4
  %163 = icmp slt i32 %161, %162
  br i1 %163, label %164, label %171

164:                                              ; preds = %159
  %165 = sext i32 %161 to i64
  %166 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 %165
  %167 = load double, ptr %166, align 8
  %168 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %167)
  br label %169

169:                                              ; preds = %164
  %170 = add nsw i32 %161, 1
  store i32 %170, ptr %21, align 4
  br label %130, !llvm.loop !10

171:                                              ; preds = %159, %149, %139, %130
  %172 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  %173 = load double, ptr %14, align 8
  %174 = load double, ptr %15, align 8
  %175 = load double, ptr %16, align 8
  %176 = load double, ptr %17, align 8
  %177 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 0
  call void @SolveCubic(double noundef %173, double noundef %174, double noundef %175, double noundef %176, ptr noundef %20, ptr noundef %177)
  %178 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  store i32 0, ptr %21, align 4
  br label %179

179:                                              ; preds = %218, %171
  %180 = load i32, ptr %21, align 4
  %181 = load i32, ptr %20, align 4
  %182 = icmp slt i32 %180, %181
  br i1 %182, label %183, label %220

183:                                              ; preds = %179
  %184 = sext i32 %180 to i64
  %185 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 %184
  %186 = load double, ptr %185, align 8
  %187 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %186)
  br label %188

188:                                              ; preds = %183
  %189 = add nsw i32 %180, 1
  store i32 %189, ptr %21, align 4
  %190 = load i32, ptr %21, align 4
  %191 = load i32, ptr %20, align 4
  %192 = icmp slt i32 %190, %191
  br i1 %192, label %193, label %220

193:                                              ; preds = %188
  %194 = sext i32 %190 to i64
  %195 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 %194
  %196 = load double, ptr %195, align 8
  %197 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %196)
  br label %198

198:                                              ; preds = %193
  %199 = add nsw i32 %190, 1
  store i32 %199, ptr %21, align 4
  %200 = load i32, ptr %21, align 4
  %201 = load i32, ptr %20, align 4
  %202 = icmp slt i32 %200, %201
  br i1 %202, label %203, label %220

203:                                              ; preds = %198
  %204 = sext i32 %200 to i64
  %205 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 %204
  %206 = load double, ptr %205, align 8
  %207 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %206)
  br label %208

208:                                              ; preds = %203
  %209 = add nsw i32 %200, 1
  store i32 %209, ptr %21, align 4
  %210 = load i32, ptr %21, align 4
  %211 = load i32, ptr %20, align 4
  %212 = icmp slt i32 %210, %211
  br i1 %212, label %213, label %220

213:                                              ; preds = %208
  %214 = sext i32 %210 to i64
  %215 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 %214
  %216 = load double, ptr %215, align 8
  %217 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %216)
  br label %218

218:                                              ; preds = %213
  %219 = add nsw i32 %210, 1
  store i32 %219, ptr %21, align 4
  br label %179, !llvm.loop !11

220:                                              ; preds = %208, %198, %188, %179
  %221 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  store double 1.000000e+00, ptr %2, align 8
  br label %222

222:                                              ; preds = %299, %220
  %223 = load double, ptr %2, align 8
  %224 = fcmp olt double %223, 1.000000e+01
  br i1 %224, label %225, label %302

225:                                              ; preds = %222
  store double 1.000000e+01, ptr %3, align 8
  br label %226

226:                                              ; preds = %295, %225
  %227 = load double, ptr %3, align 8
  %228 = fcmp ogt double %227, 0.000000e+00
  br i1 %228, label %229, label %298

229:                                              ; preds = %226
  store double 5.000000e+00, ptr %4, align 8
  br label %230

230:                                              ; preds = %291, %229
  %231 = load double, ptr %4, align 8
  %232 = fcmp olt double %231, 1.500000e+01
  br i1 %232, label %233, label %294

233:                                              ; preds = %230
  store double -1.000000e+00, ptr %5, align 8
  br label %234

234:                                              ; preds = %287, %233
  %235 = load double, ptr %5, align 8
  %236 = fcmp ogt double %235, -1.100000e+01
  br i1 %236, label %237, label %290

237:                                              ; preds = %234
  %238 = load double, ptr %2, align 8
  %239 = load double, ptr %3, align 8
  %240 = load double, ptr %4, align 8
  %241 = load double, ptr %5, align 8
  %242 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 0
  call void @SolveCubic(double noundef %238, double noundef %239, double noundef %240, double noundef %241, ptr noundef %20, ptr noundef %242)
  %243 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  store i32 0, ptr %21, align 4
  br label %244

244:                                              ; preds = %283, %237
  %245 = load i32, ptr %21, align 4
  %246 = load i32, ptr %20, align 4
  %247 = icmp slt i32 %245, %246
  br i1 %247, label %248, label %285

248:                                              ; preds = %244
  %249 = sext i32 %245 to i64
  %250 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 %249
  %251 = load double, ptr %250, align 8
  %252 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %251)
  br label %253

253:                                              ; preds = %248
  %254 = add nsw i32 %245, 1
  store i32 %254, ptr %21, align 4
  %255 = load i32, ptr %21, align 4
  %256 = load i32, ptr %20, align 4
  %257 = icmp slt i32 %255, %256
  br i1 %257, label %258, label %285

258:                                              ; preds = %253
  %259 = sext i32 %255 to i64
  %260 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 %259
  %261 = load double, ptr %260, align 8
  %262 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %261)
  br label %263

263:                                              ; preds = %258
  %264 = add nsw i32 %255, 1
  store i32 %264, ptr %21, align 4
  %265 = load i32, ptr %21, align 4
  %266 = load i32, ptr %20, align 4
  %267 = icmp slt i32 %265, %266
  br i1 %267, label %268, label %285

268:                                              ; preds = %263
  %269 = sext i32 %265 to i64
  %270 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 %269
  %271 = load double, ptr %270, align 8
  %272 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %271)
  br label %273

273:                                              ; preds = %268
  %274 = add nsw i32 %265, 1
  store i32 %274, ptr %21, align 4
  %275 = load i32, ptr %21, align 4
  %276 = load i32, ptr %20, align 4
  %277 = icmp slt i32 %275, %276
  br i1 %277, label %278, label %285

278:                                              ; preds = %273
  %279 = sext i32 %275 to i64
  %280 = getelementptr inbounds [3 x double], ptr %18, i64 0, i64 %279
  %281 = load double, ptr %280, align 8
  %282 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, double noundef %281)
  br label %283

283:                                              ; preds = %278
  %284 = add nsw i32 %275, 1
  store i32 %284, ptr %21, align 4
  br label %244, !llvm.loop !12

285:                                              ; preds = %273, %263, %253, %244
  %286 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  br label %287

287:                                              ; preds = %285
  %288 = load double, ptr %5, align 8
  %289 = fadd double %288, -1.000000e+00
  store double %289, ptr %5, align 8
  br label %234, !llvm.loop !13

290:                                              ; preds = %234
  br label %291

291:                                              ; preds = %290
  %292 = load double, ptr %4, align 8
  %293 = fadd double %292, 5.000000e-01
  store double %293, ptr %4, align 8
  br label %230, !llvm.loop !14

294:                                              ; preds = %230
  br label %295

295:                                              ; preds = %294
  %296 = load double, ptr %3, align 8
  %297 = fadd double %296, -1.000000e+00
  store double %297, ptr %3, align 8
  br label %226, !llvm.loop !15

298:                                              ; preds = %226
  br label %299

299:                                              ; preds = %298
  %300 = load double, ptr %2, align 8
  %301 = fadd double %300, 1.000000e+00
  store double %301, ptr %2, align 8
  br label %222, !llvm.loop !16

302:                                              ; preds = %222
  %303 = call i32 (ptr, ...) @printf(ptr noundef @.str.4)
  store i32 0, ptr %21, align 4
  br label %304

304:                                              ; preds = %335, %302
  %305 = load i32, ptr %21, align 4
  %306 = icmp slt i32 %305, 1001
  br i1 %306, label %307, label %337

307:                                              ; preds = %304
  %308 = sext i32 %305 to i64
  call void @usqrt(i64 noundef %308, ptr noundef %23)
  %309 = load i32, ptr %23, align 4
  %310 = call i32 (ptr, ...) @printf(ptr noundef @.str.5, i32 noundef %305, i32 noundef %309)
  br label %311

311:                                              ; preds = %307
  %312 = add nsw i32 %305, 1
  store i32 %312, ptr %21, align 4
  %313 = load i32, ptr %21, align 4
  %314 = icmp slt i32 %313, 1001
  br i1 %314, label %315, label %337

315:                                              ; preds = %311
  %316 = sext i32 %313 to i64
  call void @usqrt(i64 noundef %316, ptr noundef %23)
  %317 = load i32, ptr %23, align 4
  %318 = call i32 (ptr, ...) @printf(ptr noundef @.str.5, i32 noundef %313, i32 noundef %317)
  br label %319

319:                                              ; preds = %315
  %320 = add nsw i32 %313, 1
  store i32 %320, ptr %21, align 4
  %321 = load i32, ptr %21, align 4
  %322 = icmp slt i32 %321, 1001
  br i1 %322, label %323, label %337

323:                                              ; preds = %319
  %324 = sext i32 %321 to i64
  call void @usqrt(i64 noundef %324, ptr noundef %23)
  %325 = load i32, ptr %23, align 4
  %326 = call i32 (ptr, ...) @printf(ptr noundef @.str.5, i32 noundef %321, i32 noundef %325)
  br label %327

327:                                              ; preds = %323
  %328 = add nsw i32 %321, 1
  store i32 %328, ptr %21, align 4
  %329 = load i32, ptr %21, align 4
  %330 = icmp slt i32 %329, 1001
  br i1 %330, label %331, label %337

331:                                              ; preds = %327
  %332 = sext i32 %329 to i64
  call void @usqrt(i64 noundef %332, ptr noundef %23)
  %333 = load i32, ptr %23, align 4
  %334 = call i32 (ptr, ...) @printf(ptr noundef @.str.5, i32 noundef %329, i32 noundef %333)
  br label %335

335:                                              ; preds = %331
  %336 = add nsw i32 %329, 1
  store i32 %336, ptr %21, align 4
  br label %304, !llvm.loop !17

337:                                              ; preds = %327, %319, %311, %304
  %338 = load i64, ptr %22, align 8
  call void @usqrt(i64 noundef %338, ptr noundef %23)
  %339 = load i64, ptr %22, align 8
  %340 = getelementptr inbounds nuw %struct.int_sqrt, ptr %23, i32 0, i32 0
  %341 = load i32, ptr %340, align 4
  %342 = call i32 (ptr, ...) @printf(ptr noundef @.str.6, i64 noundef %339, i32 noundef %341)
  %343 = call i32 (ptr, ...) @printf(ptr noundef @.str.7)
  store double 0.000000e+00, ptr %19, align 8
  br label %344

344:                                              ; preds = %383, %337
  %345 = load double, ptr %19, align 8
  %346 = fcmp ole double %345, 3.600000e+02
  br i1 %346, label %347, label %385

347:                                              ; preds = %344
  %348 = call double @atan(double noundef 1.000000e+00) #4
  %349 = fmul double 4.000000e+00, %348
  %350 = fmul double %345, %349
  %351 = fdiv double %350, 1.800000e+02
  %352 = call i32 (ptr, ...) @printf(ptr noundef @.str.8, double noundef %345, double noundef %351)
  br label %353

353:                                              ; preds = %347
  %354 = fadd double %345, 1.000000e+00
  store double %354, ptr %19, align 8
  %355 = load double, ptr %19, align 8
  %356 = fcmp ole double %355, 3.600000e+02
  br i1 %356, label %357, label %385

357:                                              ; preds = %353
  %358 = call double @atan(double noundef 1.000000e+00) #4
  %359 = fmul double 4.000000e+00, %358
  %360 = fmul double %355, %359
  %361 = fdiv double %360, 1.800000e+02
  %362 = call i32 (ptr, ...) @printf(ptr noundef @.str.8, double noundef %355, double noundef %361)
  br label %363

363:                                              ; preds = %357
  %364 = fadd double %355, 1.000000e+00
  store double %364, ptr %19, align 8
  %365 = load double, ptr %19, align 8
  %366 = fcmp ole double %365, 3.600000e+02
  br i1 %366, label %367, label %385

367:                                              ; preds = %363
  %368 = call double @atan(double noundef 1.000000e+00) #4
  %369 = fmul double 4.000000e+00, %368
  %370 = fmul double %365, %369
  %371 = fdiv double %370, 1.800000e+02
  %372 = call i32 (ptr, ...) @printf(ptr noundef @.str.8, double noundef %365, double noundef %371)
  br label %373

373:                                              ; preds = %367
  %374 = fadd double %365, 1.000000e+00
  store double %374, ptr %19, align 8
  %375 = load double, ptr %19, align 8
  %376 = fcmp ole double %375, 3.600000e+02
  br i1 %376, label %377, label %385

377:                                              ; preds = %373
  %378 = call double @atan(double noundef 1.000000e+00) #4
  %379 = fmul double 4.000000e+00, %378
  %380 = fmul double %375, %379
  %381 = fdiv double %380, 1.800000e+02
  %382 = call i32 (ptr, ...) @printf(ptr noundef @.str.8, double noundef %375, double noundef %381)
  br label %383

383:                                              ; preds = %377
  %384 = fadd double %375, 1.000000e+00
  store double %384, ptr %19, align 8
  br label %344, !llvm.loop !18

385:                                              ; preds = %373, %363, %353, %344
  %386 = call i32 @puts(ptr noundef @.str.9)
  store double 0.000000e+00, ptr %19, align 8
  br label %387

387:                                              ; preds = %447, %385
  %388 = load double, ptr %19, align 8
  %389 = call double @atan(double noundef 1.000000e+00) #4
  %390 = fmul double 4.000000e+00, %389
  %391 = call double @llvm.fmuladd.f64(double 2.000000e+00, double %390, double 0x3EB0C6F7A0B5ED8D)
  %392 = fcmp ole double %388, %391
  br i1 %392, label %393, label %452

393:                                              ; preds = %387
  %394 = fmul double %388, 1.800000e+02
  %395 = call double @atan(double noundef 1.000000e+00) #4
  %396 = fmul double 4.000000e+00, %395
  %397 = fdiv double %394, %396
  %398 = call i32 (ptr, ...) @printf(ptr noundef @.str.10, double noundef %388, double noundef %397)
  br label %399

399:                                              ; preds = %393
  %400 = call double @atan(double noundef 1.000000e+00) #4
  %401 = fmul double 4.000000e+00, %400
  %402 = fdiv double %401, 1.800000e+02
  %403 = fadd double %388, %402
  store double %403, ptr %19, align 8
  %404 = load double, ptr %19, align 8
  %405 = call double @atan(double noundef 1.000000e+00) #4
  %406 = fmul double 4.000000e+00, %405
  %407 = call double @llvm.fmuladd.f64(double 2.000000e+00, double %406, double 0x3EB0C6F7A0B5ED8D)
  %408 = fcmp ole double %404, %407
  br i1 %408, label %409, label %452

409:                                              ; preds = %399
  %410 = fmul double %404, 1.800000e+02
  %411 = call double @atan(double noundef 1.000000e+00) #4
  %412 = fmul double 4.000000e+00, %411
  %413 = fdiv double %410, %412
  %414 = call i32 (ptr, ...) @printf(ptr noundef @.str.10, double noundef %404, double noundef %413)
  br label %415

415:                                              ; preds = %409
  %416 = call double @atan(double noundef 1.000000e+00) #4
  %417 = fmul double 4.000000e+00, %416
  %418 = fdiv double %417, 1.800000e+02
  %419 = fadd double %404, %418
  store double %419, ptr %19, align 8
  %420 = load double, ptr %19, align 8
  %421 = call double @atan(double noundef 1.000000e+00) #4
  %422 = fmul double 4.000000e+00, %421
  %423 = call double @llvm.fmuladd.f64(double 2.000000e+00, double %422, double 0x3EB0C6F7A0B5ED8D)
  %424 = fcmp ole double %420, %423
  br i1 %424, label %425, label %452

425:                                              ; preds = %415
  %426 = fmul double %420, 1.800000e+02
  %427 = call double @atan(double noundef 1.000000e+00) #4
  %428 = fmul double 4.000000e+00, %427
  %429 = fdiv double %426, %428
  %430 = call i32 (ptr, ...) @printf(ptr noundef @.str.10, double noundef %420, double noundef %429)
  br label %431

431:                                              ; preds = %425
  %432 = call double @atan(double noundef 1.000000e+00) #4
  %433 = fmul double 4.000000e+00, %432
  %434 = fdiv double %433, 1.800000e+02
  %435 = fadd double %420, %434
  store double %435, ptr %19, align 8
  %436 = load double, ptr %19, align 8
  %437 = call double @atan(double noundef 1.000000e+00) #4
  %438 = fmul double 4.000000e+00, %437
  %439 = call double @llvm.fmuladd.f64(double 2.000000e+00, double %438, double 0x3EB0C6F7A0B5ED8D)
  %440 = fcmp ole double %436, %439
  br i1 %440, label %441, label %452

441:                                              ; preds = %431
  %442 = fmul double %436, 1.800000e+02
  %443 = call double @atan(double noundef 1.000000e+00) #4
  %444 = fmul double 4.000000e+00, %443
  %445 = fdiv double %442, %444
  %446 = call i32 (ptr, ...) @printf(ptr noundef @.str.10, double noundef %436, double noundef %445)
  br label %447

447:                                              ; preds = %441
  %448 = call double @atan(double noundef 1.000000e+00) #4
  %449 = fmul double 4.000000e+00, %448
  %450 = fdiv double %449, 1.800000e+02
  %451 = fadd double %436, %450
  store double %451, ptr %19, align 8
  br label %387, !llvm.loop !19

452:                                              ; preds = %431, %415, %399, %387
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
!6 = distinct !{!6, !7, !8}
!7 = !{!"llvm.loop.mustprogress"}
!8 = !{!"llvm.loop.unroll.disable"}
!9 = distinct !{!9, !7, !8}
!10 = distinct !{!10, !7, !8}
!11 = distinct !{!11, !7, !8}
!12 = distinct !{!12, !7, !8}
!13 = distinct !{!13, !7}
!14 = distinct !{!14, !7}
!15 = distinct !{!15, !7}
!16 = distinct !{!16, !7}
!17 = distinct !{!17, !7, !8}
!18 = distinct !{!18, !7, !8}
!19 = distinct !{!19, !7, !8}
