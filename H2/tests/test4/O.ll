; ModuleID = 'program_optimized.bc'
source_filename = "program.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [21 x i8] c"CAT variables = %ld\0A\00", align 1
@.str.1 = private unnamed_addr constant [16 x i8] c"CAT cost = %ld\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local i32 @CAT_execution1() local_unnamed_addr #0 {
  %1 = call i8* @CAT_new(i64 noundef 5) #3
  %2 = call i8* @CAT_new(i64 noundef 8) #3
  %3 = call i8* @CAT_new(i64 noundef 0) #3
  call void @CAT_add(i8* noundef %3, i8* noundef inttoptr (i64 5 to i8*), i8* noundef inttoptr (i64 8 to i8*)) #3
  call void @CAT_sub(i8* noundef %3, i8* noundef %3, i8* noundef inttoptr (i64 5 to i8*)) #3
  call void @CAT_set(i8* noundef %1, i64 noundef 3) #3
  call void @CAT_destroy(i8* noundef %1) #3
  %4 = call i64 @CAT_get(i8* noundef %3) #3
  %5 = trunc i64 %4 to i32
  ret i32 %5
}

; Function Attrs: argmemonly nounwind
declare dso_local i8* @CAT_new(i64 noundef) local_unnamed_addr #1

; Function Attrs: argmemonly nounwind
declare dso_local void @CAT_add(i8* noundef, i8* noundef, i8* noundef) local_unnamed_addr #1

; Function Attrs: argmemonly nounwind
declare dso_local void @CAT_sub(i8* noundef, i8* noundef, i8* noundef) local_unnamed_addr #1

; Function Attrs: argmemonly nounwind
declare dso_local void @CAT_set(i8* noundef, i64 noundef) local_unnamed_addr #1

; Function Attrs: argmemonly nounwind
declare dso_local void @CAT_destroy(i8* noundef) local_unnamed_addr #1

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_get(i8* noundef) local_unnamed_addr #1

; Function Attrs: nounwind uwtable
define dso_local i32 @CAT_execution2() local_unnamed_addr #0 {
  %1 = call i8* @CAT_new(i64 noundef 5) #3
  %2 = call i64 @CAT_get(i8* noundef inttoptr (i64 5 to i8*)) #3
  %3 = trunc i64 %2 to i32
  ret i32 %3
}

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 noundef %0, i8** nocapture noundef readnone %1) local_unnamed_addr #0 {
  %3 = call i8* @CAT_new(i64 noundef 5) #3
  %4 = call i8* @CAT_new(i64 noundef 8) #3
  %5 = call i8* @CAT_new(i64 noundef 0) #3
  call void @CAT_add(i8* noundef %5, i8* noundef inttoptr (i64 5 to i8*), i8* noundef inttoptr (i64 8 to i8*)) #3
  call void @CAT_sub(i8* noundef %5, i8* noundef %5, i8* noundef inttoptr (i64 5 to i8*)) #3
  call void @CAT_set(i8* noundef %3, i64 noundef 3) #3
  call void @CAT_destroy(i8* noundef %3) #3
  %6 = call i64 @CAT_get(i8* noundef %5) #3
  %7 = call i8* @CAT_new(i64 noundef 5) #3
  %8 = call i64 @CAT_get(i8* noundef inttoptr (i64 5 to i8*)) #3
  %9 = call i64 @CAT_variables() #3
  %10 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([21 x i8], [21 x i8]* @.str, i64 0, i64 0), i64 noundef %9)
  %11 = call i64 @CAT_cost() #3
  %12 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @.str.1, i64 0, i64 0), i64 noundef %11)
  ret i32 0
}

; Function Attrs: nofree nounwind
declare dso_local noundef i32 @printf(i8* nocapture noundef readonly, ...) local_unnamed_addr #2

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
