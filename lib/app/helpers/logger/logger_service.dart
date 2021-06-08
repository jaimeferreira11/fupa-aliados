import 'package:logger/logger.dart';

class LoggerService {
  static LoggerService _singletonHttp;
  Logger _logger;

  factory LoggerService() {
    if (_singletonHttp == null) _singletonHttp = LoggerService._internal();
    return _singletonHttp;
  }
  LoggerService._internal() {
    _logger = Logger(
      filter: null,
    );
  }
  // interceptors

  Logger get logger => _logger;

  dispose() {
    _logger.close();
  }
}
