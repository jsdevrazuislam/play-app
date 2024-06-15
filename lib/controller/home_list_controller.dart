import 'dart:convert';
import 'package:get/get.dart';
import 'package:play/models/video_model.dart';
import 'package:http/http.dart' as http;

class HomeListController extends GetxController {
  RxInt selectedIndex = 0.obs;
  RxBool isLoading = false.obs;
  final videoLists = <Video>[].obs;

  // @override
  void onInit() {
    fetchVideos();
    super.onInit();
  }

  void fetchVideos() async {
    try {
      isLoading.value = true;
      final response =
          await http.get(Uri.parse("http://localhost:3000/api/v1/videos"));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final videos = jsonResponse['data'] as List;
        videoLists.value =
            videos.map((video) => Video.fromJson(video)).toList();
      } else {
        print('Error: ${response}');
      }
    } catch(e){
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void changeSelectIndex(int index) {
    selectedIndex.value = index;
  }
}
