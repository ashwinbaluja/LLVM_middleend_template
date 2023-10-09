; ModuleID = 'program.bc'
source_filename = "program.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [20 x i8] c"H1: \09Value 2 = %ld\0A\00", align 1
@.str.1 = private unnamed_addr constant [19 x i8] c"H1: \09Result = %ld\0A\00", align 1
@.str.2 = private unnamed_addr constant [20 x i8] c"H1: \09Value 1 = %ld\0A\00", align 1
@.str.3 = private unnamed_addr constant [21 x i8] c"CAT variables = %ld\0A\00", align 1
@.str.4 = private unnamed_addr constant [16 x i8] c"CAT cost = %ld\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local void @CAT_execution(i32 noundef %0) local_unnamed_addr #0 {
  %2 = icmp slt i32 %0, 101
  br i1 %2, label %24, label %3

3:                                                ; preds = %1, %24
  %4 = phi i8* [ %25, %24 ], [ undef, %1 ]
  %5 = icmp sgt i32 %0, 0
  br i1 %5, label %6, label %9

6:                                                ; preds = %3
  %7 = icmp sgt i32 %0, 10
  %8 = icmp sgt i32 %0, 20
  br label %10

9:                                                ; preds = %19, %3
  ret void

10:                                               ; preds = %6, %19
  %11 = phi i32 [ 0, %6 ], [ %22, %19 ]
  %12 = call i8* @CAT_new(i64 noundef 8) #3
  br i1 %7, label %13, label %14

13:                                               ; preds = %10
  call void @CAT_add(i8* noundef %12, i8* noundef %12, i8* noundef %12) #3
  br label %14

14:                                               ; preds = %13, %10
  %15 = call i64 @CAT_get(i8* noundef %12) #3
  %16 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([20 x i8], [20 x i8]* @.str, i64 0, i64 0), i64 noundef %15)
  %17 = call i8* @CAT_new(i64 noundef 0) #3
  call void @CAT_add(i8* noundef %17, i8* noundef %4, i8* noundef %12) #3
  call void @CAT_add(i8* noundef %17, i8* noundef %4, i8* noundef %17) #3
  call void @CAT_add(i8* noundef %17, i8* noundef %17, i8* noundef %17) #3
  call void @CAT_sub(i8* noundef %17, i8* noundef %17, i8* noundef %4) #3
  br i1 %8, label %18, label %19

18:                                               ; preds = %14
  call void @CAT_add(i8* noundef %17, i8* noundef %4, i8* noundef %4) #3
  call void @CAT_set(i8* noundef %4, i64 noundef 42) #3
  br label %19

19:                                               ; preds = %18, %14
  %20 = call i64 @CAT_get(i8* noundef %17) #3
  %21 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i64 0, i64 0), i64 noundef %20)
  %22 = add nuw nsw i32 %11, 1
  %23 = icmp eq i32 %22, %0
  br i1 %23, label %9, label %10, !llvm.loop !3

24:                                               ; preds = %1
  %25 = call i8* @CAT_new(i64 noundef 5) #3
  %26 = call i64 @CAT_get(i8* noundef %25) #3
  %27 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([20 x i8], [20 x i8]* @.str.2, i64 0, i64 0), i64 noundef %26)
  br label %3
}

; Function Attrs: argmemonly nounwind
declare dso_local i8* @CAT_new(i64 noundef) local_unnamed_addr #1

; Function Attrs: argmemonly nounwind
declare dso_local void @CAT_add(i8* noundef, i8* noundef, i8* noundef) local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare dso_local noundef i32 @printf(i8* nocapture noundef readonly, ...) local_unnamed_addr #2

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_get(i8* noundef) local_unnamed_addr #1

; Function Attrs: argmemonly nounwind
declare dso_local void @CAT_sub(i8* noundef, i8* noundef, i8* noundef) local_unnamed_addr #1

; Function Attrs: argmemonly nounwind
declare dso_local void @CAT_set(i8* noundef, i64 noundef) local_unnamed_addr #1

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 noundef %0, i8** nocapture noundef readnone %1) local_unnamed_addr #0 {
  call void @CAT_execution(i32 noundef %0)
  %3 = call i64 @CAT_variables() #3
  %4 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([21 x i8], [21 x i8]* @.str.3, i64 0, i64 0), i64 noundef %3)
  %5 = call i64 @CAT_cost() #3
  %6 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @.str.4, i64 0, i64 0), i64 noundef %5)
  ret i32 0
}

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
!2 = !{!"clang version 14.0.6"}
!3 = distinct !{!3, !4, !5}
!4 = !{!"llvm.loop.mustprogress"}
!5 = !{!"llvm.loop.unroll.disable"}
