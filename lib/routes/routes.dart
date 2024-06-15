import 'package:get/get.dart';
import 'package:play/routes/route_constant.dart';
import 'package:play/screens/home_screen.dart';
import 'package:play/screens/splash_screen.dart';

final List<GetPage<dynamic>> getPages= [
  GetPage(name: RoutesName.splashScreen, page: () => SplashScreen()),
  GetPage(name: RoutesName.homeScreen, page: () => HomeScreen()),
];