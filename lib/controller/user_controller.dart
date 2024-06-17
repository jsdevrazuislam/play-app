import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  RxString userId = ''.obs;
  RxString username = ''.obs;
  RxString email = ''.obs;
  RxString fullName = ''.obs;
  RxString avatar = ''.obs;
  RxString accessToken = ''.obs;
  RxString refreshToken = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> saveUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('userId', userData['user']['_id']);
    await prefs.setString('username', userData['user']['username']);
    await prefs.setString('email', userData['user']['email']);
    await prefs.setString('fullName', userData['user']['fullName']);
    await prefs.setString('avatar', userData['user']['avatar']);
    await prefs.setString('accessToken', userData['accessToken']);
    await prefs.setString('refreshToken', userData['refreshToken']);

    // Update reactive properties
    userId.value = userData['user']['_id'];
    username.value = userData['user']['username'];
    email.value = userData['user']['email'];
    fullName.value = userData['user']['fullName'];
    avatar.value = userData['user']['avatar'];
    accessToken.value = userData['accessToken'];
    refreshToken.value = userData['refreshToken'];
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    userId.value = prefs.getString('userId') ?? '';
    username.value = prefs.getString('username') ?? '';
    email.value = prefs.getString('email') ?? '';
    fullName.value = prefs.getString('fullName') ?? '';
    avatar.value = prefs.getString('avatar') ?? '';
    accessToken.value = prefs.getString('accessToken') ?? '';
    refreshToken.value = prefs.getString('refreshToken') ?? '';
  }

  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Clear reactive properties
    userId.value = '';
    username.value = '';
    email.value = '';
    fullName.value = '';
    avatar.value = '';
    accessToken.value = '';
    refreshToken.value = '';
  }
}
