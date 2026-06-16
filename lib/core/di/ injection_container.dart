import 'package:get_it/get_it.dart';
import 'package:hotel_app/features/Auth/domain/usecases/resend_otp_use_case.dart';
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
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// ---------------- AUTH ----------------
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
/// ---------------- NEWS ----------------
import '../../features/news/data/data_sources/news_remote_datasource.dart';
import '../../features/news/data/repositories/news_repositories_impl.dart';
import '../../features/news/domain/repositories/news_repositories.dart';
import '../../features/news/domain/use_cases/get_all_news.dart';
import '../../features/news/presentation/cubit/news_cubit.dart';

/// ---------------- ONBOARDING ----------------
import '../../features/onboarding/data/datasource/onboarding_local_data.dart';
import '../../features/onboarding/data/repository/onboarding_repository_impl.dart';
import '../../features/onboarding/domain/repositories/onboarding_repository.dart';
import '../../features/onboarding/domain/usecases/get_onboarding_pages.dart';
import '../../features/onboarding/presentation/cubit/onboarding_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// ================= EXTERNAL =================
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
        () => AuthRemoteDataSourceImpl(client: sl()),
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
  sl.registerLazySingleton(() => ForgetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => ResendOtpUseCase(sl()));
  sl.registerLazySingleton(() => VerifyOtpUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));

  sl.registerFactory(() => LoginCubit(sl()));
  sl.registerFactory(() => ForgetPasswordCubit(sl()));
  sl.registerFactory(() => ResendOtpCubit(sl()));
  sl.registerFactory(() => OtpCubit(sl()));
  sl.registerFactory(() => PasswordCubit(sl()));

  /// ================= NEWS =================
  sl.registerLazySingleton<NewsRemoteDataSources>(
        () => NewsRemoteDataSourcesImp(
      client: sl(),
      authLocalDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<NewsRepositories>(
        () => NewsRepositoriesImpl(
      newsRemoteDataSources: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetAllNewsUseCase(sl()));

  sl.registerFactory(() => NewsCubit(sl()));
  /////////==========complaints
  sl.registerLazySingleton<ComplaintsRemoteDataSources>(
        () => ComplaintsRemoteDataSourcesImpl(
          client: sl(),
          authLocalDataSource: sl(),
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
    ),
  );

  sl.registerLazySingleton<LeaveRequestRepositories>(
        () => LeaveRequestRepositoriesImpl(
      leave_remote_data_sources: sl(),
    ),
  );
  sl.registerLazySingleton(() => AddLeaveRequestUseCase(sl()));

  sl.registerFactory(() => LeaveRequestCubit(sl()));

}