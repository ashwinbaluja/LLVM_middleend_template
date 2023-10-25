; ModuleID = 'program_optimized.bc'
source_filename = "program.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"ciao\00", align 1
@.str.1 = private unnamed_addr constant [5 x i8] c"%ld\0A\00", align 1
@.str.2 = private unnamed_addr constant [21 x i8] c"CAT variables = %ld\0A\00", align 1
@.str.3 = private unnamed_addr constant [16 x i8] c"CAT cost = %ld\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 noundef %0, i8** nocapture noundef readonly %1) local_unnamed_addr #0 {
  %3 = call i8* @CAT_new(i64 noundef 1) #4
  %4 = call i8* @CAT_new(i64 noundef 1) #4
  %5 = call i8* @CAT_new(i64 noundef 1) #4
  %6 = call i8* @CAT_new(i64 noundef 1) #4
  %7 = icmp sgt i32 %0, 100
  br i1 %7, label %8, label %14

8:                                                ; preds = %2
  %9 = getelementptr inbounds i8*, i8** %1, i64 80
  %10 = load i8*, i8** %9, align 8, !tbaa !3
  %11 = call i32 @strcmp(i8* noundef nonnull dereferenceable(1) %10, i8* noundef nonnull dereferenceable(5) getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i64 0, i64 0)) #5
  %12 = icmp eq i32 %11, 0
  %13 = select i1 %12, i8* %3, i8* %4
  br label %17

14:                                               ; preds = %2
  %15 = icmp sgt i32 %0, 10
  %16 = select i1 %15, i8* %5, i8* %6
  br label %17

17:                                               ; preds = %14, %8
  %18 = phi i8* [ %13, %8 ], [ %16, %14 ]
  %19 = call i64 @CAT_get(i8* noundef %18) #4
  %20 = call i8* @CAT_new(i64 noundef %19) #4
  %21 = call i64 @CAT_get(i8* noundef %20) #4
  %22 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i64 0, i64 0), i64 noundef %21)
  call void @CAT_add(i8* noundef %20, i8* noundef %20, i8* noundef %20) #4
  call void @CAT_sub(i8* noundef %20, i8* noundef %20, i8* noundef %20) #4
  call void @CAT_set(i8* noundef %20, i64 noundef 42) #4
  %23 = call i64 @CAT_variables() #4
  %24 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([21 x i8], [21 x i8]* @.str.2, i64 0, i64 0), i64 noundef %23)
  %25 = call i64 @CAT_cost() #4
  %26 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @.str.3, i64 0, i64 0), i64 noundef %25)
  ret i32 0
}

; Function Attrs: argmemonly nounwind
declare dso_local i8* @CAT_new(i64 noundef) local_unnamed_addr #1

; Function Attrs: argmemonly mustprogress nofree nounwind readonly willreturn
declare dso_local i32 @strcmp(i8* nocapture noundef, i8* nocapture noundef) local_unnamed_addr #2

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_get(i8* noundef) local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare dso_local noundef i32 @printf(i8* nocapture noundef readonly, ...) local_unnamed_addr #3

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
attributes #2 = { argmemonly mustprogress nofree nounwind readonly willreturn "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { argmemonly nounwind }
attributes #5 = { nounwind readonly willreturn }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 1}
!2 = !{!"clang version 14.0.6 (git@github.com:scampanoni/LLVM_installer.git fc6ceabb24f6c857bd1637c9b94cd4edf7b2669f)"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}
