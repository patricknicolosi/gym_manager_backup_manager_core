import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class BackupApiService {
  String _IP = "127.0.0.1";
  int _PORT = 3002;

  Dio dio = Dio(BaseOptions())
    ..httpClientAdapter = IOHttpClientAdapter(
      onHttpClientCreate: (client) {
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      },
    );

  BackupApiService._privateConstructor();

  static final BackupApiService _instance =
      BackupApiService._privateConstructor();

  static BackupApiService getInstance() {
    return _instance;
  }

  void setIP(String IP) {
    _IP = IP;
  }

  void setPORT(int PORT) {
    _PORT = PORT;
  }

  String getIP() {
    return _IP;
  }

  int getPORT() {
    return _PORT;
  }
}
