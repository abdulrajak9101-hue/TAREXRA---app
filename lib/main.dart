import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TarexraApp());
}

const navy = Color(0xFF050B20);
const darkBlue = Color(0xFF07152F);
const cardBg = Color(0xFF11264A);
const blue = Color(0xFF087BFF);
const cyan = Color(0xFF00D9FF);

class TarexraLogo extends StatelessWidget {
  final double size;
  final bool showGlow;

  const TarexraLogo({
    super.key,
    this.size = 120,
    this.showGlow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.18),
        boxShadow: showGlow
            ? [
                BoxShadow(
                  color: cyan.withOpacity(0.4),
                  blurRadius: size * 0.25,
                  spreadRadius: size * 0.03,
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size * 0.18),
        child: Image.asset(
          'assets/images/tarexra_logo.png',
          width: size,
          height: size,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: cardBg,
              alignment: Alignment.center,
              child: Icon(
                Icons.public,
                size: size * 0.55,
                color: cyan,
              ),
            );
          },
        ),
      ),
    );
  }
}

class TarexraApp extends StatelessWidget {
  const TarexraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TAREXRA',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: navy,
        colorScheme: const ColorScheme.dark(
          primary: blue,
          secondary: cyan,
          surface: cardBg,
        ),
      ),
      home: const SplashIntroScreen(),
    );
  }
}

class SplashIntroScreen extends StatefulWidget {
  const SplashIntroScreen({super.key});

  @override
  State<SplashIntroScreen> createState() => _SplashIntroScreenState();
}

class _SplashIntroScreenState extends State<SplashIntroScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );
    scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOutCubic),
    );
    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeIn),
    );
    controller.forward();
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WelcomePage()),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.2,
            colors: [Color(0xFF123D80), darkBlue, Color(0xFF020611)],
          ),
        ),
        child: FadeTransition(
          opacity: fadeAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TarexraLogo(size: 210, showGlow: true),
                SizedBox(height: 30),
                Text(
                  'TAREXRA',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 6,
                    color: Colors.white,
                    shadows: [Shadow(color: cyan, blurRadius: 25)],
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'TECHNOLOGY THAT MOVES HUMANITY FORWARD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    letterSpacing: 2,
                    color: cyan,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    animation = Tween<double>(begin: 0.97, end: 1.03).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.2,
            colors: [Color(0xFF123D80), darkBlue, Color(0xFF020611)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(),
              ScaleTransition(
                scale: animation,
                child: const TarexraLogo(size: 195, showGlow: true),
              ),
              const SizedBox(height: 30),
              const Text(
                'TAREXRA',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 6,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'TECHNOLOGY THAT MOVES HUMANITY FORWARD.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    letterSpacing: 2,
                    color: cyan,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'A Better World. A Smarter Future.',
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LanguagePage()),
                      );
                    },
                    child: const Text(
                      'ENTER TAREXRA  →',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                '© TAREXRA TECHNOLOGIES',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white54,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
