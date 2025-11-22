import 'dart:developer' as developer;

/// Logger محسّن
class Logger {
  Logger._privateConstructor();
  static final Logger instance = Logger._privateConstructor();

  bool isEnabled = true;

  /// مستوى اللوق
  LogLevel minLevel = LogLevel.debug;

  /// لتحديد أي tags يتم تسجيلها (فارغ = كل الـ tags)
  List<String> allowedTags = [];

  /// --- دوال تسجيل ---
  void debug(String message, {String? tag}) => _log(message, LogLevel.debug, tag: tag);
  void info(String message, {String? tag}) => _log(message, LogLevel.info, tag: tag);
  void warn(String message, {String? tag}) => _log(message, LogLevel.warn, tag: tag);
  void error(String message, {String? tag, Object? error, StackTrace? stackTrace}) =>
      _log(message, LogLevel.error, tag: tag, error: error, stackTrace: stackTrace);

  void _log(String message, LogLevel level,
      {String? tag, Object? error, StackTrace? stackTrace}) {
    if (!isEnabled) return;
    if (level.index < minLevel.index) return;
    if (allowedTags.isNotEmpty && tag != null && !allowedTags.contains(tag)) return;

    developer.log(
      message,
      name: tag ?? level.name.toUpperCase(),
      level: level.value,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// --- لتسجيل دوال Sync ---
  T logFunction<T>(String name, T Function() action, {String? tag, LogLevel level = LogLevel.info}) {
    if (!isEnabled) return action();

    final start = DateTime.now();
    debug('➡️ Start: $name', tag: tag);

    T result;
    try {
      result = action();
    } catch (e, st) {
      error('❌ Error in $name', tag: tag, error: e, stackTrace: st);
      rethrow;
    }

    final duration = DateTime.now().difference(start);
    debug('✅ End: $name | Duration: ${duration.inMilliseconds}ms', tag: tag);
    return result;
  }

  /// --- لتسجيل دوال Async ---
  Future<T> logFunctionAsync<T>(String name, Future<T> Function() action,
      {String? tag, LogLevel level = LogLevel.info}) async {
    if (!isEnabled) return action();

    final start = DateTime.now();
    debug('➡️ Start: $name', tag: tag);

    T result;
    try {
      result = await action();
    } catch (e, st) {
      error('❌ Error in $name', tag: tag, error: e, stackTrace: st);
      rethrow;
    }

    final duration = DateTime.now().difference(start);
    debug('✅ End: $name | Duration: ${duration.inMilliseconds}ms', tag: tag);
    return result;
  }
}

/// مستويات اللوق
enum LogLevel {
  debug(500),
  info(800),
  warn(900),
  error(1000);

  final int value;
  const LogLevel(this.value);

  String get name => toString().split('.').last.toUpperCase();
}
