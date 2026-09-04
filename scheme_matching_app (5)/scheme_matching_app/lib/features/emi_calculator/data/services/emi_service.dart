import 'dart:math';

class EmiResult {
  final double emi;
  final double totalInterest;
  final double totalRepayment;

  const EmiResult({
    required this.emi,
    required this.totalInterest,
    required this.totalRepayment,
  });
}

/// Section 17: "Do not let AI perform financial calculations. Use
/// deterministic programming logic." This is pure math, no AI call,
/// no network call - works identically in Phase 1 and after backend
/// integration.
class EmiService {
  /// Standard reducing-balance EMI formula.
  /// EMI = P * r * (1+r)^n / ((1+r)^n - 1)
  EmiResult calculate({
    required double principal,
    required double annualInterestRatePercent,
    required int tenureMonths,
  }) {
    if (principal <= 0 || tenureMonths <= 0) {
      return const EmiResult(emi: 0, totalInterest: 0, totalRepayment: 0);
    }

    final monthlyRate = annualInterestRatePercent / 12 / 100;

    double emi;
    if (monthlyRate == 0) {
      emi = principal / tenureMonths;
    } else {
      final factor = pow(1 + monthlyRate, tenureMonths);
      emi = principal * monthlyRate * factor / (factor - 1);
    }

    final totalRepayment = emi * tenureMonths;
    final totalInterest = totalRepayment - principal;

    return EmiResult(
      emi: double.parse(emi.toStringAsFixed(2)),
      totalInterest: double.parse(totalInterest.toStringAsFixed(2)),
      totalRepayment: double.parse(totalRepayment.toStringAsFixed(2)),
    );
  }
}
