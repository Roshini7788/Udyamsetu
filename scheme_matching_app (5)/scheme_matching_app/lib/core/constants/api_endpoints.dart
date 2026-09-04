/// Maps 1:1 to the backend API spec (Master Prompt Section 12).
/// Base URL swaps between local dev and deployed backend via --dart-define.
class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:5000/api', // Android emulator -> localhost
  );

  static const String register = '$baseUrl/auth/register';
  static const String login = '$baseUrl/auth/login';

  static const String schemes = '$baseUrl/schemes';
  static String schemeById(String id) => '$baseUrl/schemes/$id';

  static const String eligibilityCheck = '$baseUrl/eligibility/check';
  static const String schemesMatch = '$baseUrl/schemes/match';

  static const String aiChat = '$baseUrl/ai/chat';
  static const String aiExtractProfile = '$baseUrl/ai/extract-profile';

  static const String partnersNearby = '$baseUrl/partners/nearby';
  static const String emiCalculate = '$baseUrl/emi/calculate';

  static String documentsForScheme(String schemeId) => '$baseUrl/documents/$schemeId';

  static const String applications = '$baseUrl/applications';
  static String applicationsForUser(String userId) => '$baseUrl/applications/$userId';
}
