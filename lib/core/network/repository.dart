import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class Repository {
  Dio? _dio;
  String baseUrl;
  final Interceptor? interceptor;

  Repository({
    required this.baseUrl,
    this.interceptor,
  });

  Future<Dio> getRepository() async {
    if (_dio == null) {
      _dio = Dio()
        ..options.baseUrl = baseUrl
        ..interceptors.add(
          PrettyDioLogger(
            request: true,
            requestBody: false,
            requestHeader: false,
            responseHeader: false,
            responseBody: true,
            logPrint: print,
          ),
        );
      if (interceptor != null) {
        _dio!.interceptors.add(interceptor!);
      }
    }
    _dio!.options.responseType = ResponseType.json;
    _dio!.options.headers = _getDioHeaders(options: _dio!.options);
    return Future.value(_dio);
  }

  Map<String, dynamic> _getDioHeaders(
      {String? lang, required BaseOptions options}) {
    final map = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    if (lang != null) {
      map.update("Accept-Language", (existingLang) => lang,
          ifAbsent: () => lang);
      map.update("x-locale", (existingLang) => lang, ifAbsent: () => lang);
    }

    return map;
  }
}

class RepositoryImpl extends Repository {
  RepositoryImpl({
    required super.baseUrl,
    super.interceptor,
  });
}
