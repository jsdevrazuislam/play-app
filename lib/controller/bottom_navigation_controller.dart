import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  RxInt _tabIndex = 0.obs;

  int get selectedIndex => _tabIndex.value;

  void changeTabIndex(value) {
    _tabIndex.value = value;
  }
}
