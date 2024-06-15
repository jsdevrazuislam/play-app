import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play/controller/bottom_navigation_controller.dart';
import 'package:play/screens/library_screen.dart';
import 'package:play/screens/main_home_screen.dart';
import 'package:play/screens/short_screen.dart';
import 'package:play/screens/subscriptions_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BottomNavigationController bottomNavigationController =
      Get.put(BottomNavigationController());

  final bottomNavigation = const [
    MainHomeScreen(),
    ShortScreen(),
    SubscriptionsScreen(),
    LibraryScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: Obx(() {
        return bottomNavigation[bottomNavigationController.selectedIndex];
      }), bottomNavigationBar: Obx(() {
        return Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey, width: 0.5), // Top border
            ),
          ),
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(bottomNavigationController.selectedIndex == 0
                      ? Icons.home
                      : Icons.home_outlined),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(bottomNavigationController.selectedIndex == 1
                      ? Icons.video_collection
                      : Icons.video_collection_outlined),
                  label: 'Shorts'),
              BottomNavigationBarItem(
                  icon: Icon(bottomNavigationController.selectedIndex == 2
                      ? Icons.subscriptions_sharp
                      : Icons.subscriptions_outlined),
                  label: 'Subscriptions'),
              BottomNavigationBarItem(
                  icon: Icon(bottomNavigationController.selectedIndex == 3
                      ? Icons.history
                      : Icons.history_outlined),
                  label: 'Library'),
            ],
            currentIndex: bottomNavigationController.selectedIndex,
            onTap: (value) =>
                {bottomNavigationController.changeTabIndex(value)},
          ),
        );
      })),
    );
  }
}
