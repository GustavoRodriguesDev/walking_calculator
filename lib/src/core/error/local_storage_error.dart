import 'i_failure.dart';

class LocalStorageReadError extends IFailure {
  LocalStorageReadError({
    required super.message,
    required super.stackTrace,
  });
}

class LocalStorageWriteError extends IFailure {
  LocalStorageWriteError({
    required super.message,
    required super.stackTrace,
  });
}

class LocalStorageRemoveError extends IFailure {
  LocalStorageRemoveError({
    required super.message,
    required super.stackTrace,
  });
}
