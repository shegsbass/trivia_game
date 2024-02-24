import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  String? message;
  DioExceptions.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.connectionError:
        message = "Connection to API server failed due to internet connection";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        if (dioException.response!.data != null) {
          final messageMap = _handleError(
              dioException.response!.statusCode!, dioException.response!.data);
          // print(messageMap.toString());
          message = messageMap['message'];
        } else {
          final messageMap = _handleError(
              dioException.response!.statusCode!, dioException.error);

          message = messageMap['message'];
        }
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioExceptionType.unknown:
      //print('Dio: ${dioException.error.toString()}');
        message = "An unknown error occurred with API server";
        break;
      case DioExceptionType.badCertificate:
        message = "SSL certificate error occurred";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  _handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
      // List<String> msg = [];
      // if (error['errors'].isNotEmpty || error['errors'] != null) {
      //   for (var e in error['errors']) {
      //     msg.add(e['msg']);
      //   }
      //   return msg.toString();
      // }
      // if (error['errors'].isEmpty || error['errors'] == null) {
      //   return error.toString();
      // }
      // return null;
        return error;

      case 401:
        return error;
      case 500:
        return error;
      default:
        return error;
    }
  }

  @override
  String toString() => message!;
}
