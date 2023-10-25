; ModuleID = 'output_code_iter_2.bc'
source_filename = "program.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [9 x i8] c"d1: %lx\0A\00", align 1
@.str.1 = private unnamed_addr constant [9 x i8] c"d2: %lx\0A\00", align 1
@.str.4 = private unnamed_addr constant [21 x i8] c"CAT variables = %ld\0A\00", align 1
@.str.5 = private unnamed_addr constant [16 x i8] c"CAT cost = %ld\0A\00", align 1
@str = private unnamed_addr constant [10 x i8] c"H1: Begin\00", align 1
@str.6 = private unnamed_addr constant [8 x i8] c"H1: End\00", align 1

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone uwtable willreturn
define dso_local i8* @selector1(i8* noundef readnone %0, i8* noundef readnone %1, i32 noundef %2) local_unnamed_addr #0 {
  %4 = icmp sgt i32 %2, 0
  %5 = select i1 %4, i8* %0, i8* %1
  ret i8* %5
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone uwtable willreturn
define dso_local i8* @selector2(i8* noundef readnone %0, i8* noundef readnone %1, i32 noundef %2) local_unnamed_addr #0 {
  %4 = icmp slt i32 %2, 1
  %5 = select i1 %4, i8* %0, i8* %1
  ret i8* %5
}

; Function Attrs: nounwind uwtable
define dso_local void @setrandom(i8* noundef %0, i8* noundef %1, i32 noundef %2) local_unnamed_addr #1 {
  %4 = icmp slt i32 %2, 0
  br i1 %4, label %5, label %6

5:                                                ; preds = %3
  call void @CAT_set(i8* noundef %0, i64 noundef -1) #5
  br label %7

6:                                                ; preds = %3
  call void @CAT_set(i8* noundef %1, i64 noundef 4277137423) #5
  br label %7

7:                                                ; preds = %6, %5
  ret void
}

; Function Attrs: argmemonly nounwind
declare dso_local void @CAT_set(i8* noundef, i64 noundef) local_unnamed_addr #2

; Function Attrs: nounwind uwtable
define dso_local void @my_execution(i32 noundef %0) local_unnamed_addr #1 {
  %2 = call i8* @CAT_new(i64 noundef 4027562513) #5
  %3 = call i8* @CAT_new(i64 noundef 3131947693) #5
  %4 = icmp slt i32 %0, 0
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  call void @CAT_set(i8* noundef %3, i64 noundef -1) #5
  br label %9

6:                                                ; preds = %1
  %7 = icmp eq i32 %0, 0
  %8 = select i1 %7, i8* %2, i8* %3
  call void @CAT_set(i8* noundef %8, i64 noundef 4277137423) #5
  br label %9

9:                                                ; preds = %5, %6
  call void @CAT_set(i8* noundef %2, i64 noundef 4027562513) #5
  %10 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @.str, i64 0, i64 0), i64 noundef 4027562513)
  %11 = call i64 @CAT_get(i8* noundef %3) #5
  %12 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @.str.1, i64 0, i64 0), i64 noundef %11)
  call void @CAT_set(i8* %2, i64 8055125026)
  call void @CAT_set(i8* %2, i64 0)
  %13 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @.str, i64 0, i64 0), i64 noundef 0)
  ret void
}

; Function Attrs: argmemonly nounwind
declare dso_local i8* @CAT_new(i64 noundef) local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare dso_local noundef i32 @printf(i8* nocapture noundef readonly, ...) local_unnamed_addr #3

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_get(i8* noundef) local_unnamed_addr #2

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 noundef %0, i8** nocapture noundef readnone %1) local_unnamed_addr #1 {
  %3 = call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([10 x i8], [10 x i8]* @str, i64 0, i64 0))
  call void @my_execution(i32 noundef %0)
  %4 = call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([8 x i8], [8 x i8]* @str.6, i64 0, i64 0))
  %5 = call i64 @CAT_variables() #5
  %6 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([21 x i8], [21 x i8]* @.str.4, i64 0, i64 0), i64 noundef %5)
  %7 = call i64 @CAT_cost() #5
  %8 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0), i64 noundef %7)
  ret i32 0
}

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_variables() local_unnamed_addr #2

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_cost() local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare noundef i32 @puts(i8* nocapture noundef readonly) local_unnamed_addr #4

attributes #0 = { mustprogress nofree norecurse nosync nounwind readnone uwtable willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { argmemonly nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nofree nounwind }
attributes #5 = { argmemonly nounwind }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 1}
!2 = !{!"clang version 14.0.6 (git@github.com:scampanoni/LLVM_installer.git fc6ceabb24f6c857bd1637c9b94cd4edf7b2669f)"}
