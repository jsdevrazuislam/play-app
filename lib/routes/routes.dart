import 'package:get/get.dart';
import 'package:play/routes/route_constant.dart';
import 'package:play/screens/home_screen.dart';
import 'package:play/screens/login_screen.dart';
import 'package:play/screens/signup_screen.dart';
import 'package:play/screens/splash_screen.dart';

final List<GetPage<dynamic>> getPages = [
  GetPage(name: RoutesName.splashScreen, page: () => SplashScreen()),
  GetPage(name: RoutesName.homeScreen, page: () => const HomeScreen()),
  GetPage(name: RoutesName.loginScreen, page: () => const LoginScreen()),
  GetPage(name: RoutesName.signUpScreen, page: () => const SignUpScreen()),
];
