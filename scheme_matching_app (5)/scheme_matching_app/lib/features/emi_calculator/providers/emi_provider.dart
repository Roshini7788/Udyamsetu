import 'package:flutter/foundation.dart';
import '../data/services/emi_service.dart';

class EmiProvider extends ChangeNotifier {
  final EmiService _service = EmiService();

  double loanAmount = 200000;
  double interestRate = 10.5;
  int tenureMonths = 60;

  EmiResult result = const EmiResult(emi: 0, totalInterest: 0, totalRepayment: 0);

  EmiProvider() {
    recalculate();
  }

  void setLoanAmount(double value) {
    loanAmount = value;
    recalculate();
  }

  void setInterestRate(double value) {
    interestRate = value;
    recalculate();
  }

  void setTenureMonths(int value) {
    tenureMonths = value;
    recalculate();
  }

  void prefillFromScheme({required double maxLoan, required double rate, required int months}) {
    loanAmount = maxLoan;
    interestRate = rate;
    tenureMonths = months;
    recalculate();
  }

  void recalculate() {
    result = _service.calculate(
      principal: loanAmount,
      annualInterestRatePercent: interestRate,
      tenureMonths: tenureMonths,
    );
    notifyListeners();
  }
}
