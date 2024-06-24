import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:play/models/category.model.dart';
import 'package:play/models/comments_model.dart';
import 'package:play/models/video_model.dart';
import 'package:http/http.dart' as http;

class VideoApi {
  static Future<List<dynamic>?> getVideoList(
    int page,
    int limit,
    String category
  ) async {
    try {
      final uri = Uri.parse(
        'http://localhost:3000/api/v1/videos?'
        'page=$page'
        '&limit=$limit'
        '${category.isNotEmpty ? '&category=$category' : ''}',
      );
      final response = await http.get(uri);
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

  static Future<List<Comments>?> getVideoComments(
      int page, int limit, String videoId) async {
    try {
      final response = await http.get(
        Uri.parse(
          'http://localhost:3000/api/v1/comments/$videoId?'
          'page=$page'
          '&limit=$limit',
        ),
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final videoComments = jsonResponse['data']["comments"] as List;
        return videoComments.map((json) => Comments.fromJson(json)).toList();
      }
    } catch (e) {
      print("Error while fetching comments $e");
    }
    return null;
  }
}

class HomeListController extends GetxController {
  RxInt selectedIndex = 0.obs;
  RxString selectCategory = ''.obs;
  RxBool isLoading = false.obs;
  final videoLists = <Video>[].obs;
  final categories = <Category>[].obs;
  final int _pageSize = 4;
  final PagingController<int, dynamic> pagingController =
      PagingController(firstPageKey: 1);

  HomeListController() {
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
  }

  @override
  void onInit(){
    super.onInit();
    getCategories();
  }

@override
void onReady(){
  super.onReady();
  ever(selectCategory, (callback) => {
    pagingController.refresh()
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
      final newItems = await VideoApi.getVideoList(pageKey, _pageSize, selectCategory.value);
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

  Future<void> getCategories() async {
    isLoading(true);
    try {
      final response = await http.get(
        Uri.parse('http://localhost:3000/api/v1/categories'),
      );
      final responseJson = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final categoriesList = responseJson['data'] as List;
        categories.value =
            categoriesList.map((json) => Category.fromJson(json)).toList();
        print('fetch categories Success');
      } else {
        print(responseJson);
      }
    } catch (e) {
      print("Error while geting category");
    }
  }

  void changeSelectIndex(int index, category) {
    selectedIndex.value = index;
    selectCategory.value = category;
  }
}
