import 'package:flutter/foundation.dart';

class AppConstants {
  static const API_URL = kReleaseMode
      ? 'https://apps.fundacionparaguaya.org.py/fupapp-rest/'
      : 'http://10.1.11.3:8080/fupapp-rest/';

  static const CLIENT_SECRET = 'clientAliados:secret';

  static const EMAIL_ADMIN = 'appfupa@fundacionparaguaya.org.py';
}
