import 'dart:convert';
import 'package:get/get.dart';
import 'package:play/controller/socket_controller.dart';
import 'package:play/models/like_video_model.dart';
import 'package:play/models/video_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ReactiveSocketService extends GetxService {
  Rx<SocketService?> socketService = Rx<SocketService?>(null);
}

class VideoController extends GetxController {
  late VideoPlayerController videoPlayerController;
  final isInitialized = false.obs;
  final isLoading = false.obs;
  final isPlaying = false.obs;
  final position = Duration.zero.obs;
  final duration = Duration.zero.obs;
  final errorMessage = ''.obs;
  final totalChannelSubscribersCount = 0.obs;
  final comment = ''.obs;
  final video = Video(
    sId: '',
    videoFile: '',
    thumbnail: '',
    title: '',
    description: '',
    duration: '',
    views: 0,
    isPublished: false,
    createdAt: '',
    updatedAt: '',
    owner: Owner(sId: '', username: '', email: '', fullName: '', avatar: ''),
  ).obs;
  final likesVideos = <LikesVideo>[].obs;
  final likeCount = 0.obs;
  final dislikeCount = 0.obs;
  final isLike = false.obs;
  final isDislike = false.obs;
  final videoId = ''.obs;
  final reactiveSocketService = Get.find<ReactiveSocketService>();
  String? channelUserName;
  String? token;
  String? userId;

  @override
  void onInit() async {
    super.onInit();
    await _loadToken();
    videoId.value = Get.arguments['videoId'];
    channelUserName = Get.arguments['channelUserName'] as String?;
    if (videoId.value != '') {
      getLikedCount(videoId.value);
      fetchVideo(videoId.value);
      fetchSubscriber();
    }
    if (channelUserName != null) {
      fetchSubscriber();
    }

    reactiveSocketService.socketService.value = Get.find<SocketService>();
  }

  @override
  void onReady() {
    super.onReady();
    everAll([reactiveSocketService.socketService, videoId],
        (_) => setupSocketListeners());
    ever(
        likesVideos,
        (callback) => {
              likesVideos.forEach((video) {
                if (hasLikedVideo(video)) {
                  isLike.value = true;
                  isDislike.value = false;
                } else if (hasDislikedVideo(video)) {
                  isDislike.value = true;
                  isLike.value = false;
                }
              })
            });
  }

  void setupSocketListeners() {
    final service = reactiveSocketService.socketService.value;
    if (reactiveSocketService.socketService.value == null ||
        videoId.value.isEmpty) {
      print("SocketService or videoId is not initialized");
      return;
    }

    service?.joinRoom(videoId.value);

    service?.addListener(SocketEventEnum.ADD_VIDEO_COMMENT, addVideoComment);
    service?.addListener(SocketEventEnum.ADDED_LIKE, addLike);
    service?.addListener(SocketEventEnum.ADDED_DISLIKE, addDislike);
    print('working');
  }

  Future<void> fetchVideo(String videoId) async {
    isLoading(true);
    try {
      final response = await http.get(
        Uri.parse('http://localhost:3000/api/v1/videos/$videoId'),
      );
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        video.value = Video.fromJson(jsonData['data']);
      } else {
        errorMessage('Failed to load video');
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchSubscriber() async {
    isLoading(true);
    try {
      final response = await http.get(
        Uri.parse(
            'http://localhost:3000/api/v1/users/get-user-channel/$channelUserName'),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        totalChannelSubscribersCount.value =
            jsonData['data']['totalChannelSubscribersCount'];
      } else {
        errorMessage('Failed to load fetch subscriber');
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> toggleSubscriber(channelId) async {
    isLoading(true);
    try {
      final response = await http.get(
        Uri.parse('http://localhost:3000/api/v1/subscriptions/c/$channelId'),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        totalChannelSubscribersCount.value =
            jsonData['data']['totalChannelSubscribersCount'];
      } else {
        errorMessage('Failed to load fetch subscriber');
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> handleToggleLike(String videoId, String action) async {
    isLoading(true);
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/v1/likes/toggle/v/$videoId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
          'reaction': action,
        }),
      );
      final responseJson = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print('handle toggle like and dislike Success');
      } else {
        print(responseJson);
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> getLikedCount(String videoId) async {
    isLoading(true);
    try {
      final response = await http
          .get(Uri.parse('http://localhost:3000/api/v1/likes/video/$videoId'));
      final responseJson = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final likes = responseJson['data']["likesVideo"] as List;
        final totalLike = responseJson['data']['totalLikes'];
        final totalUnlike = responseJson['data']['totalDislikes'];
        likesVideos.value =
            likes.map((json) => LikesVideo.fromJson(json)).toList();
        likeCount.value = totalLike;
        dislikeCount.value = totalUnlike;
      } else {
        print(responseJson);
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  String getTimeAgo(String? createdAt) {
    if (createdAt == null) return 'Unknown';

    try {
      print('createdAt: $createdAt'); // Log the createdAt value

      final createdAtDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ")
          .parse(createdAt, true)
          .toLocal();
      final now = DateTime.now();
      final difference = now.difference(createdAtDate);

      if (difference.inDays > 0) {
        return '${difference.inDays} days ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hours ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minutes ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return 'Invalid date format';
    }
  }

  void initializeVideo(String url) {
    try {
      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url))
        ..initialize().then((_) {
          isInitialized.value = true;
          duration.value = videoPlayerController.value.duration;
          videoPlayerController.addListener(_updatePosition);
          isPlaying.value = videoPlayerController.value.isPlaying;
        }).catchError((error) {
          errorMessage.value = 'Error initializing video: $error';
          print(errorMessage.value);
        });
    } catch (e) {
      errorMessage.value = 'Error creating VideoPlayerController: $e';
      print(errorMessage.value);
    }
  }

  void _updatePosition() {
    position.value = videoPlayerController.value.position;
  }

  void playPauseVideo() {
    if (videoPlayerController.value.isPlaying) {
      videoPlayerController.pause();
      isPlaying.value = false;
    } else {
      videoPlayerController.play();
      isPlaying.value = true;
    }
  }

  void addVideoComment(dynamic data) {
    print('Video comment added: $data');
  }

  void addDislike(dynamic data) {
    print('Dislike added');
    final like = LikesVideo.fromJson(data['like']);
    final totalLike = data['totalLike'];
    final totalUnlike = data['totalUnlike'];

    if (!likesVideos.any((v) => v.sId == like.sId)) {
      likesVideos.insert(0, like);
    }

    likeCount.value = totalLike;
    dislikeCount.value = totalUnlike;

    if (hasLikedVideo(like)) {
      isLike.value = true;
      isDislike.value = false;
    } else if (hasDislikedVideo(like)) {
      isDislike.value = true;
      isLike.value = false;
    }
  }

  void addLike(dynamic data) {
    print('like data');
    final like = LikesVideo.fromJson(data['like']);
    final totalLike = data['totalLike'];
    final totalUnlike = data['totalUnlike'];

    if (!likesVideos.any((v) => v.sId == like.sId)) {
      likesVideos.insert(0, like);
    }

    likeCount.value = totalLike;
    dislikeCount.value = totalUnlike;

    if (hasLikedVideo(like)) {
      isLike.value = true;
      isDislike.value = false;
    } else if (hasDislikedVideo(like)) {
      isDislike.value = true;
      isLike.value = false;
    }
  }

  bool hasLikedVideo(LikesVideo video) {
    return video.likedBy!.any((likeUser) => likeUser.sId == userId);
  }

  bool hasDislikedVideo(LikesVideo video) {
    return video.disLikedBy!.any((dislikeUser) => dislikeUser.sId == userId);
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('accessToken') ?? '';
    userId = prefs.getString('userId') ?? '';
  }

  @override
  void onClose() {
    videoPlayerController.removeListener(_updatePosition);
    videoPlayerController.dispose();
    super.onClose();
    if (reactiveSocketService.socketService.value != null) {
      reactiveSocketService.socketService.value!
          .removeListener(SocketEventEnum.ADD_VIDEO_COMMENT, addVideoComment);
      reactiveSocketService.socketService.value!
          .removeListener(SocketEventEnum.ADDED_LIKE, addLike);
      reactiveSocketService.socketService.value!
          .removeListener(SocketEventEnum.ADDED_DISLIKE, addDislike);
    }
  }
}
