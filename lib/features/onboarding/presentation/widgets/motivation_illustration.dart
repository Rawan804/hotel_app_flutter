import 'package:flutter/material.dart';
import 'dart:math' as math;

class MotivationIllustration extends StatefulWidget {
  const MotivationIllustration({super.key});

  @override
  State<MotivationIllustration> createState() => _MotivationIllustrationState();
}

class _MotivationIllustrationState extends State<MotivationIllustration>
    with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late AnimationController _confettiController;
  late AnimationController _rotateController;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _confettiController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _rotateController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _confettiController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Trophy/Achievement
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFD4AF7F), Color(0xFFB8935F)],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFD4AF7F).withOpacity(0.4),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: const Icon(
              Icons.auto_awesome,
              color: Colors.white,
              size: 64,
            ),
          ),

          // Team figures
          Positioned(
            bottom: 40,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (index) {
                return AnimatedBuilder(
                  animation: _bounceController,
                  builder: (context, child) {
                    final delay = index * 0.1;
                    final adjustedValue =
                        ((_bounceController.value + delay) % 1.0);
                    final bounce =
                        adjustedValue < 0.5 ? adjustedValue * 2 : 2 - adjustedValue * 2;

                    return Transform.translate(
                      offset: Offset(0, -5 * bounce),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFD4AF7F),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Color(0xFFD4AF7F),
                          size: 24,
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ),

          // Confetti particles
          ...List.generate(12, (index) {
            return AnimatedBuilder(
              animation: _confettiController,
              builder: (context, child) {
                final angle = (index * 30.0) * math.pi / 180;
                final distance = 60 + (index % 3) * 20.0;
                final x = math.cos(angle) * distance * _confettiController.value;
                final y = math.sin(angle) * distance * _confettiController.value -
                    (60 * _confettiController.value);

                return Transform.translate(
                  offset: Offset(x, y),
                  child: Transform.rotate(
                    angle: _confettiController.value * 2 * math.pi,
                    child: Opacity(
                      opacity: 1 - _confettiController.value,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: [
                            const Color(0xFFD4AF7F),
                            const Color(0xFFF5F0E1),
                            const Color(0xFFB8935F)
                          ][index % 3],
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),

          // Rotating star
          Positioned(
            top: 20,
            child: AnimatedBuilder(
              animation: _rotateController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotateController.value * 2 * math.pi,
                  child: Opacity(
                    opacity: 0.3,
                    child: const Icon(
                      Icons.auto_awesome,
                      color: Color(0xFFD4AF7F),
                      size: 32,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
