import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  late IO.Socket socket;

  factory SocketService() {
    return _instance;
  }

  SocketService._internal() {
    // Initialize Socket.IO client
    socket = IO.io('http://10.0.2.2:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.on('connect', (_) {
      print('Connected to server');
    });

    socket.on('disconnect', (_) {
      print('Disconnected from server');
    });

    socket.connect();
  }

  void emit(String event, dynamic data) {
    socket.emit(event, data);
  }

  void dispose() {
    socket.disconnect();
  }
}
