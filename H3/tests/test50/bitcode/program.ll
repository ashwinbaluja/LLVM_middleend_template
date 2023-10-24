; ModuleID = 'program.bc'
source_filename = "program.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [8 x i8] c"Z: %ld\0A\00", align 1
@.str.1 = private unnamed_addr constant [21 x i8] c"CAT variables = %ld\0A\00", align 1
@.str.2 = private unnamed_addr constant [16 x i8] c"CAT cost = %ld\0A\00", align 1

; Function Attrs: mustprogress nofree norecurse nosync nounwind uwtable willreturn
define dso_local void @myF(i32* nocapture noundef %0) local_unnamed_addr #0 {
  %2 = load i32, i32* %0, align 4, !tbaa !3
  %3 = icmp sgt i32 %2, 500
  br i1 %3, label %4, label %5

4:                                                ; preds = %1
  store i32 500, i32* %0, align 4, !tbaa !3
  br label %5

5:                                                ; preds = %4, %1
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 noundef %0, i8** nocapture noundef readnone %1) local_unnamed_addr #1 {
  %3 = call i8* @CAT_new(i64 noundef 40) #4
  %4 = call i8* @CAT_new(i64 noundef 2) #4
  %5 = call i8* @CAT_new(i64 noundef 0) #4
  %6 = shl i32 %0, 1
  %7 = add i32 %6, 2
  %8 = icmp sgt i32 %7, 0
  br i1 %8, label %15, label %9

9:                                                ; preds = %15, %2
  %10 = call i8* @CAT_new(i64 noundef 52) #4
  call void @CAT_add(i8* noundef %10, i8* noundef %10, i8* noundef %10) #4
  call void @CAT_sub(i8* noundef %10, i8* noundef %10, i8* noundef %10) #4
  call void @CAT_set(i8* noundef %10, i64 noundef 42) #4
  %11 = call i64 @CAT_variables() #4
  %12 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([21 x i8], [21 x i8]* @.str.1, i64 0, i64 0), i64 noundef %11)
  %13 = call i64 @CAT_cost() #4
  %14 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @.str.2, i64 0, i64 0), i64 noundef %13)
  ret i32 0

15:                                               ; preds = %2, %15
  %16 = phi i8* [ %25, %15 ], [ %5, %2 ]
  %17 = phi i32 [ %26, %15 ], [ 0, %2 ]
  %18 = phi i32 [ %20, %15 ], [ %0, %2 ]
  %19 = icmp slt i32 %18, 500
  %20 = select i1 %19, i32 %18, i32 500
  %21 = call i64 @CAT_get(i8* noundef %16) #4
  %22 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i64 0, i64 0), i64 noundef %21)
  call void @CAT_add(i8* noundef %16, i8* noundef %3, i8* noundef %4) #4
  %23 = call i64 @CAT_get(i8* noundef %16) #4
  %24 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i64 0, i64 0), i64 noundef %23)
  call void @CAT_add(i8* noundef %3, i8* noundef %3, i8* noundef %3) #4
  call void @CAT_add(i8* noundef %4, i8* noundef %4, i8* noundef %4) #4
  %25 = call i8* @CAT_new(i64 noundef 1) #4
  %26 = add nuw nsw i32 %17, 1
  %27 = shl i32 %20, 1
  %28 = add i32 %27, 2
  %29 = icmp slt i32 %26, %28
  br i1 %29, label %15, label %9, !llvm.loop !7
}

; Function Attrs: argmemonly nounwind
declare dso_local i8* @CAT_new(i64 noundef) local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare dso_local noundef i32 @printf(i8* nocapture noundef readonly, ...) local_unnamed_addr #3

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_get(i8* noundef) local_unnamed_addr #2

; Function Attrs: argmemonly nounwind
declare dso_local void @CAT_add(i8* noundef, i8* noundef, i8* noundef) local_unnamed_addr #2

; Function Attrs: argmemonly nounwind
declare dso_local void @CAT_sub(i8* noundef, i8* noundef, i8* noundef) local_unnamed_addr #2

; Function Attrs: argmemonly nounwind
declare dso_local void @CAT_set(i8* noundef, i64 noundef) local_unnamed_addr #2

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_variables() local_unnamed_addr #2

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_cost() local_unnamed_addr #2

attributes #0 = { mustprogress nofree norecurse nosync nounwind uwtable willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { argmemonly nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { argmemonly nounwind }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 1}
!2 = !{!"clang version 14.0.6 (git@github.com:scampanoni/LLVM_installer.git fc6ceabb24f6c857bd1637c9b94cd4edf7b2669f)"}
!3 = !{!4, !4, i64 0}
!4 = !{!"int", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}
!7 = distinct !{!7, !8, !9}
!8 = !{!"llvm.loop.mustprogress"}
!9 = !{!"llvm.loop.unroll.disable"}