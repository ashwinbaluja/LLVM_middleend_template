; ModuleID = 'program_optimized.bc'
source_filename = "program.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [20 x i8] c"H1: \09Value 1 = %ld\0A\00", align 1
@.str.1 = private unnamed_addr constant [20 x i8] c"H1: \09Value 2 = %ld\0A\00", align 1
@.str.2 = private unnamed_addr constant [19 x i8] c"H1: \09Result = %ld\0A\00", align 1
@.str.3 = private unnamed_addr constant [15 x i8] c"H1: \09d4 = %ld\0A\00", align 1
@.str.4 = private unnamed_addr constant [21 x i8] c"CAT variables = %ld\0A\00", align 1
@.str.5 = private unnamed_addr constant [16 x i8] c"CAT cost = %ld\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local void @CAT_execution(i32 noundef %0) local_unnamed_addr #0 {
  %2 = call i8* @CAT_new(i64 noundef 5) #4
  %3 = call i64 @CAT_get(i8* noundef inttoptr (i64 5 to i8*)) #4
  %4 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([20 x i8], [20 x i8]* @.str, i64 0, i64 0), i64 noundef %3)
  %5 = icmp sgt i32 %0, 0
  call void @llvm.assume(i1 %5)
  %6 = icmp ugt i32 %0, 10
  %7 = icmp ugt i32 %0, 20
  br label %17

8:                                                ; preds = %27
  %.lcssa1 = phi i8* [ %24, %27 ]
  %.lcssa = phi i8* [ %25, %27 ]
  %9 = call i64 @CAT_get(i8* noundef %.lcssa) #4
  %10 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([15 x i8], [15 x i8]* @.str.3, i64 0, i64 0), i64 noundef %9)
  %11 = call i64 @CAT_get(i8* noundef %.lcssa1) #4
  %12 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([19 x i8], [19 x i8]* @.str.2, i64 0, i64 0), i64 noundef %11)
  call void @CAT_sub(i8* noundef %.lcssa1, i8* noundef %.lcssa1, i8* noundef %.lcssa1) #4
  %13 = call i64 @CAT_get(i8* noundef %.lcssa1) #4
  %14 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([19 x i8], [19 x i8]* @.str.2, i64 0, i64 0), i64 noundef %13)
  call void @CAT_set(i8* noundef %.lcssa1, i64 noundef 42) #4
  %15 = call i64 @CAT_get(i8* noundef %.lcssa1) #4
  %16 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([19 x i8], [19 x i8]* @.str.2, i64 0, i64 0), i64 noundef %15)
  ret void

17:                                               ; preds = %1, %27
  %18 = phi i32 [ 0, %1 ], [ %30, %27 ]
  %19 = call i8* @CAT_new(i64 noundef 8) #4
  br i1 %6, label %20, label %21

20:                                               ; preds = %17
  call void @CAT_add(i8* noundef %19, i8* noundef %19, i8* noundef %19) #4
  br label %21

21:                                               ; preds = %20, %17
  %22 = call i64 @CAT_get(i8* noundef %19) #4
  %23 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([20 x i8], [20 x i8]* @.str.1, i64 0, i64 0), i64 noundef %22)
  %24 = call i8* @CAT_new(i64 noundef 0) #4
  %25 = call i8* @CAT_new(i64 noundef 42) #4
  call void @CAT_add(i8* noundef %24, i8* noundef inttoptr (i64 5 to i8*), i8* noundef %19) #4
  call void @CAT_add(i8* noundef %24, i8* noundef inttoptr (i64 5 to i8*), i8* noundef %24) #4
  call void @CAT_add(i8* noundef %24, i8* noundef %24, i8* noundef %24) #4
  br i1 %7, label %26, label %27

26:                                               ; preds = %21
  call void @CAT_add(i8* noundef %24, i8* noundef inttoptr (i64 5 to i8*), i8* noundef inttoptr (i64 5 to i8*)) #4
  br label %27

27:                                               ; preds = %26, %21
  %28 = call i64 @CAT_get(i8* noundef %24) #4
  %29 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([19 x i8], [19 x i8]* @.str.2, i64 0, i64 0), i64 noundef %28)
  %30 = add nuw i32 %18, 1
  %31 = icmp eq i32 %30, %0
  br i1 %31, label %8, label %17, !llvm.loop !3
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

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 noundef %0, i8** nocapture noundef readnone %1) local_unnamed_addr #0 {
  call void @CAT_execution(i32 noundef %0)
  %3 = call i64 @CAT_variables() #4
  %4 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([21 x i8], [21 x i8]* @.str.4, i64 0, i64 0), i64 noundef %3)
  %5 = call i64 @CAT_cost() #4
  %6 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0), i64 noundef %5)
  ret i32 0
}

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_variables() local_unnamed_addr #1

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_cost() local_unnamed_addr #1

; Function Attrs: inaccessiblememonly nofree nosync nounwind willreturn
declare void @llvm.assume(i1 noundef) #3

attributes #0 = { nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { argmemonly nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { inaccessiblememonly nofree nosync nounwind willreturn }
attributes #4 = { argmemonly nounwind }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 1}
!2 = !{!"clang version 14.0.6"}
!3 = distinct !{!3, !4, !5}
!4 = !{!"llvm.loop.mustprogress"}
!5 = !{!"llvm.loop.unroll.disable"}
