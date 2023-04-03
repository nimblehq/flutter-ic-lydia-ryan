import 'package:flutter_config/flutter_config.dart';

class Env {
  static String get restApiEndpoint {
    return FlutterConfig.get('REST_API_ENDPOINT');
  }

  static String get authClientId {
    return FlutterConfig.get('KEY');
  }

  static String get authClientSecret {
    return FlutterConfig.get('SECRET');
  }
}
