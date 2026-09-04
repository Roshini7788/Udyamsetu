import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/app_card.dart';
import '../../scheme_matching/data/models/scheme_model.dart';
import '../providers/emi_provider.dart';

class EmiCalculatorScreen extends StatefulWidget {
  final SchemeModel? scheme;
  const EmiCalculatorScreen({super.key, this.scheme});

  @override
  State<EmiCalculatorScreen> createState() => _EmiCalculatorScreenState();
}

class _EmiCalculatorScreenState extends State<EmiCalculatorScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.scheme != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<EmiProvider>().prefillFromScheme(
              maxLoan: widget.scheme!.maxLoanAmount,
              rate: widget.scheme!.interestRatePercent,
              months: widget.scheme!.repaymentMonths,
            );
      });
    }
  }

  String _currency(double v) => '₹${v.toStringAsFixed(0)}';

  @override
  Widget build(BuildContext context) {
    final emi = context.watch<EmiProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.emiCalculator)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            AppCard(
              child: Column(
                children: [
                  Text('Estimated EMI', style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 4),
                  Text(
                    '${_currency(emi.result.emi)} / month',
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.primary),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatColumn(label: 'Total Interest', value: _currency(emi.result.totalInterest)),
                      _StatColumn(label: 'Total Repayment', value: _currency(emi.result.totalRepayment)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            _SliderField(
              label: 'Loan Amount',
              value: emi.loanAmount,
              min: 10000,
              max: 2000000,
              display: _currency(emi.loanAmount),
              onChanged: (v) => emi.setLoanAmount(v),
            ),
            _SliderField(
              label: 'Interest Rate',
              value: emi.interestRate,
              min: 4,
              max: 20,
              display: '${emi.interestRate.toStringAsFixed(1)}%',
              onChanged: (v) => emi.setInterestRate(v),
            ),
            _SliderField(
              label: 'Tenure',
              value: emi.tenureMonths.toDouble(),
              min: 6,
              max: 120,
              display: '${emi.tenureMonths} months',
              onChanged: (v) => emi.setTenureMonths(v.round()),
            ),

            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.warning.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(AppStrings.emiDisclaimer, style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String label;
  final String value;
  const _StatColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      ],
    );
  }
}

class _SliderField extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final String display;
  final ValueChanged<double> onChanged;

  const _SliderField({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.display,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
              Text(display, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
            ],
          ),
          Slider(
            value: value.clamp(min, max),
            min: min,
            max: max,
            activeColor: AppColors.primary,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
