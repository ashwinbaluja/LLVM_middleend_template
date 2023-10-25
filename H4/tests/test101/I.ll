; ModuleID = 'output_code_iter_1.bc'
source_filename = "program.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [10 x i8] c"HELLO %f\0A\00", align 1
@you_cannot_take_decisions_based_on_function_names.internalD1 = internal global i8* null, align 8
@.str.6 = private unnamed_addr constant [13 x i8] c"Values: %ld\0A\00", align 1
@.str.7 = private unnamed_addr constant [21 x i8] c"CAT variables = %ld\0A\00", align 1
@.str.8 = private unnamed_addr constant [16 x i8] c"CAT cost = %ld\0A\00", align 1
@str = private unnamed_addr constant [4 x i8] c"WOW\00", align 1
@str.9 = private unnamed_addr constant [6 x i8] c"Hello\00", align 1
@str.10 = private unnamed_addr constant [8 x i8] c"Hello 2\00", align 1
@str.12 = private unnamed_addr constant [20 x i8] c"Invoking a function\00", align 1
@str.13 = private unnamed_addr constant [26 x i8] c"This block doesn't matter\00", align 1

; Function Attrs: nofree nounwind uwtable
define dso_local i32 @another_function(i32 noundef %0, float noundef %1, double noundef %2) local_unnamed_addr #0 {
  %4 = sitofp i32 %0 to double
  %5 = fpext float %1 to double
  %6 = fadd double %4, %5
  %7 = fadd double %6, %2
  %8 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([10 x i8], [10 x i8]* @.str, i64 0, i64 0), double noundef %7)
  %9 = add nsw i32 %0, 100
  ret i32 %9
}

; Function Attrs: nofree nounwind
declare dso_local noundef i32 @printf(i8* nocapture noundef readonly, ...) local_unnamed_addr #1

; Function Attrs: nounwind uwtable
define dso_local void @yet_another_function(i8** noundef readnone %0, i8* noundef %1) local_unnamed_addr #2 {
  %3 = icmp eq i8** %0, null
  br i1 %3, label %5, label %4

4:                                                ; preds = %2
  call void @CAT_add(i8* noundef %1, i8* noundef %1, i8* noundef %1) #6
  call void @CAT_sub(i8* noundef %1, i8* noundef %1, i8* noundef %1) #6
  call void @CAT_set(i8* noundef %1, i64 noundef 42) #6
  br label %7

5:                                                ; preds = %2
  %6 = call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([4 x i8], [4 x i8]* @str, i64 0, i64 0))
  br label %7

7:                                                ; preds = %5, %4
  ret void
}

; Function Attrs: argmemonly nounwind
declare dso_local void @CAT_add(i8* noundef, i8* noundef, i8* noundef) local_unnamed_addr #3

; Function Attrs: argmemonly nounwind
declare dso_local void @CAT_sub(i8* noundef, i8* noundef, i8* noundef) local_unnamed_addr #3

; Function Attrs: argmemonly nounwind
declare dso_local void @CAT_set(i8* noundef, i64 noundef) local_unnamed_addr #3

; Function Attrs: mustprogress nofree norecurse nosync nounwind uwtable willreturn
define dso_local i8** @you_cannot_take_decisions_based_on_function_names(i8* noundef %0) local_unnamed_addr #4 {
  %2 = icmp eq i8* %0, null
  br i1 %2, label %7, label %3

3:                                                ; preds = %1
  %4 = load i8*, i8** @you_cannot_take_decisions_based_on_function_names.internalD1, align 8, !tbaa !3
  %5 = icmp eq i8* %4, null
  br i1 %5, label %6, label %7

6:                                                ; preds = %3
  store i8* %0, i8** @you_cannot_take_decisions_based_on_function_names.internalD1, align 8, !tbaa !3
  br label %7

7:                                                ; preds = %3, %6, %1
  %8 = phi i8** [ null, %1 ], [ @you_cannot_take_decisions_based_on_function_names.internalD1, %6 ], [ @you_cannot_take_decisions_based_on_function_names.internalD1, %3 ]
  ret i8** %8
}

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 noundef %0, i8** nocapture noundef readnone %1) local_unnamed_addr #2 {
  %3 = call i8* @CAT_new(i64 noundef 5) #6
  %4 = icmp sgt i32 %0, 5
  br i1 %4, label %11, label %5

5:                                                ; preds = %2
  %6 = icmp eq i8* %3, null
  br i1 %6, label %11, label %7

7:                                                ; preds = %5
  %8 = load i8*, i8** @you_cannot_take_decisions_based_on_function_names.internalD1, align 8, !tbaa !3
  %9 = icmp eq i8* %8, null
  br i1 %9, label %10, label %11

10:                                               ; preds = %7
  store i8* %3, i8** @you_cannot_take_decisions_based_on_function_names.internalD1, align 8, !tbaa !3
  br label %11

11:                                               ; preds = %10, %7, %5, %2
  %12 = phi i8* [ getelementptr inbounds ([26 x i8], [26 x i8]* @str.13, i64 0, i64 0), %2 ], [ getelementptr inbounds ([6 x i8], [6 x i8]* @str.9, i64 0, i64 0), %5 ], [ getelementptr inbounds ([6 x i8], [6 x i8]* @str.9, i64 0, i64 0), %7 ], [ getelementptr inbounds ([6 x i8], [6 x i8]* @str.9, i64 0, i64 0), %10 ]
  %13 = phi i8*** [ null, %2 ], [ null, %5 ], [ bitcast (i8** @you_cannot_take_decisions_based_on_function_names.internalD1 to i8***), %7 ], [ bitcast (i8** @you_cannot_take_decisions_based_on_function_names.internalD1 to i8***), %10 ]
  %14 = call i32 @puts(i8* nonnull dereferenceable(1) %12)
  %15 = call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([8 x i8], [8 x i8]* @str.10, i64 0, i64 0))
  %16 = add nsw i32 %0, 1
  %17 = sitofp i32 %16 to float
  %18 = sitofp i32 %0 to double
  %19 = fpext float %17 to double
  %20 = fadd double %18, %19
  %21 = fadd double %20, 4.242000e+01
  %22 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([10 x i8], [10 x i8]* @.str, i64 0, i64 0), double noundef %21) #7
  %23 = icmp sgt i32 %0, -90
  br i1 %23, label %24, label %31

24:                                               ; preds = %11
  %25 = call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([20 x i8], [20 x i8]* @str.12, i64 0, i64 0))
  %26 = load i8**, i8*** %13, align 8, !tbaa !3
  %27 = icmp eq i8** %26, null
  br i1 %27, label %29, label %28

28:                                               ; preds = %24
  call void @CAT_set(i8* %3, i64 10)
  call void @CAT_set(i8* %3, i64 0)
  call void @CAT_set(i8* noundef %3, i64 noundef 42) #6
  br label %33

29:                                               ; preds = %24
  %30 = call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([4 x i8], [4 x i8]* @str, i64 0, i64 0)) #7
  br label %33

31:                                               ; preds = %11
  %32 = call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([26 x i8], [26 x i8]* @str.13, i64 0, i64 0))
  br label %33

33:                                               ; preds = %29, %28, %31
  %34 = call i64 @CAT_get(i8* noundef %3) #6
  %35 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([13 x i8], [13 x i8]* @.str.6, i64 0, i64 0), i64 noundef %34)
  %36 = call i64 @CAT_variables() #6
  %37 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([21 x i8], [21 x i8]* @.str.7, i64 0, i64 0), i64 noundef %36)
  %38 = call i64 @CAT_cost() #6
  %39 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @.str.8, i64 0, i64 0), i64 noundef %38)
  ret i32 0
}

; Function Attrs: argmemonly nounwind
declare dso_local i8* @CAT_new(i64 noundef) local_unnamed_addr #3

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_get(i8* noundef) local_unnamed_addr #3

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_variables() local_unnamed_addr #3

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_cost() local_unnamed_addr #3

; Function Attrs: nofree nounwind
declare noundef i32 @puts(i8* nocapture noundef readonly) local_unnamed_addr #5

attributes #0 = { nofree nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { argmemonly nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { mustprogress nofree norecurse nosync nounwind uwtable willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nofree nounwind }
attributes #6 = { argmemonly nounwind }
attributes #7 = { nounwind }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 1}
!2 = !{!"clang version 14.0.6 (git@github.com:scampanoni/LLVM_installer.git fc6ceabb24f6c857bd1637c9b94cd4edf7b2669f)"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}
