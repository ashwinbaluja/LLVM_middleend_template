; ModuleID = 'program.bc'
source_filename = "program.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [27 x i8] c"Before loop: \09Value = %ld\0A\00", align 1
@.str.1 = private unnamed_addr constant [29 x i8] c"After loop:\09Value = %ld, %f\0A\00", align 1
@.str.2 = private unnamed_addr constant [21 x i8] c"CAT variables = %ld\0A\00", align 1
@.str.3 = private unnamed_addr constant [16 x i8] c"CAT cost = %ld\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local void @CAT_execution(i32 noundef %0) local_unnamed_addr #0 {
  %2 = call i8* @CAT_new(i64 noundef 5) #4
  %3 = call i64 @CAT_get(i8* noundef %2) #4
  %4 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([27 x i8], [27 x i8]* @.str, i64 0, i64 0), i64 noundef %3)
  %5 = icmp sgt i32 %0, 0
  br i1 %5, label %10, label %6

6:                                                ; preds = %10, %1
  %7 = phi double [ 0x40E98E8DC0000000, %1 ], [ %13, %10 ]
  %8 = call i64 @CAT_get(i8* noundef %2) #4
  %9 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([29 x i8], [29 x i8]* @.str.1, i64 0, i64 0), i64 noundef %8, double noundef %7)
  ret void

10:                                               ; preds = %1, %10
  %11 = phi i32 [ %14, %10 ], [ 0, %1 ]
  %12 = phi double [ %13, %10 ], [ 0x40E98E8DC0000000, %1 ]
  %13 = call double @sqrt(double noundef %12) #5
  %14 = add nuw nsw i32 %11, 1
  %15 = icmp eq i32 %14, %0
  br i1 %15, label %6, label %10, !llvm.loop !3
}

; Function Attrs: argmemonly nounwind
declare dso_local i8* @CAT_new(i64 noundef) local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare dso_local noundef i32 @printf(i8* nocapture noundef readonly, ...) local_unnamed_addr #2

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_get(i8* noundef) local_unnamed_addr #1

; Function Attrs: mustprogress nofree nounwind willreturn writeonly
declare dso_local double @sqrt(double noundef) local_unnamed_addr #3

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 noundef %0, i8** nocapture noundef readnone %1) local_unnamed_addr #0 {
  %3 = call i8* @CAT_new(i64 noundef 5) #4
  %4 = call i64 @CAT_get(i8* noundef %3) #4
  %5 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([27 x i8], [27 x i8]* @.str, i64 0, i64 0), i64 noundef %4) #5
  %6 = icmp sgt i32 %0, -10
  br i1 %6, label %7, label %15

7:                                                ; preds = %2
  %8 = add nsw i32 %0, 9
  br label %9

9:                                                ; preds = %7, %9
  %10 = phi i32 [ %13, %9 ], [ 0, %7 ]
  %11 = phi double [ %12, %9 ], [ 0x40E98E8DC0000000, %7 ]
  %12 = call double @sqrt(double noundef %11) #5
  %13 = add nuw nsw i32 %10, 1
  %14 = icmp eq i32 %10, %8
  br i1 %14, label %15, label %9, !llvm.loop !3

15:                                               ; preds = %9, %2
  %16 = phi double [ 0x40E98E8DC0000000, %2 ], [ %12, %9 ]
  %17 = call i64 @CAT_get(i8* noundef %3) #4
  %18 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([29 x i8], [29 x i8]* @.str.1, i64 0, i64 0), i64 noundef %17, double noundef %16) #5
  %19 = call i8* @CAT_new(i64 noundef 52) #4
  call void @CAT_add(i8* noundef %19, i8* noundef %19, i8* noundef %19) #4
  call void @CAT_sub(i8* noundef %19, i8* noundef %19, i8* noundef %19) #4
  call void @CAT_set(i8* noundef %19, i64 noundef 42) #4
  %20 = call i64 @CAT_variables() #4
  %21 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([21 x i8], [21 x i8]* @.str.2, i64 0, i64 0), i64 noundef %20)
  %22 = call i64 @CAT_cost() #4
  %23 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @.str.3, i64 0, i64 0), i64 noundef %22)
  ret i32 0
}

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

attributes #0 = { nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { argmemonly nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nofree nounwind willreturn writeonly "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
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
