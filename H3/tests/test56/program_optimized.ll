; ModuleID = 'program_optimized.bc'
source_filename = "program.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [27 x i8] c"Before loop: \09Value = %ld\0A\00", align 1
@.str.1 = private unnamed_addr constant [29 x i8] c"After loop:\09Value = %ld, %f\0A\00", align 1
@.str.2 = private unnamed_addr constant [21 x i8] c"CAT variables = %ld\0A\00", align 1
@.str.3 = private unnamed_addr constant [16 x i8] c"CAT cost = %ld\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local void @CAT_execution(i32 noundef %0) local_unnamed_addr #0 {
  %2 = call i8* @CAT_new(i64 noundef 5) #4
  %3 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([27 x i8], [27 x i8]* @.str, i64 0, i64 0), i64 noundef 5)
  %4 = icmp sgt i32 %0, 0
  br i1 %4, label %.preheader.preheader, label %.loopexit

.preheader.preheader:                             ; preds = %1
  br label %.preheader

.loopexit.loopexit:                               ; preds = %.preheader
  br label %.loopexit

.loopexit:                                        ; preds = %.loopexit.loopexit, %1
  %5 = phi double [ 0x40E98E8DC0000000, %1 ], [ %.lcssa, %.loopexit.loopexit ]
  %6 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([29 x i8], [29 x i8]* @.str.1, i64 0, i64 0), i64 noundef 5, double noundef %5)
  ret void

.preheader:                                       ; preds = %.preheader.preheader, %.preheader
  %7 = phi i32 [ %9, %.preheader ], [ 0, %.preheader.preheader ]
  %8 = phi double [ %.lcssa, %.preheader ], [ 0x40E98E8DC0000000, %.preheader.preheader ]
  %.lcssa = call double @sqrt(double noundef %8) #5
  %9 = add nuw nsw i32 %7, 1
  %10 = icmp eq i32 %9, %0
  br i1 %10, label %.loopexit.loopexit, label %.preheader, !llvm.loop !3
}

; Function Attrs: argmemonly nounwind
declare dso_local i8* @CAT_new(i64 noundef) local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare dso_local noundef i32 @printf(i8* nocapture noundef readonly, ...) local_unnamed_addr #2

; Function Attrs: mustprogress nofree nounwind willreturn writeonly
declare dso_local double @sqrt(double noundef) local_unnamed_addr #3

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 noundef %0, i8** nocapture noundef readnone %1) local_unnamed_addr #0 {
  %3 = call i8* @CAT_new(i64 noundef 5) #4
  %4 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([27 x i8], [27 x i8]* @.str, i64 0, i64 0), i64 noundef 5) #5
  %5 = icmp sgt i32 %0, -10
  br i1 %5, label %6, label %.loopexit

6:                                                ; preds = %2
  %7 = add nsw i32 %0, 9
  br label %8

8:                                                ; preds = %6, %8
  %9 = phi i32 [ %11, %8 ], [ 0, %6 ]
  %10 = phi double [ %.lcssa, %8 ], [ 0x40E98E8DC0000000, %6 ]
  %.lcssa = call double @sqrt(double noundef %10) #5
  %11 = add nuw nsw i32 %9, 1
  %12 = icmp eq i32 %9, %7
  br i1 %12, label %.loopexit.loopexit, label %8, !llvm.loop !3

.loopexit.loopexit:                               ; preds = %8
  br label %.loopexit

.loopexit:                                        ; preds = %.loopexit.loopexit, %2
  %13 = phi double [ 0x40E98E8DC0000000, %2 ], [ %.lcssa, %.loopexit.loopexit ]
  %14 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([29 x i8], [29 x i8]* @.str.1, i64 0, i64 0), i64 noundef 5, double noundef %13) #5
  %15 = call i8* @CAT_new(i64 noundef 52) #4
  call void @CAT_set(i8* %15, i64 104)
  call void @CAT_set(i8* %15, i64 0)
  call void @CAT_set(i8* noundef %15, i64 noundef 42) #4
  %16 = call i64 @CAT_variables() #4
  %17 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([21 x i8], [21 x i8]* @.str.2, i64 0, i64 0), i64 noundef %16)
  %18 = call i64 @CAT_cost() #4
  %19 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @.str.3, i64 0, i64 0), i64 noundef %18)
  ret i32 0
}

; Function Attrs: argmemonly nounwind
declare dso_local void @CAT_set(i8* noundef, i64 noundef) local_unnamed_addr #1

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_variables() local_unnamed_addr #1

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_cost() local_unnamed_addr #1

attributes #0 = { nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { argmemonly nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nofree nounwind willreturn writeonly "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { argmemonly nounwind }
attributes #5 = { nounwind }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 1}
!2 = !{!"clang version 14.0.6 (git@github.com:scampanoni/LLVM_installer.git fc6ceabb24f6c857bd1637c9b94cd4edf7b2669f)"}
!3 = distinct !{!3, !4, !5}
!4 = !{!"llvm.loop.mustprogress"}
!5 = !{!"llvm.loop.unroll.disable"}
