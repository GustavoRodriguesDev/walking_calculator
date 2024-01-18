class IFailure implements Exception {
  final String? message;
  final StackTrace? stackTrace;

  IFailure({required this.message, required this.stackTrace});
}
