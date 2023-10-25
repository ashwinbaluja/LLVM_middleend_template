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
  %3 = call i8* @CAT_new(i64 noundef 40) #3
  %4 = call i8* @CAT_new(i64 noundef 2) #3
  %5 = call i8* @CAT_new(i64 noundef 0) #3
  br label %12

6:                                                ; preds = %29
  %7 = call i8* @CAT_new(i64 noundef 52) #3
  call void @CAT_set(i8* %7, i64 104)
  call void @CAT_set(i8* %7, i64 0)
  call void @CAT_set(i8* noundef %7, i64 noundef 42) #3
  %8 = call i64 @CAT_variables() #3
  %9 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([21 x i8], [21 x i8]* @.str.5, i64 0, i64 0), i64 noundef %8)
  %10 = call i64 @CAT_cost() #3
  %11 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @.str.6, i64 0, i64 0), i64 noundef %10)
  ret i32 0

12:                                               ; preds = %2, %29
  %13 = phi i32 [ 0, %2 ], [ %30, %29 ]
  %14 = phi i8* [ %5, %2 ], [ %.lcssa1, %29 ]
  %15 = call i64 @CAT_get(i8* noundef %14) #3
  %16 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i64 0, i64 0), i64 noundef %15)
  call void @CAT_add(i8* noundef %14, i8* noundef %3, i8* noundef %4) #3
  %17 = call i64 @CAT_get(i8* noundef %14) #3
  %18 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i64 0, i64 0), i64 noundef %17)
  call void @CAT_add(i8* noundef %3, i8* noundef %3, i8* noundef %3) #3
  call void @CAT_add(i8* noundef %4, i8* noundef %4, i8* noundef %4) #3
  %19 = call i8* @CAT_new(i64 noundef 1) #3
  br label %20

20:                                               ; preds = %12, %20
  %21 = phi i32 [ 0, %12 ], [ %27, %20 ]
  %22 = phi i8* [ %19, %12 ], [ %.lcssa, %20 ]
  %23 = call i64 @CAT_get(i8* noundef %22) #3
  %24 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @.str.1, i64 0, i64 0), i64 noundef %23)
  call void @CAT_add(i8* noundef %22, i8* noundef %3, i8* noundef %4) #3
  %25 = call i64 @CAT_get(i8* noundef %22) #3
  %26 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @.str.1, i64 0, i64 0), i64 noundef %25)
  call void @CAT_add(i8* noundef %3, i8* noundef %3, i8* noundef %3) #3
  call void @CAT_add(i8* noundef %4, i8* noundef %4, i8* noundef %4) #3
  %.lcssa = call i8* @CAT_new(i64 noundef 1) #3
  %27 = add nuw nsw i32 %21, 1
  %28 = icmp eq i32 %27, 10
  br i1 %28, label %.preheader, label %20, !llvm.loop !3

29:                                               ; preds = %39
  %30 = add nuw nsw i32 %13, 1
  %31 = icmp eq i32 %30, 10
  br i1 %31, label %6, label %12, !llvm.loop !6

.preheader:                                       ; preds = %20, %39
  %32 = phi i32 [ %40, %39 ], [ 0, %20 ]
  %33 = phi i8* [ %.lcssa1, %39 ], [ %.lcssa, %20 ]
  %34 = call i64 @CAT_get(i8* noundef %33) #3
  %35 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i64 0, i64 0), i64 noundef %34)
  call void @CAT_add(i8* noundef %33, i8* noundef %3, i8* noundef %4) #3
  %36 = call i64 @CAT_get(i8* noundef %33) #3
  %37 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i64 0, i64 0), i64 noundef %36)
  call void @CAT_add(i8* noundef %3, i8* noundef %3, i8* noundef %3) #3
  call void @CAT_add(i8* noundef %4, i8* noundef %4, i8* noundef %4) #3
  %38 = call i8* @CAT_new(i64 noundef 1) #3
  br label %42

39:                                               ; preds = %50
  %40 = add nuw nsw i32 %32, 1
  %41 = icmp eq i32 %40, 10
  br i1 %41, label %29, label %.preheader, !llvm.loop !7

42:                                               ; preds = %.preheader, %50
  %43 = phi i32 [ 0, %.preheader ], [ %51, %50 ]
  %44 = phi i8* [ %38, %.preheader ], [ %.lcssa1, %50 ]
  %45 = call i64 @CAT_get(i8* noundef %44) #3
  %46 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([10 x i8], [10 x i8]* @.str.3, i64 0, i64 0), i64 noundef %45)
  call void @CAT_add(i8* noundef %44, i8* noundef %3, i8* noundef %4) #3
  %47 = call i64 @CAT_get(i8* noundef %44) #3
  %48 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([10 x i8], [10 x i8]* @.str.3, i64 0, i64 0), i64 noundef %47)
  call void @CAT_add(i8* noundef %3, i8* noundef %3, i8* noundef %3) #3
  call void @CAT_add(i8* noundef %4, i8* noundef %4, i8* noundef %4) #3
  %49 = call i8* @CAT_new(i64 noundef 1) #3
  br label %53

50:                                               ; preds = %53
  %51 = add nuw nsw i32 %43, 1
  %52 = icmp eq i32 %51, 10
  br i1 %52, label %39, label %42, !llvm.loop !8

53:                                               ; preds = %42, %53
  %54 = phi i32 [ 0, %42 ], [ %60, %53 ]
  %55 = phi i8* [ %49, %42 ], [ %.lcssa1, %53 ]
  %56 = call i64 @CAT_get(i8* noundef %55) #3
  %57 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([11 x i8], [11 x i8]* @.str.4, i64 0, i64 0), i64 noundef %56)
  call void @CAT_add(i8* noundef %55, i8* noundef %3, i8* noundef %4) #3
  %58 = call i64 @CAT_get(i8* noundef %55) #3
  %59 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([11 x i8], [11 x i8]* @.str.4, i64 0, i64 0), i64 noundef %58)
  call void @CAT_add(i8* noundef %3, i8* noundef %3, i8* noundef %3) #3
  call void @CAT_add(i8* noundef %4, i8* noundef %4, i8* noundef %4) #3
  %.lcssa1 = call i8* @CAT_new(i64 noundef 1) #3
  %60 = add nuw nsw i32 %54, 1
  %61 = icmp eq i32 %60, 10
  br i1 %61, label %50, label %53, !llvm.loop !9
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

attributes #0 = { nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { argmemonly nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { argmemonly nounwind }

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
