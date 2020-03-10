import 'dart:io';

class TLResponse {
  var message;
  var code;
  var data;
  var error;

  TLResponse({this.message = '', this.code = 200, this.data});

  @override
  String toString() {
    return 'LimeResponse{message: $message, code: $code, data: $data, error: $error}';
  }

  handleError(error, trace) {
    code = 500;
    message = 'An error occurred.';
    if (error is SocketException) {
      print('error message: ${error.message}');
      // errorCode == 8 means device is offline
      // errorCode == 61 or 111 means endpoint cannot be reached
      print('OS error code: ${error.osError.errorCode}');
      print('OS error message: ${error.osError.message}');
      if (error.osError.errorCode == 8) {
        message = 'Please check your internet connection.';
      } else if (error.osError.errorCode == 61 ||
          error.osError.errorCode == 111) {
        message = 'The server could not be reached, please try again later.';
      } else {
        message = 'A network error prevented us from reaching the server, please try again later.';
      }
    }

    print(error);
    print(trace);
  }

  bool get userError => code >= 400 && code < 500;

  bool get serverError => code >= 500 && code < 600;

  bool get success => code >= 100 && code < 400;
}
