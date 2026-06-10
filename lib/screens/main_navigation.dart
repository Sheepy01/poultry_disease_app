import 'package:flutter/material.dart';

import '../utils/app_strings.dart';
import 'home_screen.dart';
import 'disease_catalogue_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomeScreen(),

    const DiseaseCatalogueScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      body: IndexedStack(index: currentIndex, children: pages),

      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(30),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),

              blurRadius: 20,

              offset: const Offset(0, 8),
            ),
          ],
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),

          child: NavigationBar(
            backgroundColor: Colors.white,

            indicatorColor: Colors.teal.shade100,

            selectedIndex: currentIndex,

            height: 70,

            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,

            onDestinationSelected: (index) {
              setState(() {
                currentIndex = index;
              });
            },

            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.home_outlined),

                selectedIcon: const Icon(Icons.home),

                label: AppStrings.strings["home"]!,
              ),

              NavigationDestination(
                icon: const Icon(Icons.menu_book_outlined),

                selectedIcon: const Icon(Icons.menu_book),

                label: AppStrings.strings["catalogue"]!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
