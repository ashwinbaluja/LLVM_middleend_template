; ModuleID = 'output_code_iter_1.bc'
source_filename = "program.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"%ld\0A\00", align 1
@.str.1 = private unnamed_addr constant [21 x i8] c"CAT variables = %ld\0A\00", align 1
@.str.2 = private unnamed_addr constant [16 x i8] c"CAT cost = %ld\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local void @p(i64 noundef %0, i8* noundef %1) local_unnamed_addr #0 {
  %3 = icmp eq i64 %0, 0
  br i1 %3, label %4, label %6

4:                                                ; preds = %2
  %5 = call i8* @CAT_new(i64 noundef 1) #3
  call void @CAT_add(i8* noundef %1, i8* noundef %1, i8* noundef %5) #3
  br label %10

6:                                                ; preds = %2
  %7 = add i64 %0, 5
  %8 = call i8* @CAT_new(i64 noundef %7) #3
  call void @CAT_add(i8* noundef %1, i8* noundef %1, i8* noundef %8) #3
  %9 = add i64 %0, -1
  call void @p(i64 noundef %9, i8* noundef %1)
  br label %10

10:                                               ; preds = %6, %4
  ret void
}

; Function Attrs: argmemonly nounwind
declare dso_local void @CAT_add(i8* noundef, i8* noundef, i8* noundef) local_unnamed_addr #1

; Function Attrs: argmemonly nounwind
declare dso_local i8* @CAT_new(i64 noundef) local_unnamed_addr #1

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 noundef %0, i8** nocapture noundef readnone %1) local_unnamed_addr #0 {
  %3 = call i8* @CAT_new(i64 noundef 7) #3
  br label %10

4:                                                ; preds = %10
  %5 = call i8* @CAT_new(i64 noundef 52) #3
  call void @CAT_set(i8* %5, i64 104)
  call void @CAT_set(i8* %5, i64 0)
  call void @CAT_set(i8* noundef %5, i64 noundef 42) #3
  %6 = call i64 @CAT_variables() #3
  %7 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([21 x i8], [21 x i8]* @.str.1, i64 0, i64 0), i64 noundef %6)
  %8 = call i64 @CAT_cost() #3
  %9 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @.str.2, i64 0, i64 0), i64 noundef %8)
  ret i32 0

10:                                               ; preds = %2, %10
  %11 = phi i64 [ 1, %2 ], [ %14, %10 ]
  call void @p(i64 noundef %11, i8* noundef %3)
  %12 = call i64 @CAT_get(i8* noundef %3) #3
  %13 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i64 0, i64 0), i64 noundef %12)
  %14 = add nuw nsw i64 %11, 1
  %15 = icmp eq i64 %14, 6
  br i1 %15, label %4, label %10, !llvm.loop !3
}

; Function Attrs: nofree nounwind
declare dso_local noundef i32 @printf(i8* nocapture noundef readonly, ...) local_unnamed_addr #2

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_get(i8* noundef) local_unnamed_addr #1

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