class ApiConfig {
  // Base URLs
  static const String productionUrl =
      'https://noteventure-production.up.railway.app/api/v1';
  static const String developmentUrl = 'http://localhost:8080/api/v1';

  // Use production by default, can be changed for development
  static const String baseUrl = productionUrl;

  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  // Headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}
