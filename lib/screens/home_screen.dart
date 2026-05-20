import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'detection_screen.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(20),

          child: Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              const SizedBox(height: 10),

              Text(
                "Poultry AI",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "AI-assisted Poultry Disease Detection & Awareness System",
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 30),

              Container(

                width: double.infinity,

                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(

                  borderRadius:
                  BorderRadius.circular(30),

                  gradient: const LinearGradient(

                    begin: Alignment.topLeft,

                    end: Alignment.bottomRight,

                    colors: [
                      Color(0xFF0F766E),
                      Color(0xFF14B8A6),
                    ],

                  ),

                  boxShadow: [

                    BoxShadow(
                      color: Colors.teal.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),

                  ],

                ),

                child: Column(

                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    const Icon(
                      Icons.health_and_safety,
                      color: Colors.white,
                      size: 60,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Smart Poultry Disease Analysis",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      "Detect poultry diseases using AI-powered image similarity analysis.",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 24),

                    ElevatedButton(

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primary,
                      ),

                      onPressed: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const DetectionScreen(),
                          ),
                        );

                      },

                      child: const Text(
                        "Start Detection",
                      ),

                    ),

                  ],

                ),

              ),

              const SizedBox(height: 30),

              const Text(
                "Disease Awareness",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              _buildInfoCard(
                title: "Newcastle Disease",
                icon: Icons.coronavirus,
                color: Colors.red,
                description:
                "Highly contagious viral disease causing respiratory and neurological symptoms in poultry.",
              ),

              const SizedBox(height: 20),

              _buildInfoCard(
                title: "AI-based Detection",
                icon: Icons.psychology,
                color: Colors.teal,
                description:
                "This app uses AI-powered image similarity analysis for poultry disease identification.",
              ),

            ],

          ),

        ),

      ),

    );

  }

  Widget _buildInfoCard({

    required String title,

    required String description,

    required IconData icon,

    required Color color,

  }) {

    return Container(

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(24),

        boxShadow: [

          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),

        ],

      ),

      child: Row(

        children: [

          Container(

            padding: const EdgeInsets.all(14),

            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),

            child: Icon(
              icon,
              color: color,
              size: 30,
            ),

          ),

          const SizedBox(width: 20),

          Expanded(

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    height: 1.5,
                  ),
                ),

              ],

            ),

          ),

        ],

      ),

    );

  }

}