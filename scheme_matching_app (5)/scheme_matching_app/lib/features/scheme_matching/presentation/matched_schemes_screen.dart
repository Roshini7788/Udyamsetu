import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../../routes/app_router.dart';
import '../data/models/match_result_model.dart';
import '../providers/scheme_match_provider.dart';

/// Screen 6. Section 5 requires we never show a bare percentage - every
/// card exposes its "Why?" reasons. Section 22's demo scenario (top match
/// as hero, ranked list below) is implemented directly here.
class MatchedSchemesScreen extends StatelessWidget {
  const MatchedSchemesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SchemeMatchProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.matchedSchemes)),
      body: SafeArea(child: _buildBody(context, provider)),
    );
  }

  Widget _buildBody(BuildContext context, SchemeMatchProvider provider) {
    switch (provider.state) {
      case MatchLoadState.loading:
      case MatchLoadState.idle:
        return const LoadingIndicator(message: 'Checking eligible schemes for you...');
      case MatchLoadState.error:
        return ErrorView(
          message: provider.errorMessage ?? 'Something went wrong.',
          icon: Icons.wifi_off,
        );
      case MatchLoadState.empty:
        return const ErrorView(
          message: 'No matching schemes found for the details provided.\n'
              'Try adjusting your loan amount or check back as we add more schemes.',
          icon: Icons.search_off,
        );
      case MatchLoadState.success:
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: provider.results.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(AppStrings.topRecommendation,
                    style: Theme.of(context).textTheme.titleLarge),
              );
            }
            final result = provider.results[index - 1];
            return _MatchCard(result: result, isTop: index == 1);
          },
        );
    }
  }
}

class _MatchCard extends StatelessWidget {
  final MatchResultModel result;
  final bool isTop;

  const _MatchCard({required this.result, required this.isTop});

  Color get _matchColor {
    if (result.matchPercent >= 80) return AppColors.matchHigh;
    if (result.matchPercent >= 50) return AppColors.matchMedium;
    return AppColors.matchLow;
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.schemeDetails,
        arguments: result.scheme,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (isTop)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('Best Match', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              const Spacer(),
              CircleAvatar(
                radius: 22,
                backgroundColor: _matchColor.withOpacity(0.15),
                child: Text('${result.matchPercent}%',
                    style: TextStyle(color: _matchColor, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(result.scheme.name, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(result.scheme.targetGroup, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 12),
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            title: Text(AppStrings.whyThisScheme,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            children: [
              ...result.reasonsMatched.map((r) => _ReasonRow(text: r, positive: true)),
              const SizedBox(height: 8),
              Text(AppStrings.whatToVerify,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              ...result.reasonsToVerify.map((r) => _ReasonRow(text: r, positive: false)),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReasonRow extends StatelessWidget {
  final String text;
  final bool positive;
  const _ReasonRow({required this.text, required this.positive});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            positive ? Icons.check_circle : Icons.error_outline,
            size: 16,
            color: positive ? AppColors.success : AppColors.warning,
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}
