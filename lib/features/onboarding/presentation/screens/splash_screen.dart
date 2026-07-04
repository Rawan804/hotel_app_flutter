import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hotel_app/features/news/presentation/screen/HomePage.dart';
import 'package:hotel_app/features/news/presentation/widgets/NewsCards.dart';
import 'package:hotel_app/l10n/app_localizations.dart';

import '../../../../core/di/ injection_container.dart';
import '../../../Auth/data/datasource/auth_local_datasource.dart';
import '../../../Auth/presentation/pages/login_page.dart';
import '../../data/datasource/onboarding_local_data.dart';
import 'onboarding_screen.dart';

class SplashScreen
    extends StatefulWidget {

  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController
  _controller;

  late Animation<double>
  _scaleAnimation;

  late Animation<double>
  _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _controller.forward();

    Future.delayed(
      const Duration(seconds: 3),
          () {
        if (mounted) {
          checkLogin();
        }
      },
    );
  }

  @override
  Widget build(
      BuildContext context,
      ) {
    final l=AppLocalizations.of(context);

    return Scaffold(
      body: Container(
        decoration:
        const BoxDecoration(
          gradient:
          LinearGradient(
            begin:
            Alignment.topLeft,
            end:
            Alignment.bottomRight,
            colors: [
              Color(0xFFFFF9F4),
              Color(0xFFF5F0E1),
            ],
          ),
        ),

        child: Center(
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment
                .center,

            children: [

              ScaleTransition(
                scale:
                _scaleAnimation,

                child:
                FadeTransition(
                  opacity:
                  _fadeAnimation,

                  child:
                  Container(
                    width: 120,
                    height: 120,

                    decoration:
                    BoxDecoration(
                      gradient:
                      const LinearGradient(
                        begin:
                        Alignment.topLeft,
                        end:
                        Alignment.bottomRight,
                        colors: [
                          Color(
                            0xFFD4AF7F,
                          ),
                          Color(
                            0xFFB8935F,
                          ),
                        ],
                      ),

                      borderRadius:
                      BorderRadius
                          .circular(
                        28,
                      ),
                    ),

                    child:
                    const Icon(
                      Icons
                          .check_circle_outline,
                      size: 64,
                      color: Colors
                          .white,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 32,
              ),

              FadeTransition(
                opacity:
                _fadeAnimation,

                child: Column(
                  children: [

                    Text(
                      l!.luxihotel,
                      style: Theme.of(
                          context)
                          .textTheme
                          .displayMedium,
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    Text(
                     l!.organizemotivateachieve,
                      style: Theme.of(
                          context)
                          .textTheme
                          .bodyLarge,
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 40,
              ),

              const CircularProgressIndicator(
                color: Color(
                  0xFFD4AF7F,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> checkLogin() async {
    final token = await sl<AuthLocalDataSource>().getToken();

    final onboardingSeen =
    await sl<OnboardingLocalDataSource>().isOnboardingSeen();

    print("TOKEN = $token");
    print("ONBOARDING = $onboardingSeen");

    if (!mounted) return;

    if (!onboardingSeen) {
      print("GO ONBOARDING");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        ),
      );
    } else if (token != null && token.isNotEmpty) {

      print("GO HOME");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Homepage(),
        ),
      );
    } else {

      print("GO LOGIN");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => LoginPage(),
        ),
      );
    }
  }

  @override
  void dispose() {

    _controller.dispose();

    super.dispose();
  }
}
