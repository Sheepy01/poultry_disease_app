import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';
import 'utils/app_theme.dart';

void main() {

  runApp(const PoultryDiseaseApp());

}

class PoultryDiseaseApp extends StatelessWidget {

  const PoultryDiseaseApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'Poultry Disease Detection',

      theme: AppTheme.lightTheme,

      home: const SplashScreen(),

    );

  }

}