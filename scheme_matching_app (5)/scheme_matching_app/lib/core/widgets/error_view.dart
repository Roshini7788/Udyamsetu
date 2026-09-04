import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import 'primary_button.dart';

/// Section 20 (Error Handling) requires understandable messages instead
/// of crashes for: no matching scheme, network failure, AI unavailable,
/// no nearby partner, etc. This is the single shared "something went
/// wrong, here's what you can do" view for all of those cases.
class ErrorView extends StatelessWidget {
  final String message;
  final IconData icon;
  final String? retryLabel;
  final VoidCallback? onRetry;

  const ErrorView({
    super.key,
    required this.message,
    this.icon = Icons.info_outline,
    this.retryLabel,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: AppColors.textSecondary),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center, style: AppTextStyles.body),
            if (onRetry != null) ...[
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: PrimaryButton(label: retryLabel ?? 'Try Again', onPressed: onRetry),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
