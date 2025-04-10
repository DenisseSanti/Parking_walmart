import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class RabbitMQService {
  static StompClient? _client;
  static Function(String)? onMessage;

  static void connect() {
    _client = StompClient(
      config: StompConfig.SockJS(
        url: 'http://192.168.1.66:15674/stomp',
        onConnect: _onConnect,
        onWebSocketError: (error) => print('WebSocket error: $error'),
        stompConnectHeaders: {'login': 'guest', 'passcode': 'guest'},
      ),
    );
    _client!.activate();
  }

  static void _onConnect(StompFrame frame) {
    _client!.subscribe(
      destination: '/queue/parking',
      callback: (StompFrame frame) {
        if (frame.body != null && onMessage != null) {
          onMessage!(frame.body!);
        }
      },
    );
  }

  static void disconnect() {
    _client?.deactivate();
  }
}
