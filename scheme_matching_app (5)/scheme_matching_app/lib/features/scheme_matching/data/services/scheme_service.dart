import '../../../eligibility/data/models/user_profile_model.dart';
import '../models/match_result_model.dart';
import 'dummy_data.dart';

/// Phase 1 implementation of the matching flow described in Section 6.
/// This local logic is a STAND-IN for the future rule-based eligibility
/// engine + matching algorithm - same two-step shape (eliminate, then
/// rank) so swapping this for the real POST /schemes/match call later
/// doesn't change how screens consume it.
class SchemeService {
  /// Step 1: eliminate schemes where mandatory eligibility fails.
  /// Step 2: score + rank the remaining schemes.
  Future<List<MatchResultModel>> matchSchemes(UserProfileModel profile) async {
    await Future.delayed(const Duration(milliseconds: 600)); // simulate network

    final results = <MatchResultModel>[];

    for (final scheme in DummyData.schemes) {
      final reasonsMatched = <String>[];
      final reasonsToVerify = <String>[];

      // --- Mandatory checks (elimination) ---
      final incomeOk = (profile.annualFamilyIncome ?? 0) <= scheme.incomeLimit;
      if (!incomeOk) continue; // eliminated - does not appear at all

      // --- Scored checks ---
      int score = 40; // base score once mandatory eligibility passes
      reasonsMatched.add('Your family income is within the limit');

      final loanFits = (profile.requestedLoanAmount ?? 0) <= scheme.maxLoanAmount &&
          (profile.requestedLoanAmount ?? 0) > 0;
      if (loanFits) {
        score += 25;
        reasonsMatched.add('Your required loan amount fits the scheme');
      } else {
        reasonsToVerify.add('Requested amount may exceed this scheme\'s maximum loan limit');
      }

      final purposeFits = profile.businessType != null &&
          scheme.purpose.toLowerCase().contains(
              profile.businessType!.toLowerCase().split(' ').first);
      if (purposeFits) {
        score += 20;
        reasonsMatched.add('Your business activity is supported');
      } else {
        score += 5;
        reasonsToVerify.add('Confirm your business type matches this scheme\'s supported purpose');
      }

      if (profile.category != null && profile.category!.isNotEmpty) {
        score += 10;
        reasonsMatched.add('Your category matches the target group');
      }

      if ((profile.projectCost ?? 0) > 0 && profile.projectCost! <= scheme.maxProjectCost) {
        score += 5;
        reasonsMatched.add('Your project cost fits within scheme limits');
      }

      score = score.clamp(0, 100);

      reasonsToVerify.add('Final approval is subject to the authorized agency');

      results.add(MatchResultModel(
        scheme: scheme,
        matchPercent: score,
        reasonsMatched: reasonsMatched,
        reasonsToVerify: reasonsToVerify,
      ));
    }

    results.sort((a, b) => b.matchPercent.compareTo(a.matchPercent));
    return results;
  }
}
