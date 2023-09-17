class Result<T> {
  late ResultType type;
  late String message;
  int? statusCode;
  T? data;

  Result(this.type, this.message, {this.statusCode, this.data});
}
enum ResultType { Success, Warning, Error, TokenExpired }

extension ResultTypeExtension on ResultType {
  String get value {
    switch (this) {
      case ResultType.Success:
        return 'success';
      case ResultType.Warning:
        return 'warning';
      case ResultType.Error:
        return 'error';
      case ResultType.TokenExpired:
        return 'session_expired';
      default:
        return '';
    }
  }
}