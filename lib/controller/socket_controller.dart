import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketEventEnum {
  static const String SOCKET_CONNECTED = 'connected';
  static const String SOCKET_DISCONNECTED = 'disconnect';
  static const String ADD_VIDEO_COMMENT = 'addVideoComment';
  static const String UPDATE_VIDEO_COMMENT = 'updateVideoComment';
  static const String ADD_TWEET_COMMENT = 'addTweetComment';
  static const String UPDATE_TWEET_COMMENT = 'updateTweetComment';
  static const String PUBLISH_VIDEO = 'publishVideo';
  static const String JOIN_COMMENT = 'joinComment';
  static const String JOIN_NOTIFICATION = 'joinNotification';
  static const String SOCKET_ERROR = 'socketError';
  static const String JOIN_LIKE = 'joinLike';
  static const String JOIN_DISLIKE = 'joinDislike';
  static const String ADDED_LIKE = 'addedLike';
  static const String ADDED_DISLIKE = 'addedDislike';
  static const String REMOVE_REACTION = 'removeReaction';
  static const String JOIN_VIDEO = 'joinVideo';
  static const String REMOVE_COMMENT_REACTION = 'removeCommentReaction';
  static const String COMMENT_LIKE = 'commentLike';
  static const String COMMENT_DISLIKE = 'commentDislike';
  static const String JOIN_CHANNEL = 'joinChannel';
  static const String ADD_SUBSCRIBER = 'addSubscriber';
  static const String REMOVE_SUBSCRIBER = 'removeSubscriber';
}

class SocketService extends GetxService {
 late IO.Socket socket;
late String token;

  Future<SocketService> init() async {
    await _loadToken();

    socket = IO.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'withCredentials': true,
      'auth': {
        'token': token,
      },
    });

    socket.connect();


    socket.on(SocketEventEnum.SOCKET_CONNECTED, (_) {
      print('connected');
    });

    socket.on(SocketEventEnum.SOCKET_DISCONNECTED, (_) {
      print('disconnected');
    });

    return this;
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('accessToken') ?? '';
  }

  void joinRoom(String videoId) {
    socket.emit(SocketEventEnum.JOIN_VIDEO, videoId);
    socket.emit(SocketEventEnum.JOIN_CHANNEL, videoId);
  }

  void addListener(String event, Function(dynamic) callback) {
    socket.on(event, callback);
  }

  void removeListener(String event, Function(dynamic) callback) {
    socket.off(event, callback);
  }

  void disconnect() {
    socket.disconnect();
  }
}
