import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/features/Auth/presentation/pages/login_page.dart';
import 'package:hotel_app/l10n/app_localizations.dart';

import '../../../../core/di/ injection_container.dart';

import '../../data/datasource/onboarding_local_data.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';

import '../widgets/onboarding_page.dart';
import '../widgets/welcome_illustration.dart';
import '../widgets/tasks_illustration.dart';
import '../widgets/motivation_illustration.dart';
import '../widgets/workflow_illustration.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  final PageController _pageController = PageController();


  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<OnboardingCubit>().loadPages();
    });
  }


  String _translate(String key, AppLocalizations l) {

    switch (key) {

      case 'onboardingTitle1':
        return l.onboardingTitle1;

      case 'onboardingTitle2':
        return l.onboardingTitle2;

      case 'onboardingTitle3':
        return l.onboardingTitle3;

      case 'onboardingTitle4':
        return l.onboardingTitle4;


      case 'onboardingDesc1':
        return l.onboardingDesc1;

      case 'onboardingDesc2':
        return l.onboardingDesc2;

      case 'onboardingDesc3':
        return l.onboardingDesc3;

      case 'onboardingDesc4':
        return l.onboardingDesc4;


      default:
        return key;
    }
  }



  void _nextPage(
      int currentPage,
      int totalPages,
      ) {

    if (currentPage < totalPages - 1) {

      _pageController.nextPage(
        duration:
        const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );

    } else {

      _finish();

    }
  }



  Future<void> _finish() async {

    await sl<OnboardingLocalDataSource>()
        .saveOnboardingSeen();


    final l = AppLocalizations.of(context)!;


    if (!mounted) return;


    showDialog(
      context: context,

      builder: (_) => AlertDialog(

        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(20),
        ),


        title: Text(
          l.welcome,
        ),


        content: Text(
          l.welcometo,
        ),


        actions: [

          TextButton(

            onPressed: () {

              Navigator.pushReplacement(
                context,

                MaterialPageRoute(
                  builder: (_) =>
                      LoginPage(),
                ),

              );

            },


            child: Text(
              l.getStarted,
            ),

          ),

        ],

      ),

    );
  }




  Widget _buildIllustration(String type) {

    switch(type) {


      case 'welcome':
        return const WelcomeIllustration();


      case 'tasks':
        return const TasksIllustration();


      case 'motivation':
        return const MotivationIllustration();


      case 'workflow':
        return const WorkflowIllustration();


      default:
        return const SizedBox.shrink();

    }
  }




  @override
  Widget build(BuildContext context) {


    final l = AppLocalizations.of(context)!;


    return Scaffold(


      body: Container(


        decoration: const BoxDecoration(


          gradient: LinearGradient(

            begin: Alignment.topCenter,

            end: Alignment.bottomCenter,


            colors: [

              Color(0xFFFFF9F4),

              Colors.white,

            ],

          ),

        ),



        child: SafeArea(


          child: BlocBuilder<
              OnboardingCubit,
              OnboardingState>(


            builder: (context,state){



              if(state.pages.isEmpty){

                return const Center(

                  child:
                  CircularProgressIndicator(),

                );

              }



              return Column(



                children: [



                  Padding(


                    padding:
                    const EdgeInsets.all(16),


                    child: Align(


                      alignment:
                      Alignment.topRight,


                      child: TextButton(


                        onPressed: _finish,


                        child: Text(

                          l.skip,


                          style:
                          TextStyle(

                            color:
                            Colors.grey[600],

                            fontSize:14,

                          ),

                        ),

                      ),

                    ),

                  ),






                  Expanded(


                    child:
                    PageView.builder(


                      controller:
                      _pageController,


                      itemCount:
                      state.pages.length,



                      onPageChanged:(index){


                        context
                            .read<OnboardingCubit>()
                            .changePage(index);


                      },



                      itemBuilder:(context,index){



                        final page =
                        state.pages[index];




                        return OnboardingPage(



                          title:
                          _translate(
                            page.title,
                            l,
                          ),




                          description:
                          _translate(
                            page.description,
                            l,
                          ),




                          illustration:
                          _buildIllustration(
                            page.illustrationType,
                          ),


                        );


                      },

                    ),

                  ),







                  Padding(


                    padding:
                    const EdgeInsets.symmetric(
                        vertical:16),



                    child: Row(


                      mainAxisAlignment:
                      MainAxisAlignment.center,



                      children:

                      List.generate(


                        state.pages.length,


                            (index){


                          return AnimatedContainer(


                            duration:
                            const Duration(
                                milliseconds:300),



                            margin:
                            const EdgeInsets.symmetric(
                                horizontal:4),



                            height:6,



                            width:
                            state.currentPage == index
                                ? 32
                                : 6,



                            decoration:
                            BoxDecoration(


                              color:
                              state.currentPage == index
                                  ? const Color(0xFFD4AF7F)
                                  : Colors.grey[300],



                              borderRadius:
                              BorderRadius.circular(3),

                            ),

                          );


                        },

                      ),

                    ),

                  ),







                  Padding(


                    padding:
                    const EdgeInsets.fromLTRB(
                        32,
                        0,
                        32,
                        32),




                    child: SizedBox(


                      width:
                      double.infinity,



                      child:
                      ElevatedButton(



                        onPressed:(){


                          _nextPage(

                            state.currentPage,

                            state.pages.length,

                          );


                        },



                        style:
                        ElevatedButton.styleFrom(


                          backgroundColor:
                          const Color(0xFFD4AF7F),



                          foregroundColor:
                          Colors.white,



                          padding:
                          const EdgeInsets.symmetric(
                              vertical:16),



                          shape:
                          RoundedRectangleBorder(

                            borderRadius:
                            BorderRadius.circular(16),

                          ),


                        ),





                        child:Row(


                          mainAxisAlignment:
                          MainAxisAlignment.center,



                          children:[



                            Text(


                              state.currentPage ==
                                  state.pages.length - 1

                                  ? l.getStarted

                                  : l.continue1,



                              style:
                              const TextStyle(

                                fontSize:16,

                                fontWeight:
                                FontWeight.w600,

                              ),

                            ),




                            const SizedBox(
                              width:8,
                            ),




                            const Icon(
                              Icons.arrow_forward,
                              size:20,
                            ),



                          ],

                        ),

                      ),

                    ),

                  ),


                ],


              );

            },


          ),

        ),

      ),


    );

  }





  @override
  void dispose(){

    _pageController.dispose();

    super.dispose();

  }


}