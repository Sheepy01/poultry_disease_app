import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();

}

class _OnboardingScreenState
    extends State<OnboardingScreen> {

  final PageController controller =
  PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        decoration: const BoxDecoration(

          gradient: LinearGradient(

            begin: Alignment.topLeft,

            end: Alignment.bottomRight,

            colors: [
              Color(0xFFF4F7FB),
              Color(0xFFE6FFFA),
            ],

          ),

        ),

        child: SafeArea(

          child: Column(

            children: [

              Expanded(

                child: PageView(

                  controller: controller,

                  onPageChanged: (index) {

                    setState(() {
                      isLastPage = index == 2;
                    });

                  },

                  children: const [

                    OnboardPage(

                      image:
                      'assets/images/onboard_ai.png',

                      title:
                      'AI-powered Detection',

                      description:
                      'Analyze poultry disease patterns using offline AI image similarity analysis.',

                    ),

                    OnboardPage(

                      image:
                      'assets/images/onboard_scan.png',

                      title:
                      'Smart Disease Analysis',

                      description:
                      'Detect poultry diseases from uploaded images with explainable AI insights.',

                    ),

                    OnboardPage(

                      image:
                      'assets/images/onboard_report.png',

                      title:
                      'Generate Reports',

                      description:
                      'Export disease findings and recommendations as professional PDF reports.',

                    ),

                  ],

                ),

              ),

              Padding(

                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),

                child: Row(

                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

                  children: [

                    TextButton(

                      onPressed: () {

                        controller.jumpToPage(2);

                      },

                      child: const Text(
                        "Skip",
                      ),

                    ),

                    SmoothPageIndicator(

                      controller: controller,

                      count: 3,

                      effect: const ExpandingDotsEffect(

                        activeDotColor:
                        Color(0xFF0F766E),

                        dotHeight: 10,
                        dotWidth: 10,

                      ),

                    ),

                    ElevatedButton(

                      onPressed: () async {

                        if (isLastPage) {

                          Navigator.pushReplacement(

                            context,

                            MaterialPageRoute(
                              builder: (_) =>
                              const HomeScreen(),
                            ),

                          );

                        } else {

                          controller.nextPage(

                            duration:
                            const Duration(
                              milliseconds: 500,
                            ),

                            curve: Curves.easeInOut,

                          );

                        }

                      },

                      child: Text(
                        isLastPage
                            ? "Start"
                            : "Next",
                      ),

                    ),

                  ],

                ),

              ),

            ],

          ),

        ),

      ),

    );

  }

}

class OnboardPage extends StatelessWidget {

  final String image;

  final String title;

  final String description;

  const OnboardPage({

    super.key,

    required this.image,

    required this.title,

    required this.description,

  });

  @override
  Widget build(BuildContext context) {

    return Padding(

      padding: const EdgeInsets.all(30),

      child: Column(

        mainAxisAlignment:
        MainAxisAlignment.center,

        children: [

          Expanded(

            child: Image.asset(
              image,
            ),

          ),

          const SizedBox(height: 30),

          Text(

            title,

            textAlign: TextAlign.center,

            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),

          ),

          const SizedBox(height: 20),

          Text(

            description,

            textAlign: TextAlign.center,

            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade700,
              height: 1.5,
            ),

          ),

        ],

      ),

    );

  }

}