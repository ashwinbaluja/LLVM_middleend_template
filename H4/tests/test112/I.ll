; ModuleID = 'output_code_iter_1.bc'
source_filename = "program.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.MyOutputT = type { %struct.MyT*, %struct.MyT* }
%struct.MyT = type { i8*, i8*, i8* }

@.str = private unnamed_addr constant [27 x i8] c"H5: Value of s1->d1 = %ld\0A\00", align 1
@.str.1 = private unnamed_addr constant [27 x i8] c"H5: Value of s1->d2 = %ld\0A\00", align 1
@.str.2 = private unnamed_addr constant [27 x i8] c"H5: Value of s1->d3 = %ld\0A\00", align 1
@.str.3 = private unnamed_addr constant [27 x i8] c"H5: Value of s2->d1 = %ld\0A\00", align 1
@.str.4 = private unnamed_addr constant [27 x i8] c"H5: Value of s2->d2 = %ld\0A\00", align 1
@.str.5 = private unnamed_addr constant [27 x i8] c"H5: Value of s2->d3 = %ld\0A\00", align 1
@.str.6 = private unnamed_addr constant [21 x i8] c"CAT variables = %ld\0A\00", align 1
@.str.7 = private unnamed_addr constant [16 x i8] c"CAT cost = %ld\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local void @a_generic_C_function(%struct.MyOutputT* nocapture noundef writeonly %0) local_unnamed_addr #0 {
  %2 = call noalias dereferenceable_or_null(24) i8* @malloc(i64 noundef 24) #5
  %3 = bitcast i8* %2 to %struct.MyT*
  %4 = call noalias dereferenceable_or_null(24) i8* @malloc(i64 noundef 24) #5
  %5 = bitcast i8* %4 to %struct.MyT*
  %6 = call i8* @CAT_new(i64 noundef 8) #6
  %7 = getelementptr inbounds %struct.MyT, %struct.MyT* %3, i64 0, i32 0
  store i8* %6, i8** %7, align 8, !tbaa !3
  %8 = call i8* @CAT_new(i64 noundef 9) #6
  %9 = getelementptr inbounds %struct.MyT, %struct.MyT* %3, i64 0, i32 1
  store i8* %8, i8** %9, align 8, !tbaa !8
  %10 = call i8* @CAT_new(i64 noundef 10) #6
  %11 = getelementptr inbounds %struct.MyT, %struct.MyT* %3, i64 0, i32 2
  store i8* %10, i8** %11, align 8, !tbaa !9
  %12 = call i8* @CAT_new(i64 noundef 1) #6
  %13 = getelementptr inbounds %struct.MyT, %struct.MyT* %5, i64 0, i32 0
  store i8* %12, i8** %13, align 8, !tbaa !3
  %14 = call i8* @CAT_new(i64 noundef 2) #6
  %15 = getelementptr inbounds %struct.MyT, %struct.MyT* %5, i64 0, i32 1
  store i8* %14, i8** %15, align 8, !tbaa !8
  %16 = call i8* @CAT_new(i64 noundef 3) #6
  %17 = getelementptr inbounds %struct.MyT, %struct.MyT* %5, i64 0, i32 2
  store i8* %16, i8** %17, align 8, !tbaa !9
  %18 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([27 x i8], [27 x i8]* @.str, i64 0, i64 0), i64 noundef 8)
  %19 = load i8*, i8** %9, align 8, !tbaa !8
  %20 = call i64 @CAT_get(i8* noundef %19) #6
  %21 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([27 x i8], [27 x i8]* @.str.1, i64 0, i64 0), i64 noundef %20)
  %22 = load i8*, i8** %11, align 8, !tbaa !9
  %23 = call i64 @CAT_get(i8* noundef %22) #6
  %24 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([27 x i8], [27 x i8]* @.str.2, i64 0, i64 0), i64 noundef %23)
  %25 = load i8*, i8** %13, align 8, !tbaa !3
  %26 = call i64 @CAT_get(i8* noundef %25) #6
  %27 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([27 x i8], [27 x i8]* @.str.3, i64 0, i64 0), i64 noundef %26)
  %28 = load i8*, i8** %15, align 8, !tbaa !8
  %29 = call i64 @CAT_get(i8* noundef %28) #6
  %30 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([27 x i8], [27 x i8]* @.str.4, i64 0, i64 0), i64 noundef %29)
  %31 = load i8*, i8** %17, align 8, !tbaa !9
  %32 = call i64 @CAT_get(i8* noundef %31) #6
  %33 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([27 x i8], [27 x i8]* @.str.5, i64 0, i64 0), i64 noundef %32)
  %34 = call i8* @CAT_new(i64 noundef 5) #6
  call void @CAT_set(i8* %34, i64 10)
  call void @CAT_set(i8* %34, i64 0)
  call void @CAT_set(i8* noundef %34, i64 noundef 42) #6
  %35 = bitcast %struct.MyOutputT* %0 to i8**
  store i8* %2, i8** %35, align 8, !tbaa !10
  %36 = getelementptr inbounds %struct.MyOutputT, %struct.MyOutputT* %0, i64 0, i32 1
  %37 = bitcast %struct.MyT** %36 to i8**
  store i8* %4, i8** %37, align 8, !tbaa !12
  ret void
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind willreturn
declare dso_local noalias noundef i8* @malloc(i64 noundef) local_unnamed_addr #2

; Function Attrs: argmemonly nounwind
declare dso_local i8* @CAT_new(i64 noundef) local_unnamed_addr #3

; Function Attrs: nofree nounwind
declare dso_local noundef i32 @printf(i8* nocapture noundef readonly, ...) local_unnamed_addr #4

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_get(i8* noundef) local_unnamed_addr #3

; Function Attrs: argmemonly nounwind
declare dso_local void @CAT_set(i8* noundef, i64 noundef) local_unnamed_addr #3

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 noundef %0, i8** nocapture noundef readnone %1) local_unnamed_addr #0 {
  %3 = alloca %struct.MyOutputT, align 8
  %4 = bitcast %struct.MyOutputT* %3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* nonnull %4) #5
  call void @a_generic_C_function(%struct.MyOutputT* noundef nonnull %3)
  %5 = call i64 @CAT_variables() #6
  %6 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([21 x i8], [21 x i8]* @.str.6, i64 0, i64 0), i64 noundef %5)
  %7 = call i64 @CAT_cost() #6
  %8 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([16 x i8], [16 x i8]* @.str.7, i64 0, i64 0), i64 noundef %7)
  call void @llvm.lifetime.end.p0i8(i64 16, i8* nonnull %4) #5
  ret i32 0
}

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_variables() local_unnamed_addr #3

; Function Attrs: argmemonly nounwind
declare dso_local i64 @CAT_cost() local_unnamed_addr #3

attributes #0 = { nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { argmemonly nofree nosync nounwind willreturn }
attributes #2 = { inaccessiblememonly mustprogress nofree nounwind willreturn "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { argmemonly nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nofree nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind }
attributes #6 = { argmemonly nounwind }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 1}
!2 = !{!"clang version 14.0.6 (git@github.com:scampanoni/LLVM_installer.git fc6ceabb24f6c857bd1637c9b94cd4edf7b2669f)"}
!3 = !{!4, !5, i64 0}
!4 = !{!"", !5, i64 0, !5, i64 8, !5, i64 16}
!5 = !{!"any pointer", !6, i64 0}
!6 = !{!"omnipotent char", !7, i64 0}
!7 = !{!"Simple C/C++ TBAA"}
!8 = !{!4, !5, i64 8}
!9 = !{!4, !5, i64 16}
!10 = !{!11, !5, i64 0}
!11 = !{!"", !5, i64 0, !5, i64 8}
!12 = !{!11, !5, i64 8}
