; ModuleID = 'output_code_iter_1.bc'
source_filename = "program.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [21 x i8] c"CAT variables = %ld\0A\00", align 1
@.str.1 = private unnamed_addr constant [16 x i8] c"CAT cost = %ld\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local void @a_generic_C_function(i8* noundef %0, i32 noundef %1) local_unnamed_addr #0 {
  %3 = icmp slt i32 %1, 100
  br i1 %3, label %.loopexit, label %.preheader

.loopexit:                                        ; preds = %14, %2
  ret void

.preheader:                                       ; preds = %2, %14
  %4 = phi i32 [ %16, %14 ], [ %1, %2 ]
  %5 = phi i8* [ %19, %14 ], [ %0, %2 ]
  %6 = call i64 @CAT_get(i8* noundef %5) #3
  %7 = icmp sgt i64 %6, 10
  br i1 %7, label %8, label %12

8:                                                ; preds = %.preheader
  %9 = call i64 @CAT_get(i8* noundef %5) #3
  %10 = add nsw i64 %9, -1
  %11 = call i8* @CAT_new(i64 noundef %10) #3
  br label %14

12:                                               ; preds = %.preheader
  %13 = add nsw i32 %4, -1
  br label %14

14:                                               ; preds = %8, %12
  %15 = phi i8* [ %11, %8 ], [ %5, %12 ]
  %16 = phi i32 [ %4, %8 ], [ %13, %12 ]
  %17 = call i64 @CAT_get(i8* noundef %15) #3
  %18 = add nsw i64 %17, -1
  %19 = call i8* @CAT_new(i64 noundef %18) #3
  %20 = icmp slt i32 %16, 100
  br i1 %20, label %.loopexit, label %.preheader
}

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_get(i8* noundef) local_unnamed_addr #1

; Function Attrs: argmemonly nounwind
declare dso_local i8* @CAT_new(i64 noundef) local_unnamed_addr #1

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 noundef %0, i8** nocapture noundef readnone %1) local_unnamed_addr #0 {
  %3 = call i8* @CAT_new(i64 noundef 5) #3
  %4 = icmp slt i32 %0, 100
  br i1 %4, label %.loopexit, label %.preheader

.preheader:                                       ; preds = %2, %15
  %5 = phi i32 [ %17, %15 ], [ %0, %2 ]
  %6 = phi i8* [ %20, %15 ], [ %3, %2 ]
  %7 = call i64 @CAT_get(i8* noundef %6) #3
  %8 = icmp sgt i64 %7, 10
  br i1 %8, label %9, label %13

9:                                                ; preds = %.preheader
  %10 = call i64 @CAT_get(i8* noundef %6) #3
  %11 = add nsw i64 %10, -1
  %12 = call i8* @CAT_new(i64 noundef %11) #3
  br label %15

13:                                               ; preds = %.preheader
  %14 = add nsw i32 %5, -1
  br label %15

15:                                               ; preds = %13, %9
  %16 = phi i8* [ %12, %9 ], [ %6, %13 ]
  %17 = phi i32 [ %5, %9 ], [ %14, %13 ]
  %18 = call i64 @CAT_get(i8* noundef %16) #3
  %19 = add nsw i64 %18, -1
  %20 = call i8* @CAT_new(i64 noundef %19) #3
  %21 = icmp slt i32 %17, 100
  br i1 %21, label %.loopexit, label %.preheader

.loopexit:                                        ; preds = %15, %2
  call void @CAT_set(i8* %3, i64 10)
  call void @CAT_set(i8* %3, i64 0)
  call void @CAT_set(i8* noundef %3, i64 noundef 42) #3
  %22 = call i64 @CAT_variables() #3
  %23 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([21 x i8], [21 x i8]* @.str, i64 0, i64 0), i64 noundef %22)
  %24 = call i64 @CAT_cost() #3
  %25 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @.str.1, i64 0, i64 0), i64 noundef %24)
  ret i32 0
}

; Function Attrs: argmemonly nounwind
declare dso_local void @CAT_set(i8* noundef, i64 noundef) local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare dso_local noundef i32 @printf(i8* nocapture noundef readonly, ...) local_unnamed_addr #2

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_variables() local_unnamed_addr #1

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_cost() local_unnamed_addr #1

attributes #0 = { nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { argmemonly nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { argmemonly nounwind }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 1}
!2 = !{!"clang version 14.0.6 (git@github.com:scampanoni/LLVM_installer.git fc6ceabb24f6c857bd1637c9b94cd4edf7b2669f)"}
