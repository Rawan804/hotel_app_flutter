import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hotel_app/features/Auth/presentation/cubit/logout_cubit.dart';
import 'package:hotel_app/features/services/presentation/cubit/services_cubit.dart';
import 'package:hotel_app/features/tasks/presentation/cubit/task_details_cubit.dart';
import 'Theme/theme_cubit.dart';
import 'Theme/theme_state.dart';
import 'core/di/ injection_container.dart';
import 'core/services.dart';
import 'core/theme/app_theme.dart';
import 'features/Auth/presentation/cubit/create_new_password_cubit.dart';
import 'features/Auth/presentation/cubit/forget_password_cubit.dart';
import 'features/Auth/presentation/cubit/login_cubit.dart';
import 'features/Auth/presentation/cubit/otp_cubit.dart';
import 'features/Auth/presentation/cubit/resend_otp_cubit.dart';
import 'features/Notifications/Services/notification_storage_service.dart';
import 'features/Notifications/model/app_notification.dart';
import 'features/complaints_request/presentation/cubit/complaints_request_cubit.dart';
import 'features/language/presentation/cubit/language_cubit.dart';
import 'features/language/presentation/cubit/language_state.dart';
import 'features/leave_request/presentation/cubit/leave_request_cubit.dart';
import 'features/news/presentation/cubit/BottomBar Cubit/bottomba_cubit.dart';
import 'features/news/presentation/cubit/news_cubit.dart';
import 'features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'features/onboarding/presentation/screens/splash_screen.dart';
import 'l10n/app_localizations.dart';
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  final storage = SharedPrefsNotificationStorage();
  await storage.add(AppNotification(
    id: message.data['notification_id']?.toString() ??
        DateTime.now().millisecondsSinceEpoch.toString(),
    title: message.notification?.title ?? '',
    body: message.notification?.body ?? '',
    data: message.data,
    receivedAt: DateTime.now(),
  ));
}

Future<void> main() async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  //HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await NotificationService.initialize();
  final themeCubit = ThemeCubit();
  await init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BottomNavigationCubit()),
        BlocProvider(create: (_) => sl<OnboardingCubit>()),
        BlocProvider(create: (_) => sl<LoginCubit>()),
        BlocProvider(create: (_) => sl<LogoutCubit>()),
        BlocProvider(create: (_) => sl<ForgetPasswordCubit>()),
        BlocProvider(create: (_) => sl<OtpCubit>()),
        BlocProvider(create: (_) => sl<PasswordCubit>()),
        BlocProvider(create: (_) => sl<ResendOtpCubit>()),
        BlocProvider.value(value: sl<NewsCubit>()..getAllNews()),
        BlocProvider.value(value: sl<TaskDetailsCubit>()..getAllTask()),
        BlocProvider.value(value: sl<ServicesCubit>()..getAllServices()),
        BlocProvider(create: (_) => sl<ComplaintsRequestCubit>()),
        BlocProvider(create: (_) => sl<LeaveRequestCubit>()),
        BlocProvider.value(value: themeCubit),
        BlocProvider.value(value: sl<LanguageCubit>()..loadSavedLanguage()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, langState) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppThemes.build(
                themeState.themeType,
                isArabic: langState.locale.languageCode == 'ar',
              ),


              locale: langState.locale,
              supportedLocales: const [
                Locale('ar'),
                Locale('en'),
              ],
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              localeResolutionCallback: (locale, supportedLocales) {
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale?.languageCode) {
                    return supportedLocale;
                  }
                }
                return supportedLocales.first;
              },
              home: const SplashScreen(),
            );
          },
        );
      },
    );
  }
}