; ModuleID = 'output_code_iter_4.bc'
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
  %6 = call i32 @llvm.smax.i32(i32 %0, i32 -1)
  %7 = add i32 %6, 2
  br label %8

8:                                                ; preds = %19, %2
  %9 = phi i32 [ %20, %19 ], [ 1, %2 ]
  %10 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i64 0, i64 0), i64 noundef 0)
  call void @CAT_set(i8* %5, i64 42)
  %11 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i64 0, i64 0), i64 noundef 42)
  call void @CAT_set(i8* %3, i64 80)
  call void @CAT_set(i8* %4, i64 4)
  %12 = call i8* @CAT_new(i64 noundef 1) #4
  br label %13

13:                                               ; preds = %8, %13
  %14 = phi i32 [ 0, %8 ], [ %17, %13 ]
  %15 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @.str.1, i64 0, i64 0), i64 noundef 1)
  call void @CAT_set(i8* %12, i64 84)
  %16 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @.str.1, i64 0, i64 0), i64 noundef 1)
  call void @CAT_set(i8* %3, i64 160)
  call void @CAT_set(i8* %4, i64 8)
  %.lcssa = call i8* @CAT_new(i64 noundef 1) #4
  %17 = add nuw nsw i32 %14, 1
  %18 = icmp eq i32 %17, 10
  br i1 %18, label %.preheader3, label %13, !llvm.loop !3

19:                                               ; preds = %.loopexit2
  %20 = add nuw i32 %9, 1
  %21 = icmp eq i32 %9, %7
  br i1 %21, label %45, label %8, !llvm.loop !6

.preheader3:                                      ; preds = %13, %.loopexit2
  %22 = phi i32 [ %29, %.loopexit2 ], [ 0, %13 ]
  %23 = phi i32 [ %28, %.loopexit2 ], [ 0, %13 ]
  %24 = call i32 @llvm.umax.i32(i32 %22, i32 1)
  %25 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i64 0, i64 0), i64 noundef 1)
  call void @CAT_set(i8* %.lcssa, i64 168)
  %26 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i64 0, i64 0), i64 noundef 1)
  call void @CAT_set(i8* %3, i64 320)
  call void @CAT_set(i8* %4, i64 16)
  %.lcssa6 = call i8* @CAT_new(i64 noundef 1) #4
  %27 = icmp eq i32 %23, 0
  br i1 %27, label %.loopexit2, label %.preheader1

.loopexit2:                                       ; preds = %.loopexit, %.preheader3
  %28 = add nuw i32 %23, 1
  %29 = add i32 %22, 3
  %30 = icmp eq i32 %28, %9
  br i1 %30, label %19, label %.preheader3, !llvm.loop !7

.preheader1:                                      ; preds = %.preheader3, %.loopexit
  %31 = phi i32 [ %38, %.loopexit ], [ 0, %.preheader3 ]
  %32 = phi i32 [ %37, %.loopexit ], [ 0, %.preheader3 ]
  %33 = call i32 @llvm.umax.i32(i32 %31, i32 1)
  %34 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([10 x i8], [10 x i8]* @.str.3, i64 0, i64 0), i64 noundef 1)
  call void @CAT_set(i8* %.lcssa6, i64 336)
  %35 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([10 x i8], [10 x i8]* @.str.3, i64 0, i64 0), i64 noundef 1)
  call void @CAT_set(i8* %3, i64 640)
  call void @CAT_set(i8* %4, i64 32)
  %.lcssa5 = call i8* @CAT_new(i64 noundef 1) #4
  %36 = icmp eq i32 %32, 0
  br i1 %36, label %.loopexit, label %.preheader

.loopexit:                                        ; preds = %.preheader, %.preheader1
  %37 = add nuw i32 %32, 1
  %38 = add i32 %31, 2
  %39 = icmp eq i32 %37, %24
  br i1 %39, label %.loopexit2, label %.preheader1, !llvm.loop !8

.preheader:                                       ; preds = %.preheader1, %.preheader
  %40 = phi i32 [ %43, %.preheader ], [ 0, %.preheader1 ]
  %41 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([11 x i8], [11 x i8]* @.str.4, i64 0, i64 0), i64 noundef 1)
  call void @CAT_set(i8* %.lcssa5, i64 672)
  %42 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([11 x i8], [11 x i8]* @.str.4, i64 0, i64 0), i64 noundef 1)
  call void @CAT_set(i8* %3, i64 1280)
  call void @CAT_set(i8* %4, i64 64)
  %.lcssa4 = call i8* @CAT_new(i64 noundef 1) #4
  %43 = add nuw i32 %40, 1
  %44 = icmp eq i32 %43, %33
  br i1 %44, label %.loopexit, label %.preheader, !llvm.loop !9

45:                                               ; preds = %19
  %46 = call i8* @CAT_new(i64 noundef 52) #4
  call void @CAT_set(i8* %46, i64 104)
  call void @CAT_set(i8* %46, i64 0)
  call void @CAT_set(i8* noundef %46, i64 noundef 42) #4
  %47 = call i64 @CAT_variables() #4
  %48 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([21 x i8], [21 x i8]* @.str.5, i64 0, i64 0), i64 noundef %47)
  %49 = call i64 @CAT_cost() #4
  %50 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @.str.6, i64 0, i64 0), i64 noundef %49)
  ret i32 0
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

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.smax.i32(i32, i32) #3

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
