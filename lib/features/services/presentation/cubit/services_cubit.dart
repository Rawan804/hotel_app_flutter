import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/features/services/domain/entites/services.dart';
import 'package:hotel_app/features/services/domain/use_cases/end_services.dart';
import 'package:hotel_app/features/services/domain/use_cases/getServices.dart';
import 'package:hotel_app/features/services/domain/use_cases/start_services.dart';
import 'package:hotel_app/features/services/presentation/cubit/services_state.dart';
import 'package:hotel_app/features/tasks/domain/entites/task.dart';
import 'package:hotel_app/features/tasks/domain/use_cases/end_task.dart';
import 'package:hotel_app/features/tasks/domain/use_cases/get_all_task.dart';
import 'package:hotel_app/features/tasks/domain/use_cases/toggle_task.dart';
import '../../../language/presentation/cubit/language_cubit.dart';


class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit(this.getAllServicesUseCase, this.startServiceUseCase,
      this.languageCubit, this.endServiceUseCase)
      : super(ServicesInitial()) {
    _languageSub = languageCubit.stream.listen((_) {
      getAllServices();
    });
  }

  final GetAllServicesUseCase getAllServicesUseCase;
  final StartServiceUseCase startServiceUseCase;
  final EndServiceUseCase endServiceUseCase;
  final LanguageCubit languageCubit;
  late final StreamSubscription _languageSub;

  @override
  Future<void> close() {
    _languageSub.cancel();
    return super.close();
  }

  List<ServiceEntity> cachedServices = [];
  String currentFilter = 'all';

  // ids يلي حالياً في نص عملية Start/End، لعرض loading محلي بالكرت بس
  final Set<int> loadingIds = {};

  Future<void> getAllServices() async {
    emit(ServicesLoading());
    final result = await getAllServicesUseCase();
    result.fold(
          (failure) => emit(ServiceFail(message: failure.message)),
          (serviceList) {
        cachedServices = serviceList;
        emit(_buildSuccessState());
      },
    );
  }

  void changeFilter(String filter) {
    currentFilter = filter;
    emit(_buildSuccessState());
  }

  Future<void> startService(int id) async {
    loadingIds.add(id);
    emit(_buildSuccessState());

    final result = await startServiceUseCase(id);
    loadingIds.remove(id);

    result.fold(
          (failure) => emit(ServiceFail(message: failure.message)),
          (updated) {
        cachedServices =
            cachedServices.map((s) => s.id == id ? updated : s).toList();
        emit(_buildSuccessState());
      },
    );
  }

  Future<void> endService(int id) async {
    loadingIds.add(id);
    emit(_buildSuccessState());

    final result = await endServiceUseCase(id);
    loadingIds.remove(id);

    result.fold(
          (failure) => emit(ServiceFail(message: failure.message)),
          (updated) {
        cachedServices =
            cachedServices.map((s) => s.id == id ? updated : s).toList();
        emit(_buildSuccessState());
      },
    );
  }

  ServiceSuccess _buildSuccessState() {
    final filtered = currentFilter == 'all'
        ? cachedServices
        : cachedServices.where((s) => s.status == currentFilter).toList();
    return ServiceSuccess(services: filtered, filter: currentFilter);
  }
}