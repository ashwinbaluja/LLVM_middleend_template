; ModuleID = 'program.bc'
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

6:                                                ; preds = %30
  %7 = call i8* @CAT_new(i64 noundef 52) #4
  call void @CAT_add(i8* noundef %7, i8* noundef %7, i8* noundef %7) #4
  call void @CAT_sub(i8* noundef %7, i8* noundef %7, i8* noundef %7) #4
  call void @CAT_set(i8* noundef %7, i64 noundef 42) #4
  %8 = call i64 @CAT_variables() #4
  %9 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([21 x i8], [21 x i8]* @.str.5, i64 0, i64 0), i64 noundef %8)
  %10 = call i64 @CAT_cost() #4
  %11 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @.str.6, i64 0, i64 0), i64 noundef %10)
  ret i32 0

12:                                               ; preds = %2, %30
  %13 = phi i32 [ 1, %2 ], [ %31, %30 ]
  %14 = phi i8* [ %5, %2 ], [ %45, %30 ]
  %15 = call i64 @CAT_get(i8* noundef %14) #4
  %16 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i64 0, i64 0), i64 noundef %15)
  call void @CAT_add(i8* noundef %14, i8* noundef %3, i8* noundef %4) #4
  %17 = call i64 @CAT_get(i8* noundef %14) #4
  %18 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i64 0, i64 0), i64 noundef %17)
  call void @CAT_add(i8* noundef %3, i8* noundef %3, i8* noundef %3) #4
  call void @CAT_add(i8* noundef %4, i8* noundef %4, i8* noundef %4) #4
  %19 = call i8* @CAT_new(i64 noundef 1) #4
  br label %20

20:                                               ; preds = %12, %20
  %21 = phi i32 [ 0, %12 ], [ %28, %20 ]
  %22 = phi i8* [ %19, %12 ], [ %27, %20 ]
  %23 = call i64 @CAT_get(i8* noundef %22) #4
  %24 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @.str.1, i64 0, i64 0), i64 noundef %23)
  call void @CAT_add(i8* noundef %22, i8* noundef %3, i8* noundef %4) #4
  %25 = call i64 @CAT_get(i8* noundef %22) #4
  %26 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @.str.1, i64 0, i64 0), i64 noundef %25)
  call void @CAT_add(i8* noundef %3, i8* noundef %3, i8* noundef %3) #4
  call void @CAT_add(i8* noundef %4, i8* noundef %4, i8* noundef %4) #4
  %27 = call i8* @CAT_new(i64 noundef 1) #4
  %28 = add nuw nsw i32 %21, 1
  %29 = icmp eq i32 %28, 10
  br i1 %29, label %33, label %20, !llvm.loop !3

30:                                               ; preds = %44
  %31 = add nuw nsw i32 %13, 1
  %32 = icmp eq i32 %31, 11
  br i1 %32, label %6, label %12, !llvm.loop !6

33:                                               ; preds = %20, %44
  %34 = phi i32 [ %47, %44 ], [ 0, %20 ]
  %35 = phi i32 [ %46, %44 ], [ 0, %20 ]
  %36 = phi i8* [ %45, %44 ], [ %27, %20 ]
  %37 = call i32 @llvm.umax.i32(i32 %34, i32 1)
  %38 = call i64 @CAT_get(i8* noundef %36) #4
  %39 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i64 0, i64 0), i64 noundef %38)
  call void @CAT_add(i8* noundef %36, i8* noundef %3, i8* noundef %4) #4
  %40 = call i64 @CAT_get(i8* noundef %36) #4
  %41 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i64 0, i64 0), i64 noundef %40)
  call void @CAT_add(i8* noundef %3, i8* noundef %3, i8* noundef %3) #4
  call void @CAT_add(i8* noundef %4, i8* noundef %4, i8* noundef %4) #4
  %42 = call i8* @CAT_new(i64 noundef 1) #4
  %43 = icmp eq i32 %35, 0
  br i1 %43, label %44, label %49

44:                                               ; preds = %60, %33
  %45 = phi i8* [ %42, %33 ], [ %61, %60 ]
  %46 = add nuw nsw i32 %35, 1
  %47 = add nuw nsw i32 %34, 3
  %48 = icmp eq i32 %46, %13
  br i1 %48, label %30, label %33, !llvm.loop !7

49:                                               ; preds = %33, %60
  %50 = phi i32 [ %63, %60 ], [ 0, %33 ]
  %51 = phi i32 [ %62, %60 ], [ 0, %33 ]
  %52 = phi i8* [ %61, %60 ], [ %42, %33 ]
  %53 = call i32 @llvm.umax.i32(i32 %50, i32 1)
  %54 = call i64 @CAT_get(i8* noundef %52) #4
  %55 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([10 x i8], [10 x i8]* @.str.3, i64 0, i64 0), i64 noundef %54)
  call void @CAT_add(i8* noundef %52, i8* noundef %3, i8* noundef %4) #4
  %56 = call i64 @CAT_get(i8* noundef %52) #4
  %57 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([10 x i8], [10 x i8]* @.str.3, i64 0, i64 0), i64 noundef %56)
  call void @CAT_add(i8* noundef %3, i8* noundef %3, i8* noundef %3) #4
  call void @CAT_add(i8* noundef %4, i8* noundef %4, i8* noundef %4) #4
  %58 = call i8* @CAT_new(i64 noundef 1) #4
  %59 = icmp eq i32 %51, 0
  br i1 %59, label %60, label %65

60:                                               ; preds = %65, %49
  %61 = phi i8* [ %58, %49 ], [ %72, %65 ]
  %62 = add nuw nsw i32 %51, 1
  %63 = add nuw nsw i32 %50, 2
  %64 = icmp eq i32 %62, %37
  br i1 %64, label %44, label %49, !llvm.loop !8

65:                                               ; preds = %49, %65
  %66 = phi i32 [ %73, %65 ], [ 0, %49 ]
  %67 = phi i8* [ %72, %65 ], [ %58, %49 ]
  %68 = call i64 @CAT_get(i8* noundef %67) #4
  %69 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([11 x i8], [11 x i8]* @.str.4, i64 0, i64 0), i64 noundef %68)
  call void @CAT_add(i8* noundef %67, i8* noundef %3, i8* noundef %4) #4
  %70 = call i64 @CAT_get(i8* noundef %67) #4
  %71 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([11 x i8], [11 x i8]* @.str.4, i64 0, i64 0), i64 noundef %70)
  call void @CAT_add(i8* noundef %3, i8* noundef %3, i8* noundef %3) #4
  call void @CAT_add(i8* noundef %4, i8* noundef %4, i8* noundef %4) #4
  %72 = call i8* @CAT_new(i64 noundef 1) #4
  %73 = add nuw nsw i32 %66, 1
  %74 = icmp eq i32 %73, %53
  br i1 %74, label %60, label %65, !llvm.loop !9
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
declare dso_local void @CAT_sub(i8* noundef, i8* noundef, i8* noundef) local_unnamed_addr #1

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
