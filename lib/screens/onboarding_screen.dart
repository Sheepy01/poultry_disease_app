import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../utils/app_strings.dart';
import 'main_navigation.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,

            end: Alignment.bottomRight,

            colors: [Color(0xFFF4F7FB), Color(0xFFE6FFFA)],
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

                  children: [
                    OnboardPage(
                      image: 'assets/images/onboard_ai.png',

                      title: AppStrings.strings["onboarding_ai_title"]!,

                      description:
                          AppStrings.strings["onboarding_ai_description"]!,
                    ),

                    OnboardPage(
                      image: 'assets/images/onboard_scan.png',

                      title: AppStrings.strings["onboarding_scan_title"]!,

                      description:
                          AppStrings.strings["onboarding_scan_description"]!,
                    ),

                    OnboardPage(
                      image: 'assets/images/onboard_report.png',

                      title: AppStrings.strings["onboarding_report_title"]!,

                      description:
                          AppStrings.strings["onboarding_report_description"]!,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    TextButton(
                      onPressed: () {
                        controller.jumpToPage(2);
                      },

                      child: Text(AppStrings.strings["skip"]!),
                    ),

                    SmoothPageIndicator(
                      controller: controller,

                      count: 3,

                      effect: const ExpandingDotsEffect(
                        activeDotColor: Color(0xFF0F766E),

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
                              builder: (_) => const MainNavigation(),
                            ),
                          );
                        } else {
                          controller.nextPage(
                            duration: const Duration(milliseconds: 500),

                            curve: Curves.easeInOut,
                          );
                        }
                      },

                      child: Text(
                        isLastPage
                            ? AppStrings.strings["start"]!
                            : AppStrings.strings["next"]!,
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
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Expanded(child: Image.asset(image)),

          const SizedBox(height: 30),

          Text(
            title,

            textAlign: TextAlign.center,

            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
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
