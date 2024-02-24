class ApiUrl {
  static final ApiUrl _instance = ApiUrl._private();
  ApiUrl._private();
  factory ApiUrl() => _instance;

  static const String _baseUrl = 'https://qmtech.free.beeceptor.com/';

  static String quizUrl = '$_baseUrl/questions';
}