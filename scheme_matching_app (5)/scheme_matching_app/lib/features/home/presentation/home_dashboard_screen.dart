import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/app_card.dart';
import '../../../routes/app_router.dart';
import '../../auth/providers/auth_provider.dart';

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    final tiles = <_DashboardTile>[
      _DashboardTile(AppStrings.findMyScheme, Icons.search, AppColors.primary,
          () => Navigator.pushNamed(context, AppRoutes.aiAssistant)),
      _DashboardTile(AppStrings.askAI, Icons.mic_none, AppColors.secondary,
          () => Navigator.pushNamed(context, AppRoutes.aiAssistant)),
      _DashboardTile(AppStrings.emiCalculator, Icons.calculate_outlined, Colors.blueGrey,
          () => Navigator.pushNamed(context, AppRoutes.emiCalculator)),
      _DashboardTile(AppStrings.nearbyPartners, Icons.map_outlined, Colors.teal,
          () => Navigator.pushNamed(context, AppRoutes.nearbyPartners)),
      _DashboardTile(AppStrings.myApplications, Icons.folder_outlined, Colors.deepOrange,
          () => Navigator.pushNamed(context, AppRoutes.myApplications)),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Hi, ${auth.user?.name ?? 'there'}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              auth.logout();
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (r) => false);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStrings.tagline, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.1,
                  children: tiles,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashboardTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _DashboardTile(this.label, this.icon, this.color, this.onTap);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: color),
          const SizedBox(height: 12),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
