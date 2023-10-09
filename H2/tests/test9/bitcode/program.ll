; ModuleID = 'program.bc'
source_filename = "program.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [20 x i8] c"H1: \09Value 1 = %ld\0A\00", align 1
@.str.1 = private unnamed_addr constant [20 x i8] c"H1: \09Value 2 = %ld\0A\00", align 1
@.str.2 = private unnamed_addr constant [19 x i8] c"H1: \09Result = %ld\0A\00", align 1
@.str.3 = private unnamed_addr constant [21 x i8] c"CAT variables = %ld\0A\00", align 1
@.str.4 = private unnamed_addr constant [16 x i8] c"CAT cost = %ld\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local void @CAT_execution(i32 noundef %0) local_unnamed_addr #0 {
  %2 = call i8* @CAT_new(i64 noundef 5) #3
  %3 = call i64 @CAT_get(i8* noundef %2) #3
  %4 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([20 x i8], [20 x i8]* @.str, i64 0, i64 0), i64 noundef %3)
  %5 = call i8* @CAT_new(i64 noundef 8) #3
  %6 = icmp sgt i32 %0, 10
  br i1 %6, label %7, label %8

7:                                                ; preds = %1
  call void @CAT_add(i8* noundef %5, i8* noundef %5, i8* noundef %5) #3
  br label %8

8:                                                ; preds = %7, %1
  %9 = call i64 @CAT_get(i8* noundef %5) #3
  %10 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([20 x i8], [20 x i8]* @.str.1, i64 0, i64 0), i64 noundef %9)
  %11 = call i8* @CAT_new(i64 noundef 0) #3
  call void @CAT_add(i8* noundef %11, i8* noundef %2, i8* noundef %5) #3
  call void @CAT_add(i8* noundef %11, i8* noundef %2, i8* noundef %11) #3
  call void @CAT_add(i8* noundef %11, i8* noundef %11, i8* noundef %11) #3
  call void @CAT_add(i8* noundef %11, i8* noundef %2, i8* noundef %2) #3
  %12 = call i64 @CAT_get(i8* noundef %11) #3
  %13 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([19 x i8], [19 x i8]* @.str.2, i64 0, i64 0), i64 noundef %12)
  call void @CAT_sub(i8* noundef %11, i8* noundef %11, i8* noundef %2) #3
  %14 = call i64 @CAT_get(i8* noundef %11) #3
  %15 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([19 x i8], [19 x i8]* @.str.2, i64 0, i64 0), i64 noundef %14)
  call void @CAT_set(i8* noundef %11, i64 noundef 42) #3
  %16 = call i64 @CAT_get(i8* noundef %11) #3
  %17 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([19 x i8], [19 x i8]* @.str.2, i64 0, i64 0), i64 noundef %16)
  ret void
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
