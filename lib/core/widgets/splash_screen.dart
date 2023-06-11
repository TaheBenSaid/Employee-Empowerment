import 'dart:async';
import 'package:flutter/material.dart';

import '../../features/posts/presentation/pages/posts_page.dart';

void main() {
  runApp(SplashScreen());
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Gradient> _animation;
  String _displayText = '';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..forward();

    _animation = LinearGradientTween(
      begin: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.deepPurple, Colors.indigo],
      ),
      end: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.purple, Colors.blue],
      ),
    ).animate(_animationController);

    Timer(
      Duration(seconds: 5),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PostsPage(),
        ),
      ),
    );

    _animateText();
  }

  void _animateText() {
    const text = 'Employee Empowerment';
    int charIndex = 0;
    Timer.periodic(const Duration(milliseconds: 150), (timer) {
      if (charIndex < text.length) {
        setState(() {
          _displayText = text.substring(0, charIndex + 1);
        });
        charIndex++;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: _animation.value,
            ),
            child: Center(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Text(
                    _displayText,
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 600),
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LinearGradientTween extends Tween<Gradient> {
  LinearGradientTween({required Gradient begin, required Gradient end})
      : super(begin: begin, end: end);

  @override
  Gradient lerp(double t) => Gradient.lerp(begin as LinearGradient, end as LinearGradient, t)!;
}
