import 'dart:async';

import 'package:flutter/material.dart';

import 'home_page.dart';
import 'news_models.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                 HomePage(
                 )
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child:Image.asset(
        'lib/assets/image/n logo.png',
        color: Colors.white,
      ),
    );
  }
}
