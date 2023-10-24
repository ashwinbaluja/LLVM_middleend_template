; ModuleID = 'program_optimized.bc'
source_filename = "program.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [21 x i8] c"CAT variables = %ld\0A\00", align 1
@.str.1 = private unnamed_addr constant [16 x i8] c"CAT cost = %ld\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local void @a_generic_C_function(i8* noundef %0, i32 noundef %1) local_unnamed_addr #0 {
  %3 = icmp slt i32 %1, 100
  br i1 %3, label %.loopexit, label %.preheader.preheader

.preheader.preheader:                             ; preds = %2
  br label %.preheader

.loopexit.loopexit:                               ; preds = %14
  br label %.loopexit

.loopexit:                                        ; preds = %.loopexit.loopexit, %2
  ret void

.preheader:                                       ; preds = %.preheader.preheader, %14
  %4 = phi i32 [ %16, %14 ], [ %1, %.preheader.preheader ]
  %5 = phi i8* [ %19, %14 ], [ %0, %.preheader.preheader ]
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
  br i1 %20, label %.loopexit.loopexit, label %.preheader
}

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_get(i8* noundef) local_unnamed_addr #1

; Function Attrs: argmemonly nounwind
declare dso_local i8* @CAT_new(i64 noundef) local_unnamed_addr #1

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 noundef %0, i8** nocapture noundef readnone %1) local_unnamed_addr #0 {
  %3 = call i8* @CAT_new(i64 noundef 5) #3
  %4 = icmp slt i32 %0, 100
  br i1 %4, label %.loopexit, label %.preheader.preheader

.preheader.preheader:                             ; preds = %2
  br label %.preheader

.preheader:                                       ; preds = %.preheader.preheader, %.preheader
  %5 = phi i32 [ %6, %.preheader ], [ %0, %.preheader.preheader ]
  %6 = add nsw i32 %5, -1
  %7 = call i8* @CAT_new(i64 noundef 4) #3
  %8 = icmp slt i32 %5, 101
  br i1 %8, label %.loopexit.loopexit, label %.preheader

.loopexit.loopexit:                               ; preds = %.preheader
  br label %.loopexit

.loopexit:                                        ; preds = %.loopexit.loopexit, %2
  call void @CAT_set(i8* %3, i64 10)
  call void @CAT_set(i8* %3, i64 0)
  call void @CAT_set(i8* noundef %3, i64 noundef 42) #3
  %9 = call i64 @CAT_variables() #3
  %10 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([21 x i8], [21 x i8]* @.str, i64 0, i64 0), i64 noundef %9)
  %11 = call i64 @CAT_cost() #3
  %12 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @.str.1, i64 0, i64 0), i64 noundef %11)
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
