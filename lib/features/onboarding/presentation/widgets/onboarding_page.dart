import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final Widget illustration;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.illustration,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
      ),
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: [

          /// Illustration
          Expanded(
            flex: 3,
            child: Center(
              child: illustration,
            ),
          ),

          /// Text Content
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(
                  title,
                  textAlign:
                  TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(
                    fontSize: 28,
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                Text(
                  description,
                  textAlign:
                  TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}