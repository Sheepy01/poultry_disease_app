import 'dart:async';

import 'package:flutter/material.dart';

import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    super.initState();

    Timer(
      const Duration(seconds: 3),
          () {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const OnboardingScreen(),
          ),
        );

      },
    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            const Icon(
              Icons.pets,
              size: 100,
              color: Colors.teal,
            ),

            const SizedBox(height: 20),

            Text(
              "Poultry AI",
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const SizedBox(height: 10),

            const Text(
              "AI-powered Poultry Disease Detection",
            ),

            const SizedBox(height: 40),

            const CircularProgressIndicator(),

          ],

        ),

      ),

    );

  }

}