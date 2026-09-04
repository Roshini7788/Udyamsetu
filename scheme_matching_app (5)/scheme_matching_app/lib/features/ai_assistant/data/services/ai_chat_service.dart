import '../../../eligibility/data/models/user_profile_model.dart';

/// Phase 1 stand-in for Gemini-powered extraction (Section 4/7).
/// Deliberately dumb keyword matching - the POINT is to prove the
/// conversational UX and the "ask only what's missing" flow work
/// end-to-end before Gemini is wired in during Phase 6. The contract
/// (take free text, return a partially-filled profile + next question)
/// is what stays stable when this is swapped for a real API call.
class AiChatService {
  Future<String> nextQuestionFor(UserProfileModel profile) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final missing = profile.missingRequiredFields();
    if (missing.isEmpty) {
      return "Great, I have what I need. Let's find your best-matched schemes.";
    }
    switch (missing.first) {
      case 'businessType':
        return 'What kind of business do you want to start?';
      case 'annualFamilyIncome':
        return 'What is your approximate annual family income?';
      case 'requestedLoanAmount':
        return 'Roughly how much funding do you need?';
      case 'category':
        return 'Which category do you belong to (e.g. General, SC, ST, OBC, Women, PwD)?';
      case 'state':
        return 'Which state are you located in?';
      default:
        return 'Could you tell me a bit more about your business plan?';
    }
  }

  /// Very rough free-text -> field extraction, standing in for Gemini's
  /// structured extraction step. Replace wholesale in Phase 6.
  UserProfileModel extractIntoProfile(String userText, UserProfileModel current) {
    final text = userText.toLowerCase();

    final amountMatch = RegExp(r'(\d+(?:\.\d+)?)\s*(lakh|lakhs|k|thousand)?').firstMatch(text);
    if (amountMatch != null && current.missingRequiredFields().contains('requestedLoanAmount')) {
      double value = double.tryParse(amountMatch.group(1) ?? '') ?? 0;
      final unit = amountMatch.group(2);
      if (unit == 'lakh' || unit == 'lakhs') value *= 100000;
      if (unit == 'k' || unit == 'thousand') value *= 1000;
      if (value > 0) current.requestedLoanAmount = value;
    }

    if (current.businessType == null) {
      for (final kw in ['tailoring', 'grocery', 'salon', 'catering', 'manufacturing', 'trading', 'shop']) {
        if (text.contains(kw)) {
          current.businessType = kw;
          break;
        }
      }
    }

    for (final cat in ['sc', 'st', 'obc', 'general', 'women', 'pwd']) {
      if (text.contains(cat) && current.category == null) {
        current.category = cat.toUpperCase();
      }
    }

    return current;
  }
}
