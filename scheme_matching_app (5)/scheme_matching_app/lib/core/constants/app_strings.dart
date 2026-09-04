/// Centralized English strings. When localization (Section 16) is wired up,
/// these keys map into core/localization/en.json and hi.json instead.
/// Keeping them centralized now (instead of inline in widgets) makes that
/// swap mechanical later rather than a rewrite.
class AppStrings {
  AppStrings._();

  static const String appName = 'YojanaSetu';
  static const String tagline = "Don't search for schemes. Let the right scheme find you.";

  // Home Dashboard
  static const String findMyScheme = 'Find My Scheme';
  static const String askAI = 'Ask AI';
  static const String emiCalculator = 'EMI Calculator';
  static const String nearbyPartners = 'Nearby Partners';
  static const String myApplications = 'My Applications';

  // AI Assistant
  static const String tellYourNeed = 'Tell us what you need';
  static const String aiInputHint = 'e.g. "I want to start a tailoring business..."';
  static const String speakInstead = 'Tap the mic to speak instead';

  // Matched Schemes
  static const String topRecommendation = 'Top Recommended Scheme';
  static const String matchedSchemes = 'Matched Schemes';
  static const String whyThisScheme = 'Why this scheme matches you';
  static const String whatToVerify = 'What you may need to verify';

  // Scheme Details
  static const String viewDetails = 'View Details';
  static const String calculateEmi = 'Calculate EMI';
  static const String requiredDocuments = 'Required Documents';
  static const String findPartner = 'Find Authorized Partner';
  static const String applicationGuidance = 'Application Guidance';

  // Disclaimers
  static const String approvalDisclaimer =
      'Final approval is subject to the authorized agency.';
  static const String verifiedDataDisclaimer =
      'Information is based on the latest verified scheme data.';
  static const String emiDisclaimer =
      'This is an approximate estimate. Actual terms are determined by the authorized financial institution.';
}
