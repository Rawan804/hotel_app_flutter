import 'dart:async';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


import '../cubit/news_cubit.dart';
import 'card2.dart';
import 'cardNews.dart';

class Newscards extends StatefulWidget {
  const Newscards({super.key});

  @override
  State<Newscards> createState() => _NewscardsState();
}

class _NewscardsState extends State<Newscards> {
  final PageController controller = PageController(initialPage: 1000, viewportFraction: 0.92);
  final GlobalKey<FlipCardState> flipKey = GlobalKey<FlipCardState>();
  bool _run = false;
  final List<Timer> _timers = [];

  void _hint() {
    if (_run) return;
    _run = true;

    _timers.add(Timer(const Duration(milliseconds: 800), () {
      if (!mounted || !controller.hasClients) return;
      controller.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }));

    _timers.add(Timer(const Duration(milliseconds: 1600), () {
      if (!mounted) return;
      flipKey.currentState?.toggleCard();
    }));

    _timers.add(Timer(const Duration(milliseconds: 2800), () {
      if (!mounted) return;
      flipKey.currentState?.toggleCard();

      if (!controller.hasClients) return;
      controller.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }));
  }

  @override
  void dispose() {
    for (final t in _timers) {
      t.cancel();
    }
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        if (state is NewsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is NewsFail) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(state.message, textAlign: TextAlign.center),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => context.read<NewsCubit>().getAllNews(),
                  child: const Text("إعادة المحاولة"),
                ),
              ],
            ),
          );
        }
        if (state is NewsSuccess) {
          _hint();

          return Stack(
            children: [
              PageView.builder(
                controller: controller,
                itemBuilder: (context, index) {
                  final news = state.news[index % state.news.length];

                  return Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 45),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.90,
                        height: 204,
                        child: FlipCard(

                          key: index == 0 ? flipKey : GlobalKey(),
                          speed: 500,
                          direction: FlipDirection.HORIZONTAL,
                          front: NewsCardFront(news: news),
                          back: NewsCardBack(news: news),
                        ),
                      ),
                    ),
                  );
                },
              ),

              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: SmoothPageIndicator(
                    controller: controller,
                    count: state.news.length,
                    effect: ExpandingDotsEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      expansionFactor: 3,
                      activeDotColor: theme.colorScheme.primary,
                      dotColor: theme.colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}