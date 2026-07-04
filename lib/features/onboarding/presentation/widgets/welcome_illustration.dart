import 'package:flutter/material.dart';

class WelcomeIllustration extends StatefulWidget {
  const WelcomeIllustration({super.key});

  @override
  State<WelcomeIllustration> createState() => _WelcomeIllustrationState();
}

class _WelcomeIllustrationState extends State<WelcomeIllustration>
    with TickerProviderStateMixin {
  late AnimationController _sparkleController;

  @override
  void initState() {
    super.initState();
    _sparkleController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _sparkleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 280,
      child: Stack(
        children: [
          // Hotel building
          Center(
            child: CustomPaint(
              size: const Size(280, 280),
              painter: HotelBuildingPainter(),
            ),
          ),

          // Sparkles
          ...List.generate(3, (index) {
            return AnimatedBuilder(
              animation: _sparkleController,
              builder: (context, child) {
                return Positioned(
                  top: 50 + (index * 70.0),
                  right: 30 + (index * 30.0),
                  child: Transform.rotate(
                    angle: _sparkleController.value * 6.28,
                    child: Opacity(
                      opacity: 0.5 +
                          0.5 *
                              (((_sparkleController.value + index * 0.3) % 1.0) *
                                  2 -
                                  1).abs(),
                      child: Icon(
                        Icons.auto_awesome,
                        color: const Color(0xFFD4AF7F),
                        size: 24 + (index * 4.0),
                      ),
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

class HotelBuildingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFF5F0E1)
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = const Color(0xFFD4AF7F)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Building
    final buildingRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.2, size.height * 0.25, size.width * 0.6,
          size.height * 0.65),
      const Radius.circular(8),
    );
    canvas.drawRRect(buildingRect, paint);
    canvas.drawRRect(buildingRect, strokePaint);

    // Windows
    final windowPaint = Paint()..color = const Color(0xFFD4AF7F);
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        final windowRect = RRect.fromRectAndRadius(
          Rect.fromLTWH(
            size.width * 0.3 + col * size.width * 0.125,
            size.height * 0.35 + row * size.height * 0.125,
            size.width * 0.075,
            size.height * 0.09,
          ),
          const Radius.circular(2),
        );
        canvas.drawRRect(windowRect, windowPaint);
      }
    }

    // Door
    final doorRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.425,
        size.height * 0.75,
        size.width * 0.15,
        size.height * 0.15,
      ),
      Radius.circular(size.width * 0.075),
    );
    canvas.drawRRect(doorRect, windowPaint);

    // Staff figure
    final staffPaint = Paint()..color = const Color(0xFFB8935F);
    canvas.drawCircle(
      Offset(size.width * 0.15, size.height * 0.7),
      size.width * 0.04,
      staffPaint,
    );
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.13,
        size.height * 0.74,
        size.width * 0.06,
        size.height * 0.125,
      ),
      Radius.circular(size.width * 0.03),
    );
    canvas.drawRRect(bodyRect, staffPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
