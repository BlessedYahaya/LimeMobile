import 'dart:io';

class API {
  static const String BASEURL = 'https://limeapiv1.herokuapp.com/api/mobile';
  Map<String, Object> handleError(error, StackTrace trace) {
    Map<String, dynamic> map = new Map();
    map['status'] = 'error';
    if (error is SocketException) {
      if (error.osError.errorCode == 8) {
        map['message'] = 'Please check your internet connection.';
      } else if (error.osError.errorCode == 61 ||
          error.osError.errorCode == 111) {
        map['message'] =
            'The server could not be reached, please try again later.';
      } else {
        map['message'] =
            'A network error prevented us from reaching the server, please try again later.';
      }
    }
    print(error);
    print(trace);
    return map;
  }
}
