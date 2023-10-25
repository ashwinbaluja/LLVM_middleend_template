; ModuleID = 'program.bc'
source_filename = "program.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [9 x i8] c"L1: %ld\0A\00", align 1
@.str.1 = private unnamed_addr constant [9 x i8] c"L2: %ld\0A\00", align 1
@.str.2 = private unnamed_addr constant [16 x i8] c"Result = %d\0A\0A\0A\0A\00", align 1
@.str.3 = private unnamed_addr constant [21 x i8] c"CAT variables = %ld\0A\00", align 1
@.str.4 = private unnamed_addr constant [16 x i8] c"CAT cost = %ld\0A\00", align 1

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone uwtable willreturn
define dso_local i8* @myF(i8* noundef readnone returned %0) local_unnamed_addr #0 {
  ret i8* %0
}

; Function Attrs: nounwind uwtable
define dso_local void @computeF() local_unnamed_addr #1 {
  %1 = call i8* @CAT_new(i64 noundef 4) #4
  %2 = call i8* @CAT_new(i64 noundef 42) #4
  %3 = call i64 @CAT_get(i8* noundef %1) #4
  %4 = trunc i64 %3 to i32
  %5 = icmp sgt i32 %4, 9
  br i1 %5, label %6, label %9

6:                                                ; preds = %0
  %7 = call i64 @CAT_get(i8* noundef %1) #4
  %8 = call i8* @CAT_new(i64 noundef %7) #4
  br label %13

9:                                                ; preds = %0
  %10 = call i8* @CAT_new(i64 noundef 5) #4
  %11 = call i64 @CAT_get(i8* noundef %10) #4
  %12 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @.str, i64 0, i64 0), i64 noundef %11)
  br label %13

13:                                               ; preds = %9, %6
  %14 = phi i8* [ %8, %6 ], [ %10, %9 ]
  call void @CAT_add(i8* noundef %1, i8* noundef %1, i8* noundef %14) #4
  %15 = call i64 @CAT_get(i8* noundef %2) #4
  br label %16

16:                                               ; preds = %34, %13
  %17 = phi i32 [ 0, %13 ], [ %35, %34 ]
  %18 = call i64 @CAT_get(i8* noundef %1) #4
  %19 = trunc i64 %18 to i32
  %20 = icmp sgt i32 %19, 9
  br i1 %20, label %21, label %24

21:                                               ; preds = %16
  %22 = call i64 @CAT_get(i8* noundef %1) #4
  %23 = call i8* @CAT_new(i64 noundef %22) #4
  br label %28

24:                                               ; preds = %16
  %25 = call i8* @CAT_new(i64 noundef 5) #4
  %26 = call i64 @CAT_get(i8* noundef %25) #4
  %27 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @.str.1, i64 0, i64 0), i64 noundef %26)
  br label %28

28:                                               ; preds = %21, %24
  %29 = phi i8* [ %23, %21 ], [ %25, %24 ]
  call void @CAT_add(i8* noundef %1, i8* noundef %1, i8* noundef %29) #4
  %30 = call i64 @CAT_get(i8* noundef %2) #4
  %31 = icmp eq i32 %17, 0
  br i1 %31, label %32, label %34

32:                                               ; preds = %28
  %33 = call i8* @CAT_new(i64 noundef 125) #4
  br label %34

34:                                               ; preds = %32, %28
  %35 = add nuw nsw i32 %17, 1
  %36 = icmp eq i32 %35, 10
  br i1 %36, label %37, label %16, !llvm.loop !3

37:                                               ; preds = %34
  %38 = trunc i64 %30 to i32
  %39 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @.str.2, i64 0, i64 0), i32 noundef %38)
  ret void
}

; Function Attrs: argmemonly nounwind
declare dso_local i8* @CAT_new(i64 noundef) local_unnamed_addr #2

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_get(i8* noundef) local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare dso_local noundef i32 @printf(i8* nocapture noundef readonly, ...) local_unnamed_addr #3

; Function Attrs: argmemonly nounwind
declare dso_local void @CAT_add(i8* noundef, i8* noundef, i8* noundef) local_unnamed_addr #2

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 noundef %0, i8** nocapture noundef readnone %1) local_unnamed_addr #1 {
  call void @computeF()
  %3 = call i8* @CAT_new(i64 noundef 52) #4
  call void @CAT_add(i8* noundef %3, i8* noundef %3, i8* noundef %3) #4
  call void @CAT_sub(i8* noundef %3, i8* noundef %3, i8* noundef %3) #4
  call void @CAT_set(i8* noundef %3, i64 noundef 42) #4
  %4 = call i64 @CAT_variables() #4
  %5 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([21 x i8], [21 x i8]* @.str.3, i64 0, i64 0), i64 noundef %4)
  %6 = call i64 @CAT_cost() #4
  %7 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @.str.4, i64 0, i64 0), i64 noundef %6)
  ret i32 0
}

; Function Attrs: argmemonly nounwind
declare dso_local void @CAT_sub(i8* noundef, i8* noundef, i8* noundef) local_unnamed_addr #2

; Function Attrs: argmemonly nounwind
declare dso_local void @CAT_set(i8* noundef, i64 noundef) local_unnamed_addr #2

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_variables() local_unnamed_addr #2

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_cost() local_unnamed_addr #2

attributes #0 = { mustprogress nofree norecurse nosync nounwind readnone uwtable willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { argmemonly nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { argmemonly nounwind }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 1}
!2 = !{!"clang version 14.0.6 (git@github.com:scampanoni/LLVM_installer.git fc6ceabb24f6c857bd1637c9b94cd4edf7b2669f)"}
!3 = distinct !{!3, !4, !5}
!4 = !{!"llvm.loop.mustprogress"}
!5 = !{!"llvm.loop.unroll.disable"}
