import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_router.dart';

import 'features/auth/providers/auth_provider.dart';
import 'features/ai_assistant/providers/chat_provider.dart';
import 'features/scheme_matching/providers/scheme_match_provider.dart';
import 'features/emi_calculator/providers/emi_provider.dart';
import 'features/channel_partners/providers/partner_provider.dart';
import 'features/documents/providers/document_provider.dart';
import 'features/applications/providers/application_provider.dart';

void main() {
  runApp(const SchemeMatchingApp());
}

class SchemeMatchingApp extends StatelessWidget {
  const SchemeMatchingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => SchemeMatchProvider()),
        ChangeNotifierProvider(create: (_) => EmiProvider()),
        ChangeNotifierProvider(create: (_) => PartnerProvider()),
        ChangeNotifierProvider(create: (_) => DocumentProvider()),
        ChangeNotifierProvider(create: (_) => ApplicationProvider()),
      ],
      child: MaterialApp(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
