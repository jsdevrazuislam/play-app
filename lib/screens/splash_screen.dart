import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:play/routes/route_constant.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Delay for 3 seconds before navigating to HomeScreen
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(RoutesName.homeScreen);
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(0.5, 1),
          colors: <Color>[
            Color(0xff000000),
            Color(0xffE50202),
          ],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image(
                fit: BoxFit.contain,
                width: 200.w,
                image: AssetImage("lib/assets/spalsh_logo.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
