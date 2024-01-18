import 'i_failure.dart';

class AdapterError extends IFailure {
  AdapterError({
    required super.message,
    required super.stackTrace,
  });
}
