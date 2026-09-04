import 'package:flutter/material.dart';
import '../features/splash/presentation/splash_screen.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/signup_screen.dart';
import '../features/home/presentation/home_dashboard_screen.dart';
import '../features/ai_assistant/presentation/ai_assistant_screen.dart';
import '../features/eligibility/presentation/eligibility_questions_screen.dart';
import '../features/scheme_matching/presentation/matched_schemes_screen.dart';
import '../features/scheme_matching/presentation/scheme_details_screen.dart';
import '../features/scheme_matching/data/models/scheme_model.dart';
import '../features/emi_calculator/presentation/emi_calculator_screen.dart';
import '../features/channel_partners/presentation/nearby_partners_screen.dart';
import '../features/documents/presentation/documents_guidance_screen.dart';
import '../features/applications/presentation/my_applications_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String aiAssistant = '/ai-assistant';
  static const String eligibilityQuestions = '/eligibility-questions';
  static const String matchedSchemes = '/matched-schemes';
  static const String schemeDetails = '/scheme-details';
  static const String emiCalculator = '/emi-calculator';
  static const String nearbyPartners = '/nearby-partners';
  static const String documentsGuidance = '/documents-guidance';
  static const String myApplications = '/my-applications';
}

/// Central onGenerateRoute. Screens 7-10 accept an optional SchemeModel
/// argument (arriving from the matched-schemes / details flow) but also
/// work with no argument (dashboard standalone entry points, per the
/// screen flow's dual-entry design) - the null-checks live in each screen.
class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeDashboardScreen());
      case AppRoutes.aiAssistant:
        return MaterialPageRoute(builder: (_) => const AiAssistantScreen());
      case AppRoutes.eligibilityQuestions:
        return MaterialPageRoute(builder: (_) => const EligibilityQuestionsScreen());
      case AppRoutes.matchedSchemes:
        return MaterialPageRoute(builder: (_) => const MatchedSchemesScreen());
      case AppRoutes.schemeDetails:
        final scheme = settings.arguments as SchemeModel;
        return MaterialPageRoute(builder: (_) => SchemeDetailsScreen(scheme: scheme));
      case AppRoutes.emiCalculator:
        final scheme = settings.arguments as SchemeModel?;
        return MaterialPageRoute(builder: (_) => EmiCalculatorScreen(scheme: scheme));
      case AppRoutes.nearbyPartners:
        final scheme = settings.arguments as SchemeModel?;
        return MaterialPageRoute(builder: (_) => NearbyPartnersScreen(scheme: scheme));
      case AppRoutes.documentsGuidance:
        final scheme = settings.arguments as SchemeModel;
        return MaterialPageRoute(builder: (_) => DocumentsGuidanceScreen(scheme: scheme));
      case AppRoutes.myApplications:
        return MaterialPageRoute(builder: (_) => const MyApplicationsScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text('No route defined for ${settings.name}'))),
        );
    }
  }
}
