import 'package:get_it/get_it.dart';
import 'package:hotel_app/features/Auth/domain/usecases/logoutUseCase.dart';
import 'package:hotel_app/features/Auth/domain/usecases/resend_otp_use_case.dart';
import 'package:hotel_app/features/Auth/presentation/cubit/logout_cubit.dart';
import 'package:hotel_app/features/Auth/presentation/cubit/resend_otp_cubit.dart';
import 'package:hotel_app/features/complaints_request/data/data_sources/complaint_remote_data_sources.dart';
import 'package:hotel_app/features/complaints_request/data/repositories/ComplaintRepositoryImpl.dart';
import 'package:hotel_app/features/complaints_request/domain/repositories/complaints_repositories.dart';
import 'package:hotel_app/features/complaints_request/domain/use_cases/add_compliants_use_case.dart';
import 'package:hotel_app/features/leave_request/data/data_sources/leave_remote_data_sources.dart';
import 'package:hotel_app/features/leave_request/data/repositories/leave_request_repositories_impl.dart';
import 'package:hotel_app/features/leave_request/domain/repositories/leave_request_repositories.dart';
import 'package:hotel_app/features/leave_request/domain/use_cases/add_leave_request_use_case.dart';
import 'package:hotel_app/features/leave_request/presentation/cubit/leave_request_cubit.dart';
import 'package:hotel_app/features/services/data/data_sources/services_locale_data_sources.dart';
import 'package:hotel_app/features/services/data/data_sources/services_remote_data_sources.dart';
import 'package:hotel_app/features/services/data/repositories/services_repositories_impl.dart';
import 'package:hotel_app/features/services/domain/repositories/services_repositories.dart';
import 'package:hotel_app/features/services/domain/use_cases/end_services.dart';
import 'package:hotel_app/features/services/domain/use_cases/getServices.dart';
import 'package:hotel_app/features/services/domain/use_cases/start_services.dart';
import 'package:hotel_app/features/services/presentation/cubit/services_cubit.dart';
import 'package:hotel_app/features/tasks/data/data_sources/task_remote_data_sources.dart';
import 'package:hotel_app/features/tasks/data/repositories/task_repositories_impl.dart';
import 'package:hotel_app/features/tasks/domain/repositories/task_repositories.dart';
import 'package:hotel_app/features/tasks/domain/use_cases/end_task.dart';
import 'package:hotel_app/features/tasks/domain/use_cases/get_all_task.dart';
import 'package:hotel_app/features/tasks/domain/use_cases/toggle_task.dart';
import 'package:hotel_app/features/tasks/presentation/cubit/task_details_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/Auth/data/datasource/auth_local_datasource.dart';
import '../../features/Auth/data/datasource/auth_remote_datasource.dart';
import '../../features/Auth/data/repositories/auth_repositories_impl.dart';
import '../../features/Auth/domain/repositories/auth_repositories.dart';
import '../../features/Auth/domain/usecases/ loginUseCase.dart';
import '../../features/Auth/domain/usecases/ForgotPasswordUseCase.dart';
import '../../features/Auth/domain/usecases/ResetPasswordUseCase.dart';
import '../../features/Auth/domain/usecases/VerifyOtpUseCase.dart';
import '../../features/Auth/presentation/cubit/login_cubit.dart';
import '../../features/Auth/presentation/cubit/forget_password_cubit.dart';
import '../../features/Auth/presentation/cubit/otp_cubit.dart';
import '../../features/Auth/presentation/cubit/create_new_password_cubit.dart';
import '../../features/complaints_request/presentation/cubit/complaints_request_cubit.dart';
import '../../features/language/data/datasources/language_local_datasource.dart';
import '../../features/language/data/repositories/language_repository_impl.dart';
import '../../features/language/domain/repositories/language_repository.dart';
import '../../features/language/domain/usecases/get_language_usecase.dart';
import '../../features/language/domain/usecases/save_language_usecase.dart';
import '../../features/language/presentation/cubit/language_cubit.dart';
import '../../features/news/data/data_sources/news_remote_datasource.dart';
import '../../features/news/data/repositories/news_repositories_impl.dart';
import '../../features/news/domain/repositories/news_repositories.dart';
import '../../features/news/domain/use_cases/get_all_news.dart';
import '../../features/news/presentation/cubit/news_cubit.dart';
import '../../features/onboarding/data/datasource/onboarding_local_data.dart';
import '../../features/onboarding/data/repository/onboarding_repository_impl.dart';
import '../../features/onboarding/domain/repositories/onboarding_repository.dart';
import '../../features/onboarding/domain/usecases/get_onboarding_pages.dart';
import '../../features/onboarding/presentation/cubit/onboarding_cubit.dart';
import '../../features/tasks/data/data_sources/task_locale_data_sources.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);
  sl.registerLazySingleton(() => http.Client());
  /// ================= ONBOARDING =================
  sl.registerLazySingleton<OnboardingLocalDataSource>(
        () => OnboardingLocalDataSourceImpl(prefs),
  );
  sl.registerLazySingleton<OnboardingRepository>(
        () => OnboardingRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetOnboardingPages(sl()));
  sl.registerFactory(() => OnboardingCubit(sl()));
  /// ================= AUTH =================
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(client: sl(),authLocalDataSource: sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
        () => AuthLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthRepositories>(
        () => AuthRepositoryImpl(
      authRemoteDataSource: sl(),
      authLocalDataSource: sl(),
    ),
  );
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => Logoutusecase(sl()));
  sl.registerLazySingleton(() => ForgetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => ResendOtpUseCase(sl()));
  sl.registerLazySingleton(() => VerifyOtpUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));
  sl.registerFactory(() => LoginCubit(sl()));
  sl.registerFactory(() => LogoutCubit(sl()));
  sl.registerFactory(() => ForgetPasswordCubit(sl()));
  sl.registerFactory(() => ResendOtpCubit(sl()));
  sl.registerFactory(() => OtpCubit(sl()));
  sl.registerFactory(() => PasswordCubit(sl()));

  /////////==========complaints
  sl.registerLazySingleton<ComplaintsRemoteDataSources>(
        () => ComplaintsRemoteDataSourcesImpl(
          client: sl(),
          authLocalDataSource: sl(),
            localDataSource:sl()
    ),
  );
  sl.registerLazySingleton<ComplaintsRepositories>(
        () => ComplaintsRepositoriesImpl(
          complaintsRemoteDataSources: sl(),
    ),
  );
  sl.registerLazySingleton(() => AddComplaintsUseCase(sl()));
  sl.registerFactory(() => ComplaintsRequestCubit(sl()));
  sl.registerLazySingleton<Leave_Remote_Data_Sources>(
        () => Leave_Remote_Data_Sources_Impl(
      client: sl(),
      authLocalDataSource: sl(),
          localDataSource: sl()
    ),
  );
  sl.registerLazySingleton<LeaveRequestRepositories>(
        () => LeaveRequestRepositoriesImpl(
      leave_remote_data_sources: sl(),
    ),
  );
  sl.registerLazySingleton(() => AddLeaveRequestUseCase(sl()));
  sl.registerFactory(() => LeaveRequestCubit(sl()));
  sl.registerLazySingleton<LanguageLocalDataSource>(
        () => LanguageLocalDataSourceImpl(),
  );
  // Repository
  sl.registerLazySingleton<LanguageRepository>(
        () => LanguageRepositoryImpl(sl()),
  );
  // Use Cases
  sl.registerLazySingleton(() => GetLanguageUseCase(sl()));
  sl.registerLazySingleton(() => SaveLanguageUseCase(sl()));

  // Cubit
  sl.registerLazySingleton(
        () => LanguageCubit(getLanguage: sl(), saveLanguage: sl()),
  );
  /// ================= NEWS =================
  sl.registerLazySingleton<NewsRemoteDataSources>(
        () => NewsRemoteDataSourcesImp(
        client: sl(),
        authLocalDataSource: sl(),
        localDataSource: sl()
    ),
  );
  sl.registerLazySingleton<NewsRepositories>(
        () => NewsRepositoriesImpl(
      newsRemoteDataSources: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetAllNewsUseCase(sl()));
  sl.registerLazySingleton(() => NewsCubit(sl(), sl<LanguageCubit>()));
  ////////task
  sl.registerLazySingleton<TasksLocaleDataSource>(
        () => TasksLocaleDataSourcesImpl(sl()),
  );
  sl.registerLazySingleton<TaskRemoteDataSource>(
        () => TaskRemoteDataSourceImpl(
        client: sl(),
        authLocalDataSource: sl(),
        localDataSource: sl(),
            tasksLocaleDataSource: sl()
    ),
  );

  sl.registerLazySingleton<TaskRepositories>(
        () => TaskRepositoriesImpl(
      taskRemoteDataSource: sl(),
          tasksLocaleDataSource: sl()
    ),
  );

  sl.registerLazySingleton(() => GetAllTaskUseCase(sl()));
  sl.registerLazySingleton(() => ToggleTaskUseCase(sl()));
  sl.registerLazySingleton(() => EndTaskUseCase(sl()));
  sl.registerLazySingleton(
        () => TaskDetailsCubit(
      sl(),
      sl(),
      sl<LanguageCubit>(),
      sl(),
    ),
  );








  sl.registerLazySingleton<ServicesLocaleDataSources>(
        () => ServiceLocaleDataSourcesImpl(sl()),
  );
  sl.registerLazySingleton<ServicesRemoteDataSources>(
        () => ServicesRemoteDataSourcesImpl(
        client: sl(),
        authLocalDataSource: sl(),
        localDataSource: sl(),
        servicesLocaleDataSources: sl()
    ),
  );

  sl.registerLazySingleton<ServicesRepositories>(
        () => ServicesRepositoriesImpl(
        servicesRemoteDataSources: sl(),
        servicesLocaleDataSources: sl()
    ),
  );

  sl.registerLazySingleton(() => GetAllServicesUseCase(sl()));
  sl.registerLazySingleton(() => StartServiceUseCase(sl()));
  sl.registerLazySingleton(() => EndServiceUseCase(sl()));
  sl.registerFactory(() => ServicesCubit(sl(),sl(),sl<LanguageCubit>(),sl()));
}