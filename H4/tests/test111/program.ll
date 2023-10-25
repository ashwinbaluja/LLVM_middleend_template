; ModuleID = 'program.bc'
source_filename = "program.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [21 x i8] c"H5: \09Value of = %ld\0A\00", align 1
@.str.1 = private unnamed_addr constant [21 x i8] c"CAT variables = %ld\0A\00", align 1
@.str.2 = private unnamed_addr constant [16 x i8] c"CAT cost = %ld\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local void @f(i8** nocapture noundef readonly %0) local_unnamed_addr #0 {
  %2 = load i8*, i8** %0, align 8, !tbaa !3
  call void @CAT_set(i8* noundef %2, i64 noundef 5) #5
  %3 = load i8*, i8** %0, align 8, !tbaa !3
  call void @CAT_add(i8* noundef %3, i8* noundef %3, i8* noundef %3) #5
  %4 = load i8*, i8** %0, align 8, !tbaa !3
  call void @CAT_sub(i8* noundef %4, i8* noundef %4, i8* noundef %4) #5
  ret void
}

; Function Attrs: argmemonly nounwind
declare dso_local void @CAT_set(i8* noundef, i64 noundef) local_unnamed_addr #1

; Function Attrs: argmemonly nounwind
declare dso_local void @CAT_add(i8* noundef, i8* noundef, i8* noundef) local_unnamed_addr #1

; Function Attrs: argmemonly nounwind
declare dso_local void @CAT_sub(i8* noundef, i8* noundef, i8* noundef) local_unnamed_addr #1

; Function Attrs: nounwind uwtable
define dso_local void @a_generic_C_function(i32 noundef %0) local_unnamed_addr #0 {
  %2 = call i8* @CAT_new(i64 noundef 5) #5
  %3 = call i8* @CAT_new(i64 noundef 3) #5
  %4 = call i32 @rand() #6
  %5 = sitofp i32 %4 to double
  %6 = call double @sqrt(double noundef %5) #6
  %7 = sitofp i32 %0 to double
  %8 = call double @sqrt(double noundef %7) #6
  %9 = fcmp olt double %6, %8
  %10 = select i1 %9, i8* %2, i8* %3
  call void @CAT_set(i8* noundef %10, i64 noundef 5) #5
  call void @CAT_add(i8* noundef %10, i8* noundef %10, i8* noundef %10) #5
  call void @CAT_sub(i8* noundef %10, i8* noundef %10, i8* noundef %10) #5
  %11 = call i64 @CAT_get(i8* noundef %2) #5
  %12 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([21 x i8], [21 x i8]* @.str, i64 0, i64 0), i64 noundef %11)
  ret void
}

; Function Attrs: argmemonly nounwind
declare dso_local i8* @CAT_new(i64 noundef) local_unnamed_addr #1

; Function Attrs: mustprogress nofree nounwind willreturn writeonly
declare dso_local double @sqrt(double noundef) local_unnamed_addr #2

; Function Attrs: nounwind
declare dso_local i32 @rand() local_unnamed_addr #3

; Function Attrs: nofree nounwind
declare dso_local noundef i32 @printf(i8* nocapture noundef readonly, ...) local_unnamed_addr #4

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_get(i8* noundef) local_unnamed_addr #1

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 noundef %0, i8** nocapture noundef readnone %1) local_unnamed_addr #0 {
  %3 = call i8* @CAT_new(i64 noundef 5) #5
  %4 = call i8* @CAT_new(i64 noundef 3) #5
  %5 = call i32 @rand() #6
  %6 = sitofp i32 %5 to double
  %7 = call double @sqrt(double noundef %6) #6
  %8 = sitofp i32 %0 to double
  %9 = call double @sqrt(double noundef %8) #6
  %10 = fcmp olt double %7, %9
  %11 = select i1 %10, i8* %3, i8* %4
  call void @CAT_set(i8* noundef %11, i64 noundef 5) #5
  call void @CAT_add(i8* noundef %11, i8* noundef %11, i8* noundef %11) #5
  call void @CAT_sub(i8* noundef %11, i8* noundef %11, i8* noundef %11) #5
  %12 = call i64 @CAT_get(i8* noundef %3) #5
  %13 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([21 x i8], [21 x i8]* @.str, i64 0, i64 0), i64 noundef %12) #6
  %14 = call i64 @CAT_variables() #5
  %15 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([21 x i8], [21 x i8]* @.str.1, i64 0, i64 0), i64 noundef %14)
  %16 = call i64 @CAT_cost() #5
  %17 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @.str.2, i64 0, i64 0), i64 noundef %16)
  ret i32 0
}

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_variables() local_unnamed_addr #1

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_cost() local_unnamed_addr #1

attributes #0 = { nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { argmemonly nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { mustprogress nofree nounwind willreturn writeonly "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nofree nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { argmemonly nounwind }
attributes #6 = { nounwind }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 1}
!2 = !{!"clang version 14.0.6 (git@github.com:scampanoni/LLVM_installer.git fc6ceabb24f6c857bd1637c9b94cd4edf7b2669f)"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}
