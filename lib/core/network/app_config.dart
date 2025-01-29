class AppConfig {
  final String baseUrl;

  AppConfig._({required this.baseUrl});

  factory AppConfig() {
    late String baseUrl;
    baseUrl = 'https://dummyjson.com/c/60b7-70a6-4ee3-bae8';
    return AppConfig._(baseUrl: baseUrl);
  }
}
