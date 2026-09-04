import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../routes/app_router.dart';
import '../data/models/scheme_model.dart';

class SchemeDetailsScreen extends StatelessWidget {
  final SchemeModel scheme;
  const SchemeDetailsScreen({super.key, required this.scheme});

  @override
  Widget build(BuildContext context) {
    final currency = (double v) => '₹${v.toStringAsFixed(0)}';

    return Scaffold(
      appBar: AppBar(title: Text(scheme.name, overflow: TextOverflow.ellipsis)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(scheme.name, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 4),
            Text(scheme.targetGroup, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 20),

            _DetailRow(label: 'Purpose', value: scheme.purpose),
            _DetailRow(label: 'Eligibility', value: scheme.eligibilitySummary),
            _DetailRow(label: 'Income limit', value: '${currency(scheme.incomeLimit)} / year'),
            _DetailRow(label: 'Maximum project cost', value: currency(scheme.maxProjectCost)),
            _DetailRow(label: 'Maximum loan amount', value: currency(scheme.maxLoanAmount)),
            _DetailRow(label: 'Interest rate', value: '${scheme.interestRatePercent}% p.a. (approx.)'),
            _DetailRow(label: 'Repayment period', value: '${scheme.repaymentMonths} months'),
            _DetailRow(label: 'Moratorium', value: '${scheme.moratoriumMonths} months'),
            _DetailRow(label: 'Application method', value: scheme.applicationMethod),

            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.warning.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.verified_outlined, size: 18, color: AppColors.warning),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Source: ${scheme.officialSource}\nLast verified: ${scheme.lastVerified.toLocal().toString().split(' ').first}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            PrimaryButton(
              label: AppStrings.calculateEmi,
              icon: Icons.calculate_outlined,
              onPressed: () => Navigator.pushNamed(
                context,
                AppRoutes.emiCalculator,
                arguments: scheme,
              ),
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              label: AppStrings.requiredDocuments,
              icon: Icons.description_outlined,
              color: AppColors.secondary,
              onPressed: () => Navigator.pushNamed(
                context,
                AppRoutes.documentsGuidance,
                arguments: scheme,
              ),
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              label: AppStrings.findPartner,
              icon: Icons.map_outlined,
              color: Colors.teal,
              onPressed: () => Navigator.pushNamed(
                context,
                AppRoutes.nearbyPartners,
                arguments: scheme,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}
