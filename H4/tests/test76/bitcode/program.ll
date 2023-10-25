; ModuleID = 'program.bc'
source_filename = "program.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [9 x i8] c"Z2: %ld\0A\00", align 1
@.str.1 = private unnamed_addr constant [21 x i8] c"CAT variables = %ld\0A\00", align 1
@.str.2 = private unnamed_addr constant [16 x i8] c"CAT cost = %ld\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 noundef %0, i8** nocapture noundef readnone %1) local_unnamed_addr #0 {
  %3 = call i8* @CAT_new(i64 noundef 40) #4
  %4 = call i8* @CAT_new(i64 noundef 2) #4
  %5 = call i8* @CAT_new(i64 noundef 0) #4
  br label %11

6:                                                ; preds = %15
  %7 = call i64 @CAT_variables() #4
  %8 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([21 x i8], [21 x i8]* @.str.1, i64 0, i64 0), i64 noundef %7)
  %9 = call i64 @CAT_cost() #4
  %10 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @.str.2, i64 0, i64 0), i64 noundef %9)
  ret i32 0

11:                                               ; preds = %2, %15
  %12 = phi i32 [ 0, %2 ], [ %16, %15 ]
  %13 = phi i8* [ %5, %2 ], [ %28, %15 ]
  call void @CAT_add(i8* noundef %13, i8* noundef %3, i8* noundef %4) #4
  call void @CAT_add(i8* noundef %3, i8* noundef %3, i8* noundef %3) #4
  call void @CAT_add(i8* noundef %4, i8* noundef %4, i8* noundef %4) #4
  %14 = call i8* @CAT_new(i64 noundef 1) #4
  br label %18

15:                                               ; preds = %27
  %16 = add nuw nsw i32 %12, 1
  %17 = icmp eq i32 %16, 10
  br i1 %17, label %6, label %11, !llvm.loop !3

18:                                               ; preds = %11, %27
  %19 = phi i32 [ 0, %11 ], [ %29, %27 ]
  %20 = phi i8* [ %14, %11 ], [ %28, %27 ]
  %21 = call i64 @CAT_get(i8* noundef %20) #4
  %22 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @.str, i64 0, i64 0), i64 noundef %21)
  call void @CAT_add(i8* noundef %20, i8* noundef %3, i8* noundef %4) #4
  call void @CAT_add(i8* noundef %3, i8* noundef %3, i8* noundef %3) #4
  call void @CAT_add(i8* noundef %4, i8* noundef %4, i8* noundef %4) #4
  %23 = call i32 @rand() #5
  %24 = icmp slt i32 %23, 0
  br i1 %24, label %25, label %27

25:                                               ; preds = %18
  %26 = call i8* @CAT_new(i64 noundef 1) #4
  br label %27

27:                                               ; preds = %18, %25
  %28 = phi i8* [ %26, %25 ], [ %20, %18 ]
  %29 = add nuw nsw i32 %19, 1
  %30 = icmp eq i32 %29, 10
  br i1 %30, label %15, label %18, !llvm.loop !6
}

; Function Attrs: argmemonly nounwind
declare dso_local i8* @CAT_new(i64 noundef) local_unnamed_addr #1

; Function Attrs: argmemonly nounwind
declare dso_local void @CAT_add(i8* noundef, i8* noundef, i8* noundef) local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare dso_local noundef i32 @printf(i8* nocapture noundef readonly, ...) local_unnamed_addr #2

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_get(i8* noundef) local_unnamed_addr #1

; Function Attrs: nounwind
declare dso_local i32 @rand() local_unnamed_addr #3

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_variables() local_unnamed_addr #1

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_cost() local_unnamed_addr #1

attributes #0 = { nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { argmemonly nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
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
!6 = distinct !{!6, !4, !5}
