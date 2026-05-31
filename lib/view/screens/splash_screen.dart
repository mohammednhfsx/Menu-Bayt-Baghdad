import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:menubaghdad/view/screens/homepage.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
 
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
 
class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _dotsController;

 
  late Animation<double> _logoFade;
  late Animation<double> _logoScale;
  late Animation<double> _textFade;
  late Animation<Offset> _textSlide;

 
  @override
  void initState() {
    super.initState();
 
    // Logo animation
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _logoFade = CurvedAnimation(parent: _logoController, curve: Curves.easeIn);
    _logoScale = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );
 
    // Text animation
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _textFade = CurvedAnimation(parent: _textController, curve: Curves.easeIn);
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));
 
    // Dots animation (loading dots)
    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
 

    
 
    _startSequence();
  }
 
  Future<void> _startSequence() async {
    // 1. Show logo
    await Future.delayed(const Duration(milliseconds: 300));
    _logoController.forward();
 
    // 2. Show text
    await Future.delayed(const Duration(milliseconds: 600));
    _textController.forward();
 
    // 3. Wait a bit (simulating loading)
    await Future.delayed(const Duration(milliseconds: 2000));
 
    // 4. Fade out and navigate
    
 
    if (mounted) {
     Get.off(() => HomeScreen());
      
    }
  }
 
  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _dotsController.dispose();

    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _logoFade,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 75, 47, 31),
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Background image (food photo)
            Opacity(
              opacity: 0.45,
              child: Image.asset(
                'assets/image/splash.jpg',
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(color:const Color.fromARGB(255, 75, 47, 31),),
              ),
            ),
 
            // Dark gradient overlay
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xCC000000),
                    Color(0x88000000),
                    Color(0xCC000000),
                  ],
                ),
              ),
            ),
 
            // Content
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Top label
                  const Text(
                    'EST . BAGHDAD',
                    style: TextStyle(
                      color: Color(0xFFB0B0B0),
                      fontSize: 12,
                      letterSpacing: 4,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
 
                  const SizedBox(height: 48),
 
                  // Logo icon
                  ScaleTransition(
                    scale: _logoScale,
                    child: FadeTransition(
                      opacity: _logoFade,
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1C1400),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFFD4A017),
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.restaurant,
                          color: Color(0xFFD4A017),
                          size: 44,
                        ),
                      ),
                    ),
                  ),
 
                  const SizedBox(height: 28),
 
                  // Arabic title
                  SlideTransition(
                    position: _textSlide,
                    child: FadeTransition(
                      opacity: _textFade,
                      child: const Text(
                        'منيو بغداد',
                        style: TextStyle(
                          color: Color(0xFFD4A017),
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ),
 
                  const SizedBox(height: 10),
 
                  // Subtitle
                  FadeTransition(
                    opacity: _textFade,
                    child: const Text(
                      'نكهة عراقية أصيلة • تجربة فاخرة',
                      style: TextStyle(
                        color: Color(0xFFCCCCCC),
                        fontSize: 14,
                        letterSpacing: 1,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ],
              ),
            ),
 
            // Bottom loading dots
            Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  AnimatedBuilder(
                    animation: _dotsController,
                    builder: (_, _) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (i) {
                          final delay = i * 0.3;
                          final value = (_dotsController.value - delay).clamp(0.0, 1.0);
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Color.lerp(
                                const Color(0xFF555555),
                                const Color(0xFFD4A017),
                                value,
                              ),
                              shape: BoxShape.circle,
                            ),
                          );
                        }),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'جاري التحميل ...',
                    style: TextStyle(
                      color: Color(0xFF888888),
                      fontSize: 13,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
