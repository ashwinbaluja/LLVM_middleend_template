; ModuleID = 'program_optimized.bc'
source_filename = "program.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [8 x i8] c"Z: %ld\0A\00", align 1
@.str.1 = private unnamed_addr constant [9 x i8] c"Z2: %ld\0A\00", align 1
@.str.2 = private unnamed_addr constant [9 x i8] c"Z3: %ld\0A\00", align 1
@.str.3 = private unnamed_addr constant [10 x i8] c"Z21: %ld\0A\00", align 1
@.str.4 = private unnamed_addr constant [11 x i8] c"Z211: %ld\0A\00", align 1
@.str.5 = private unnamed_addr constant [21 x i8] c"CAT variables = %ld\0A\00", align 1
@.str.6 = private unnamed_addr constant [16 x i8] c"CAT cost = %ld\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 noundef %0, i8** nocapture noundef readnone %1) local_unnamed_addr #0 {
  %3 = call i8* @CAT_new(i64 noundef 40) #4
  %4 = call i8* @CAT_new(i64 noundef 2) #4
  %5 = call i8* @CAT_new(i64 noundef 0) #4
  br label %12

6:                                                ; preds = %23
  %7 = call i8* @CAT_new(i64 noundef 52) #4
  call void @CAT_set(i8* %7, i64 104)
  call void @CAT_set(i8* %7, i64 0)
  call void @CAT_set(i8* noundef %7, i64 noundef 42) #4
  %8 = call i64 @CAT_variables() #4
  %9 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([21 x i8], [21 x i8]* @.str.5, i64 0, i64 0), i64 noundef %8)
  %10 = call i64 @CAT_cost() #4
  %11 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @.str.6, i64 0, i64 0), i64 noundef %10)
  ret i32 0

12:                                               ; preds = %2, %23
  %13 = phi i32 [ 1, %2 ], [ %24, %23 ]
  %14 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i64 0, i64 0), i64 noundef 0)
  call void @CAT_set(i8* %5, i64 42)
  %15 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i64 0, i64 0), i64 noundef 42)
  call void @CAT_set(i8* %3, i64 80)
  call void @CAT_set(i8* %4, i64 4)
  %16 = call i8* @CAT_new(i64 noundef 1) #4
  br label %17

17:                                               ; preds = %12, %17
  %18 = phi i32 [ 0, %12 ], [ %21, %17 ]
  %19 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @.str.1, i64 0, i64 0), i64 noundef 1)
  call void @CAT_set(i8* %16, i64 84)
  %20 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @.str.1, i64 0, i64 0), i64 noundef 1)
  call void @CAT_set(i8* %3, i64 160)
  call void @CAT_set(i8* %4, i64 8)
  %.lcssa = call i8* @CAT_new(i64 noundef 1) #4
  %21 = add nuw nsw i32 %18, 1
  %22 = icmp eq i32 %21, 10
  br i1 %22, label %.preheader3.preheader, label %17, !llvm.loop !3

.preheader3.preheader:                            ; preds = %17
  br label %.preheader3

23:                                               ; preds = %.loopexit2
  %24 = add nuw nsw i32 %13, 1
  %25 = icmp eq i32 %24, 11
  br i1 %25, label %6, label %12, !llvm.loop !6

.preheader3:                                      ; preds = %.preheader3.preheader, %.loopexit2
  %26 = phi i32 [ %33, %.loopexit2 ], [ 0, %.preheader3.preheader ]
  %27 = phi i32 [ %32, %.loopexit2 ], [ 0, %.preheader3.preheader ]
  %28 = call i32 @llvm.umax.i32(i32 %26, i32 1)
  %29 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i64 0, i64 0), i64 noundef 1)
  call void @CAT_set(i8* %.lcssa, i64 168)
  %30 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i64 0, i64 0), i64 noundef 1)
  call void @CAT_set(i8* %3, i64 320)
  call void @CAT_set(i8* %4, i64 16)
  %.lcssa6 = call i8* @CAT_new(i64 noundef 1) #4
  %31 = icmp eq i32 %27, 0
  br i1 %31, label %.loopexit2, label %.preheader1.preheader

.preheader1.preheader:                            ; preds = %.preheader3
  br label %.preheader1

.loopexit2.loopexit:                              ; preds = %.loopexit
  br label %.loopexit2

.loopexit2:                                       ; preds = %.loopexit2.loopexit, %.preheader3
  %32 = add nuw nsw i32 %27, 1
  %33 = add nuw nsw i32 %26, 3
  %34 = icmp eq i32 %32, %13
  br i1 %34, label %23, label %.preheader3, !llvm.loop !7

.preheader1:                                      ; preds = %.preheader1.preheader, %.loopexit
  %35 = phi i32 [ %42, %.loopexit ], [ 0, %.preheader1.preheader ]
  %36 = phi i32 [ %41, %.loopexit ], [ 0, %.preheader1.preheader ]
  %37 = call i32 @llvm.umax.i32(i32 %35, i32 1)
  %38 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([10 x i8], [10 x i8]* @.str.3, i64 0, i64 0), i64 noundef 1)
  call void @CAT_set(i8* %.lcssa6, i64 336)
  %39 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([10 x i8], [10 x i8]* @.str.3, i64 0, i64 0), i64 noundef 1)
  call void @CAT_set(i8* %3, i64 640)
  call void @CAT_set(i8* %4, i64 32)
  %.lcssa5 = call i8* @CAT_new(i64 noundef 1) #4
  %40 = icmp eq i32 %36, 0
  br i1 %40, label %.loopexit, label %.preheader.preheader

.preheader.preheader:                             ; preds = %.preheader1
  br label %.preheader

.loopexit.loopexit:                               ; preds = %.preheader
  br label %.loopexit

.loopexit:                                        ; preds = %.loopexit.loopexit, %.preheader1
  %41 = add nuw nsw i32 %36, 1
  %42 = add nuw nsw i32 %35, 2
  %43 = icmp eq i32 %41, %28
  br i1 %43, label %.loopexit2.loopexit, label %.preheader1, !llvm.loop !8

.preheader:                                       ; preds = %.preheader.preheader, %.preheader
  %44 = phi i32 [ %47, %.preheader ], [ 0, %.preheader.preheader ]
  %45 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([11 x i8], [11 x i8]* @.str.4, i64 0, i64 0), i64 noundef 1)
  call void @CAT_set(i8* %.lcssa5, i64 672)
  %46 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([11 x i8], [11 x i8]* @.str.4, i64 0, i64 0), i64 noundef 1)
  call void @CAT_set(i8* %3, i64 1280)
  call void @CAT_set(i8* %4, i64 64)
  %.lcssa4 = call i8* @CAT_new(i64 noundef 1) #4
  %47 = add nuw nsw i32 %44, 1
  %48 = icmp eq i32 %47, %37
  br i1 %48, label %.loopexit.loopexit, label %.preheader, !llvm.loop !9
}

; Function Attrs: argmemonly nounwind
declare dso_local i8* @CAT_new(i64 noundef) local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare dso_local noundef i32 @printf(i8* nocapture noundef readonly, ...) local_unnamed_addr #2

; Function Attrs: argmemonly nounwind
declare dso_local void @CAT_set(i8* noundef, i64 noundef) local_unnamed_addr #1

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_variables() local_unnamed_addr #1

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_cost() local_unnamed_addr #1

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.umax.i32(i32, i32) #3

attributes #0 = { nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { argmemonly nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #4 = { argmemonly nounwind }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 1}
!2 = !{!"clang version 14.0.6 (git@github.com:scampanoni/LLVM_installer.git fc6ceabb24f6c857bd1637c9b94cd4edf7b2669f)"}
!3 = distinct !{!3, !4, !5}
!4 = !{!"llvm.loop.mustprogress"}
!5 = !{!"llvm.loop.unroll.disable"}
!6 = distinct !{!6, !4, !5}
!7 = distinct !{!7, !4, !5}
!8 = distinct !{!8, !4, !5}
!9 = distinct !{!9, !4, !5}
