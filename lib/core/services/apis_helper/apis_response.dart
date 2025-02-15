class ApiResponse<T> {
  T? data;
  String? statusCode;
  bool? success;
  String? statusMessage;

  ApiResponse({
    this.data,
    this.statusCode,
    this.success,
    this.statusMessage,
  });

  @override
  String toString() {
    return 'ApiResponse<$T>{data: $data, statusCode: $statusCode, success: $success, statusMessage: $statusMessage}';
  }

  factory ApiResponse.fromError(String message, String statusCode) {
    return ApiResponse(
      success: false,
      statusCode: statusCode,
      statusMessage: message,
    );
  }
}
