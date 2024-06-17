import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:play/controller/user_controller.dart';
import 'package:play/routes/route_constant.dart';

Future<dynamic> logStreamedResponse(http.StreamedResponse response) async {
  // Convert the streamed response to a string
  final responseBody = await response.stream.bytesToString();
  // Log the response body
  print('Response Body: $responseBody');
  return jsonDecode(responseBody);
}

class LoginController extends GetxController {
  RxString username = ''.obs;
  RxString fullName = ''.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;
  XFile? avatar;
  RxBool isAvatar = false.obs;
  RxBool isLoading = false.obs;
  final UserController userController = Get.put(UserController());

  void pickFile() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        avatar = pickedFile;
        isAvatar.value = true;
        update();
      } else {
        print('No file selected');
      }
    } catch (e) {
      print('Error while pick file $e');
    }
  }

  void register() async {
    isLoading.value = true;
    try {
      final request = await http.MultipartRequest(
          'POST', Uri.parse('http://localhost:3000/api/v1/users/register'));
      request.fields['username'] = username.value;
      request.fields['password'] = password.value;
      request.fields['fullName'] = fullName.value;
      request.fields['email'] = email.value;
      request.files
          .add(await http.MultipartFile.fromPath('avatar', avatar!.path));
      final response = await request.send();
      final responseJson = await logStreamedResponse(response);
      if (response.statusCode == 201) {
        Get.snackbar('Successfully', 'Register Complete');
        Get.offNamed(RoutesName.loginScreen);
      } else {
        Get.snackbar('Error', responseJson['message']);
        isLoading.value = false;
      }
    } catch (e) {
      print('Error while register user $e');
      isLoading.value = false;
    }
  }

  void login() async {
    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/v1/users/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email.value,
          'password': password.value,
        }),
      );
      final responseJson = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        await userController.saveUserData(responseBody['data']);
        Get.snackbar('Successfully', 'Login Complete');
        Get.offNamed(RoutesName.homeScreen);
      } else {
        Get.snackbar('Error', responseJson['message']);
        print(responseJson);
        isLoading.value = false;
      }
    } catch (e) {
      print('Error while login user $e');
      isLoading.value = false;
    }
  }
}
