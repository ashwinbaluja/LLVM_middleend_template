; ModuleID = 'program.bc'
source_filename = "program.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [24 x i8] c"H5: \09Value of d1 = %ld\0A\00", align 1
@.str.1 = private unnamed_addr constant [21 x i8] c"CAT variables = %ld\0A\00", align 1
@.str.2 = private unnamed_addr constant [16 x i8] c"CAT cost = %ld\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local void @a_generic_C_function(i8* nocapture readnone %0, i32 noundef %1) local_unnamed_addr #0 {
  %3 = call i8* @CAT_new(i64 noundef 8) #3
  %4 = icmp sgt i32 %1, 10
  br i1 %4, label %11, label %13

5:                                                ; preds = %13
  %6 = call i8* @CAT_new(i64 noundef 8) #3
  br label %7

7:                                                ; preds = %5, %13
  %8 = phi i8* [ %6, %5 ], [ %14, %13 ]
  %9 = call i64 @CAT_get(i8* noundef %8) #3
  %10 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([24 x i8], [24 x i8]* @.str, i64 0, i64 0), i64 noundef %9)
  ret void

11:                                               ; preds = %2
  %12 = call i8* @CAT_new(i64 noundef 8) #3
  br label %13

13:                                               ; preds = %11, %2
  %14 = phi i8* [ %12, %11 ], [ %3, %2 ]
  %15 = icmp sgt i32 %1, 100
  br i1 %15, label %5, label %7
}

; Function Attrs: argmemonly nounwind
declare dso_local i8* @CAT_new(i64 noundef) local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare dso_local noundef i32 @printf(i8* nocapture noundef readonly, ...) local_unnamed_addr #2

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_get(i8* noundef) local_unnamed_addr #1

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 noundef %0, i8** nocapture noundef readnone %1) local_unnamed_addr #0 {
  %3 = call i8* @CAT_new(i64 noundef 5) #3
  %4 = call i8* @CAT_new(i64 noundef 8) #3
  %5 = icmp sgt i32 %0, 10
  br i1 %5, label %8, label %10

6:                                                ; preds = %10
  %7 = call i8* @CAT_new(i64 noundef 8) #3
  br label %13

8:                                                ; preds = %2
  %9 = call i8* @CAT_new(i64 noundef 8) #3
  br label %10

10:                                               ; preds = %8, %2
  %11 = phi i8* [ %9, %8 ], [ %4, %2 ]
  %12 = icmp sgt i32 %0, 100
  br i1 %12, label %6, label %13

13:                                               ; preds = %6, %10
  %14 = phi i8* [ %7, %6 ], [ %11, %10 ]
  %15 = call i64 @CAT_get(i8* noundef %14) #3
  %16 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([24 x i8], [24 x i8]* @.str, i64 0, i64 0), i64 noundef %15) #4
  %17 = call i8* @CAT_new(i64 noundef 52) #3
  call void @CAT_add(i8* noundef %17, i8* noundef %17, i8* noundef %17) #3
  call void @CAT_sub(i8* noundef %17, i8* noundef %17, i8* noundef %17) #3
  call void @CAT_set(i8* noundef %17, i64 noundef 42) #3
  %18 = call i64 @CAT_variables() #3
  %19 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([21 x i8], [21 x i8]* @.str.1, i64 0, i64 0), i64 noundef %18)
  %20 = call i64 @CAT_cost() #3
  %21 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @.str.2, i64 0, i64 0), i64 noundef %20)
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
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 1}
!2 = !{!"clang version 14.0.6 (git@github.com:scampanoni/LLVM_installer.git fc6ceabb24f6c857bd1637c9b94cd4edf7b2669f)"}