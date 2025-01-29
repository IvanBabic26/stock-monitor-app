import 'package:dio/dio.dart';

class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      /// If there is time, make mock token refresh/store action
//       if (authToken != null) {
//         options.headers[HttpHeaders.authorizationHeader] =
//             'Bearer ${authToken.token}';

      // }
      handler.next(options);
    } catch (e) {
      handler.reject(DioException(requestOptions: options, error: e));
    }
  }

  @override
  void onError(DioException error, ErrorInterceptorHandler handler) async {
    if (error.type == DioExceptionType.badResponse &&
        error.response!.statusCode == 401) {
      /// If there is time, make mock token refresh/store action

      // if (authToken != null) {
      //   try {
      //     final newToken = await userService.refreshToken(
      //         refreshToken: authToken.refreshToken!);
      //     if (newToken != null) {
      //       await secureStorage.storeToken(newToken);
      //
      //       error.requestOptions.headers[HttpHeaders.authorizationHeader] =
      //           "Bearer ${newToken.token}";
      //       // Retry the request with the updated token
      //       final response = await Dio().fetch(error.requestOptions);
      //       handler.resolve(response); // Continue with the response
      //     }
      //   } catch (authError) {
      //     handler.next(error);
      //   }
      // }
    } else {
      handler.next(error); // Continue with error if not 401
    }
  }
}
