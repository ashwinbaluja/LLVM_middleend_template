; ModuleID = 'program_optimized.bc'
source_filename = "program.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [13 x i8] c"%ld %ld %ld\0A\00", align 1
@.str.1 = private unnamed_addr constant [21 x i8] c"CAT variables = %ld\0A\00", align 1
@.str.2 = private unnamed_addr constant [16 x i8] c"CAT cost = %ld\0A\00", align 1

; Function Attrs: nofree nosync nounwind readnone uwtable
define dso_local i8* @p(i32 noundef %0) local_unnamed_addr #0 {
  %2 = icmp sgt i32 %0, 10
  %3 = select i1 %2, i64 5, i64 6
  %4 = call i8* @CAT_new(i64 noundef %3) #4
  ret i8* %4
}

; Function Attrs: argmemonly nounwind
declare dso_local i8* @CAT_new(i64 noundef) local_unnamed_addr #1

; Function Attrs: nofree nosync nounwind readnone uwtable
define dso_local i8* @q1(i32 %0) local_unnamed_addr #0 {
  %2 = call i8* @CAT_new(i64 noundef 6) #4
  ret i8* %2
}

; Function Attrs: nofree nosync nounwind readnone uwtable
define dso_local i8* @q2(i32 noundef %0) local_unnamed_addr #0 {
  %2 = icmp sgt i32 %0, 2
  %3 = select i1 %2, i64 5, i64 6
  %4 = call i8* @CAT_new(i64 noundef %3) #4
  ret i8* %4
}

; Function Attrs: nofree nosync nounwind readnone uwtable
define dso_local i8* @q3(i32 noundef %0) local_unnamed_addr #0 {
  %2 = icmp sgt i32 %0, 9
  %3 = select i1 %2, i64 5, i64 6
  %4 = call i8* @CAT_new(i64 noundef %3) #4
  ret i8* %4
}

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 noundef %0, i8** nocapture noundef readnone %1) local_unnamed_addr #2 {
  %3 = call i8* @CAT_new(i64 noundef 6) #4
  %4 = call i8* @CAT_new(i64 noundef 5) #4
  %5 = call i8* @CAT_new(i64 noundef 6) #4
  %6 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([13 x i8], [13 x i8]* @.str, i64 0, i64 0), i64 noundef 6, i64 noundef 5, i64 noundef 6)
  %7 = call i8* @CAT_new(i64 noundef 52) #4
  call void @CAT_set(i8* %7, i64 104)
  call void @CAT_set(i8* %7, i64 0)
  call void @CAT_set(i8* noundef %7, i64 noundef 42) #4
  %8 = call i64 @CAT_variables() #4
  %9 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([21 x i8], [21 x i8]* @.str.1, i64 0, i64 0), i64 noundef %8)
  %10 = call i64 @CAT_cost() #4
  %11 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @.str.2, i64 0, i64 0), i64 noundef %10)
  ret i32 0
}

; Function Attrs: nofree nounwind
declare dso_local noundef i32 @printf(i8* nocapture noundef readonly, ...) local_unnamed_addr #3

; Function Attrs: argmemonly nounwind
declare dso_local void @CAT_set(i8* noundef, i64 noundef) local_unnamed_addr #1

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_variables() local_unnamed_addr #1

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_cost() local_unnamed_addr #1

attributes #0 = { nofree nosync nounwind readnone uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { argmemonly nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { argmemonly nounwind }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 1}
!2 = !{!"clang version 14.0.6 (git@github.com:scampanoni/LLVM_installer.git fc6ceabb24f6c857bd1637c9b94cd4edf7b2669f)"}
