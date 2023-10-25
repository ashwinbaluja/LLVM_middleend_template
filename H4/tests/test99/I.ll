; ModuleID = 'output_code_iter_1.bc'
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
  %3 = call i8* @CAT_new(i64 noundef 5) #4
  %4 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @.str, i64 0, i64 0), i64 noundef 5)
  call void @CAT_set(i8* %1, i64 9)
  br label %5

5:                                                ; preds = %21, %0
  %6 = phi i32 [ 0, %0 ], [ %22, %21 ]
  %7 = call i64 @CAT_get(i8* noundef %1) #4
  %8 = trunc i64 %7 to i32
  %9 = icmp sgt i32 %8, 9
  br i1 %9, label %10, label %13

10:                                               ; preds = %5
  %11 = call i64 @CAT_get(i8* noundef %1) #4
  %12 = call i8* @CAT_new(i64 noundef %11) #4
  br label %16

13:                                               ; preds = %5
  %14 = call i8* @CAT_new(i64 noundef 5) #4
  %15 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @.str.1, i64 0, i64 0), i64 noundef 5)
  br label %16

16:                                               ; preds = %10, %13
  %17 = phi i8* [ %12, %10 ], [ %14, %13 ]
  call void @CAT_add(i8* noundef %1, i8* noundef %1, i8* noundef %17) #4
  %18 = icmp eq i32 %6, 0
  br i1 %18, label %19, label %21

19:                                               ; preds = %16
  %20 = call i8* @CAT_new(i64 noundef 125) #4
  br label %21

21:                                               ; preds = %19, %16
  %22 = add nuw nsw i32 %6, 1
  %23 = icmp eq i32 %22, 10
  br i1 %23, label %24, label %5, !llvm.loop !3

24:                                               ; preds = %21
  %25 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @.str.2, i64 0, i64 0), i32 noundef 42)
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
  call void @CAT_set(i8* %3, i64 104)
  call void @CAT_set(i8* %3, i64 0)
  call void @CAT_set(i8* noundef %3, i64 noundef 42) #4
  %4 = call i64 @CAT_variables() #4
  %5 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([21 x i8], [21 x i8]* @.str.3, i64 0, i64 0), i64 noundef %4)
  %6 = call i64 @CAT_cost() #4
  %7 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @.str.4, i64 0, i64 0), i64 noundef %6)
  ret i32 0
}

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
