import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/features/tasks/domain/entites/task.dart';
import 'package:hotel_app/features/tasks/domain/use_cases/end_task.dart';
import 'package:hotel_app/features/tasks/domain/use_cases/get_all_task.dart';
import 'package:hotel_app/features/tasks/domain/use_cases/toggle_task.dart';
import '../../../language/presentation/cubit/language_cubit.dart';
import 'task_details_state.dart';

class TaskDetailsCubit extends Cubit<TaskState> {
  TaskDetailsCubit(this.getAllTaskUseCase, this.toggleTaskUseCase, this.languageCubit,this.endTaskUseCase)
      : super(TaskInitial()) {
    // اسمع على تغيير اللغة تلقائياً
    _languageSub = languageCubit.stream.listen((_) {
      getAllTask();
    });
  }

  final GetAllTaskUseCase getAllTaskUseCase;
  final ToggleTaskUseCase toggleTaskUseCase;
  final EndTaskUseCase endTaskUseCase;
  final LanguageCubit languageCubit;
  late final StreamSubscription _languageSub;

  @override
  Future<void> close() {
    _languageSub.cancel();
    return super.close();
  }


  List<TaskEntity> cachedTasks = [];
  String currentFilter = 'all';

  Future<void> getAllTask() async {
    emit(TaskLoading());

    final result = await getAllTaskUseCase();

    result.fold(
          (failure) {
        emit(TaskFail(message: 'Failed'));
      },
          (tasksList) {
        cachedTasks = tasksList;
        emit(TaskSuccses(tasks: tasksList, filter: currentFilter));
      },
    );
  }

  Future<void> toggleTask(int id) async {
    final result = await toggleTaskUseCase(id);

    result.fold(
          (failure) => emit(TaskFail(message: "Failed")),
          (updatedItem) async {
        emit(TaskToggle(updatedItem));
        final freshResult = await getAllTaskUseCase();
        freshResult.fold(
              (failure) {},
              (freshTasks) {
            cachedTasks = freshTasks;

            emit(TaskSuccses(tasks: freshTasks, filter: currentFilter));
          },
        );
      },
    );
  }

  Future<void> endTask(int id) async {
    final result = await endTaskUseCase(id);

    result.fold(
          (failure) => emit(TaskFail(message: "Failed")),
          (_) async {
        // ✅ بعد النجاح اجلب التاسكات من جديد
        final freshResult = await getAllTaskUseCase();
        freshResult.fold(
              (failure) {},
              (freshTasks) {
            cachedTasks = freshTasks;
            emit(TaskSuccses(tasks: freshTasks, filter: currentFilter));
          },
        );
      },
    );
  }

  void changeFilter(String filter) {
    currentFilter = filter;
    final stateNow = state;

    if (stateNow is TaskSuccses) {
      emit(stateNow.copyWith(filter: filter));
    } else if (stateNow is TaskToggle) {
      // ارجع لـ TaskSuccses مع الـ filter الجديد
      emit(TaskSuccses(tasks: cachedTasks, filter: filter));
    }
  }
}