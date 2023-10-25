; ModuleID = 'output_code_iter_1.bc'
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

8:                                                ; preds = %25, %2
  %9 = phi i32 [ %26, %25 ], [ 1, %2 ]
  %10 = phi i8* [ %.lcssa6, %25 ], [ %5, %2 ]
  %11 = call i64 @CAT_get(i8* noundef %10) #4
  %12 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i64 0, i64 0), i64 noundef %11)
  call void @CAT_add(i8* noundef %10, i8* noundef %3, i8* noundef %4) #4
  %13 = call i64 @CAT_get(i8* noundef %10) #4
  %14 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i64 0, i64 0), i64 noundef %13)
  call void @CAT_add(i8* noundef %3, i8* noundef %3, i8* noundef %3) #4
  call void @CAT_add(i8* noundef %4, i8* noundef %4, i8* noundef %4) #4
  %15 = call i8* @CAT_new(i64 noundef 1) #4
  br label %16

16:                                               ; preds = %8, %16
  %17 = phi i32 [ 0, %8 ], [ %23, %16 ]
  %18 = phi i8* [ %15, %8 ], [ %.lcssa, %16 ]
  %19 = call i64 @CAT_get(i8* noundef %18) #4
  %20 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @.str.1, i64 0, i64 0), i64 noundef %19)
  call void @CAT_add(i8* noundef %18, i8* noundef %3, i8* noundef %4) #4
  %21 = call i64 @CAT_get(i8* noundef %18) #4
  %22 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @.str.1, i64 0, i64 0), i64 noundef %21)
  call void @CAT_add(i8* noundef %3, i8* noundef %3, i8* noundef %3) #4
  call void @CAT_add(i8* noundef %4, i8* noundef %4, i8* noundef %4) #4
  %.lcssa = call i8* @CAT_new(i64 noundef 1) #4
  %23 = add nuw nsw i32 %17, 1
  %24 = icmp eq i32 %23, 10
  br i1 %24, label %.preheader3, label %16, !llvm.loop !3

25:                                               ; preds = %.loopexit2
  %26 = add nuw i32 %9, 1
  %27 = icmp eq i32 %9, %7
  br i1 %27, label %60, label %8, !llvm.loop !6

.preheader3:                                      ; preds = %16, %.loopexit2
  %28 = phi i32 [ %38, %.loopexit2 ], [ 0, %16 ]
  %29 = phi i32 [ %37, %.loopexit2 ], [ 0, %16 ]
  %30 = phi i8* [ %.lcssa6, %.loopexit2 ], [ %.lcssa, %16 ]
  %31 = call i32 @llvm.umax.i32(i32 %28, i32 1)
  %32 = call i64 @CAT_get(i8* noundef %30) #4
  %33 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i64 0, i64 0), i64 noundef %32)
  call void @CAT_add(i8* noundef %30, i8* noundef %3, i8* noundef %4) #4
  %34 = call i64 @CAT_get(i8* noundef %30) #4
  %35 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i64 0, i64 0), i64 noundef %34)
  call void @CAT_add(i8* noundef %3, i8* noundef %3, i8* noundef %3) #4
  call void @CAT_add(i8* noundef %4, i8* noundef %4, i8* noundef %4) #4
  %.lcssa6 = call i8* @CAT_new(i64 noundef 1) #4
  %36 = icmp eq i32 %29, 0
  br i1 %36, label %.loopexit2, label %.preheader1

.loopexit2:                                       ; preds = %.loopexit, %.preheader3
  %37 = add nuw i32 %29, 1
  %38 = add i32 %28, 3
  %39 = icmp eq i32 %37, %9
  br i1 %39, label %25, label %.preheader3, !llvm.loop !7

.preheader1:                                      ; preds = %.preheader3, %.loopexit
  %40 = phi i32 [ %50, %.loopexit ], [ 0, %.preheader3 ]
  %41 = phi i32 [ %49, %.loopexit ], [ 0, %.preheader3 ]
  %42 = phi i8* [ %.lcssa5, %.loopexit ], [ %.lcssa6, %.preheader3 ]
  %43 = call i32 @llvm.umax.i32(i32 %40, i32 1)
  %44 = call i64 @CAT_get(i8* noundef %42) #4
  %45 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([10 x i8], [10 x i8]* @.str.3, i64 0, i64 0), i64 noundef %44)
  call void @CAT_add(i8* noundef %42, i8* noundef %3, i8* noundef %4) #4
  %46 = call i64 @CAT_get(i8* noundef %42) #4
  %47 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([10 x i8], [10 x i8]* @.str.3, i64 0, i64 0), i64 noundef %46)
  call void @CAT_add(i8* noundef %3, i8* noundef %3, i8* noundef %3) #4
  call void @CAT_add(i8* noundef %4, i8* noundef %4, i8* noundef %4) #4
  %.lcssa5 = call i8* @CAT_new(i64 noundef 1) #4
  %48 = icmp eq i32 %41, 0
  br i1 %48, label %.loopexit, label %.preheader

.loopexit:                                        ; preds = %.preheader, %.preheader1
  %49 = add nuw i32 %41, 1
  %50 = add i32 %40, 2
  %51 = icmp eq i32 %49, %31
  br i1 %51, label %.loopexit2, label %.preheader1, !llvm.loop !8

.preheader:                                       ; preds = %.preheader1, %.preheader
  %52 = phi i32 [ %58, %.preheader ], [ 0, %.preheader1 ]
  %53 = phi i8* [ %.lcssa4, %.preheader ], [ %.lcssa5, %.preheader1 ]
  %54 = call i64 @CAT_get(i8* noundef %53) #4
  %55 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([11 x i8], [11 x i8]* @.str.4, i64 0, i64 0), i64 noundef %54)
  call void @CAT_add(i8* noundef %53, i8* noundef %3, i8* noundef %4) #4
  %56 = call i64 @CAT_get(i8* noundef %53) #4
  %57 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([11 x i8], [11 x i8]* @.str.4, i64 0, i64 0), i64 noundef %56)
  call void @CAT_add(i8* noundef %3, i8* noundef %3, i8* noundef %3) #4
  call void @CAT_add(i8* noundef %4, i8* noundef %4, i8* noundef %4) #4
  %.lcssa4 = call i8* @CAT_new(i64 noundef 1) #4
  %58 = add nuw i32 %52, 1
  %59 = icmp eq i32 %58, %43
  br i1 %59, label %.loopexit, label %.preheader, !llvm.loop !9

60:                                               ; preds = %25
  %61 = call i8* @CAT_new(i64 noundef 52) #4
  call void @CAT_set(i8* %61, i64 104)
  call void @CAT_set(i8* %61, i64 0)
  call void @CAT_set(i8* noundef %61, i64 noundef 42) #4
  %62 = call i64 @CAT_variables() #4
  %63 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([21 x i8], [21 x i8]* @.str.5, i64 0, i64 0), i64 noundef %62)
  %64 = call i64 @CAT_cost() #4
  %65 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @.str.6, i64 0, i64 0), i64 noundef %64)
  ret i32 0
}

; Function Attrs: argmemonly nounwind
declare dso_local i8* @CAT_new(i64 noundef) local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare dso_local noundef i32 @printf(i8* nocapture noundef readonly, ...) local_unnamed_addr #2

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_get(i8* noundef) local_unnamed_addr #1

; Function Attrs: argmemonly nounwind
declare dso_local void @CAT_add(i8* noundef, i8* noundef, i8* noundef) local_unnamed_addr #1

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
