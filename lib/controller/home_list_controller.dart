import 'dart:convert';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:play/models/video_model.dart';
import 'package:http/http.dart' as http;

class VideoApi {
  static Future<List<dynamic>?> getVideoList(
    int page,
    int limit,
  ) async {
    try {
      final response = await http.get(
        Uri.parse(
          'http://localhost:3000/api/v1/videos?'
          'page=$page'
          '&limit=$limit',
        ),
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final videos = jsonResponse['data'] as List;
        return videos.map((json) => Video.fromJson(json)).toList();
      }
    } catch (e) {
      print("Error while fetching videos $e");
    }
    return null;
  }
}

class HomeListController extends GetxController {
  RxInt selectedIndex = 0.obs;
  RxBool isLoading = false.obs;
  final videoLists = <Video>[].obs;
  final int _pageSize = 4;
  final PagingController<int, dynamic> pagingController =
      PagingController(firstPageKey: 1);

  HomeListController(){
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }

  Future<void> fetchPage(int pageKey) async {
    try {
      // get api /beers list from pages
      final newItems = await VideoApi.getVideoList(pageKey, _pageSize);
      // Check if it is last page
      final isLastPage = newItems!.length < _pageSize;
      // If it is last page then append
      // last page else append new page
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        // Appending new page when it is not last page
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    }
    // Handle error in catch
    catch (error) {
      final errorMessage = pagingController.error;
      print("Fetching getVideoList Error: $errorMessage");
      pagingController.error = error;
    }
  }

  void changeSelectIndex(int index) {
    selectedIndex.value = index;
  }
}
