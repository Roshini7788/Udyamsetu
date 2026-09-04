import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../routes/app_router.dart';
import '../../ai_assistant/providers/chat_provider.dart';
import '../../scheme_matching/providers/scheme_match_provider.dart';

/// Screen 5. By the time the user lands here, the AI chat (Screen 4) has
/// already extracted most fields - this screen just shows them for
/// confirmation/correction rather than asking from scratch, keeping the
/// "ask only what's necessary" principle (Section 7) intact.
class EligibilityQuestionsScreen extends StatefulWidget {
  const EligibilityQuestionsScreen({super.key});

  @override
  State<EligibilityQuestionsScreen> createState() => _EligibilityQuestionsScreenState();
}

class _EligibilityQuestionsScreenState extends State<EligibilityQuestionsScreen> {
  late TextEditingController _incomeController;
  late TextEditingController _loanController;
  late TextEditingController _businessController;
  late TextEditingController _stateController;
  String? _category;

  @override
  void initState() {
    super.initState();
    final profile = context.read<ChatProvider>().profile;
    _incomeController = TextEditingController(text: profile.annualFamilyIncome?.toStringAsFixed(0) ?? '');
    _loanController = TextEditingController(text: profile.requestedLoanAmount?.toStringAsFixed(0) ?? '');
    _businessController = TextEditingController(text: profile.businessType ?? '');
    _stateController = TextEditingController(text: profile.state ?? 'Andhra Pradesh');
    _category = profile.category;
  }

  @override
  Widget build(BuildContext context) {
    final chat = context.watch<ChatProvider>();
    final matchProvider = context.watch<SchemeMatchProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Your Details')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _ProgressDots(step: 2, total: 2),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    TextField(
                      controller: _businessController,
                      decoration: const InputDecoration(labelText: 'Business type'),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _incomeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Annual family income (₹)'),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _loanController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Loan amount needed (₹)'),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      initialValue: _category,
                      decoration: const InputDecoration(labelText: 'Category'),
                      items: const ['General', 'SC', 'ST', 'OBC', 'Women', 'PwD']
                          .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                          .toList(),
                      onChanged: (v) => setState(() => _category = v),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _stateController,
                      decoration: const InputDecoration(labelText: 'State'),
                    ),
                  ],
                ),
              ),
              PrimaryButton(
                label: 'Find My Schemes',
                isLoading: matchProvider.state == MatchLoadState.loading,
                onPressed: () async {
                  chat.updateProfileField('businessType', _businessController.text.trim());
                  chat.updateProfileField(
                      'annualFamilyIncome', double.tryParse(_incomeController.text.trim()));
                  chat.updateProfileField(
                      'requestedLoanAmount', double.tryParse(_loanController.text.trim()));
                  chat.updateProfileField('category', _category);
                  chat.updateProfileField('state', _stateController.text.trim());

                  await matchProvider.findMatches(chat.profile);
                  if (context.mounted) {
                    Navigator.pushNamed(context, AppRoutes.matchedSchemes);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProgressDots extends StatelessWidget {
  final int step;
  final int total;
  const _ProgressDots({required this.step, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(total, (i) {
        final active = i < step;
        return Expanded(
          child: Container(
            height: 6,
            margin: EdgeInsets.only(right: i == total - 1 ? 0 : 6),
            decoration: BoxDecoration(
              color: active ? AppColors.primary : AppColors.cardBorder,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        );
      }),
    );
  }
}
