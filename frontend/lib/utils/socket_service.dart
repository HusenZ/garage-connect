import 'package:garage_app/private.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void initSocket(String userId) {
    socket = IO.io('http://$ip:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.onConnect((_) {
      print('Connected to socket');
      socket.emit('join_room', 'user_$userId');
    });

    socket.on('BOOKING_STATUS_UPDATE', (data) {
      print('Booking status updated: $data');
      // You can trigger a state update or notification
    });

    socket.onDisconnect((_) => print('Disconnected from socket'));
  }

  void dispose() {
    socket.disconnect();
  }
}
