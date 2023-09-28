import 'package:flutter/material.dart';
import 'package:sitizenship_bloc/screen/homepage.dart';
import 'package:vibration/vibration.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double buttonOffset = 0.0;

  // static Future<bool?> vibration() async {
  //   final hasVibrator = await Vibration.hasVibrator();
  //   if (hasVibrator != null && hasVibrator) {
  //     Vibration.vibrate(duration: 1000);
  //   }
  //   return null;

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width - 150;
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "assets/images/splash.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onPanUpdate: (details) {
                if (details.delta.dx > 0 && buttonOffset <= buttonWidth - 70) {
                  setState(() {
                    buttonOffset += details.delta.dx;
                  });
                }
              },
              onPanEnd: (_) {
                if (buttonOffset > buttonWidth / 2) {
                  setState(() {
                    buttonOffset = buttonWidth - 20;
                  });
                  Vibration.vibrate(duration: 200);
                } else {
                  setState(() {
                    buttonOffset = 0.0;
                  });
                }
                Navigator.of(context).pushReplacement(_createRoute());
              },
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: buttonWidth, // Заполняем всю доступную ширину
                  height: 65,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Stack(
                    children: [
                      AnimatedContainer(
                        width: buttonOffset +
                            70, // Увеличиваем ширину анимированного контейнера
                        height: 70,
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade500,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Align(
                          alignment: Alignment
                              .centerRight, // Выравниваем по левому краю
                          child: Container(
                            width: 70,
                            height: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.swipe_right_sharp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center, // Выравниваем по центру
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            "Get Started",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
        transitionDuration: const Duration(seconds: 1),
        pageBuilder: (context, animation, secondaryAnimation) => HomeWidget(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        });
  }
}
