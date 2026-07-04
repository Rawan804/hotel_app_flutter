import 'package:flutter/material.dart';
import 'dart:math' as math;

class WorkflowIllustration extends StatefulWidget {
  const WorkflowIllustration({super.key});

  @override
  State<WorkflowIllustration> createState() => _WorkflowIllustrationState();
}

class _WorkflowIllustrationState extends State<WorkflowIllustration>
    with TickerProviderStateMixin {
  late AnimationController _bellController;
  late AnimationController _orbitController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _bellController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..repeat(reverse: true);

    _orbitController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _bellController.dispose();
    _orbitController.dispose();
    _pulseController.dispose();
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
          // Pulse rings
          ...List.generate(3, (index) {
            return AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                final delay = index * 0.3;
                final adjustedValue = ((_pulseController.value + delay) % 1.0);

                return Transform.scale(
                  scale: 0.5 + (adjustedValue * 1.5),
                  child: Opacity(
                    opacity: 0.5 - (adjustedValue * 0.5),
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFD4AF7F),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),

          // Central notification bell
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFD4AF7F), Color(0xFFB8935F)],
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFD4AF7F).withOpacity(0.4),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: AnimatedBuilder(
              animation: _bellController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: math.sin(_bellController.value * 2 * math.pi) * 0.3,
                  child: const Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 64,
                  ),
                );
              },
            ),
          ),

          // Notification badge
          Positioned(
            top: 75,
            right: 75,
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  '3',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // Orbiting task icons
          ...List.generate(4, (index) {
            return AnimatedBuilder(
              animation: _orbitController,
              builder: (context, child) {
                final angle = (index * 90.0 + _orbitController.value * 360) *
                    math.pi /
                    180;
                final radius = 100.0;
                final x = math.cos(angle) * radius;
                final y = math.sin(angle) * radius;

                return Transform.translate(
                  offset: Offset(x, y),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      color: Color(0xFFD4AF7F),
                      size: 24,
                    ),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
