/// This is the "structured fields" object that Gemini's extraction step
/// (Section 4) populates from free-text/voice, and that the eligibility
/// screen fills in the gaps for. Nothing in here is ever written by AI
/// directly into a scheme decision - it's just input to the rule engine.
class UserProfileModel {
  String? category; // e.g. SC/ST/OBC/General/Women/PwD - user-declared
  double? annualFamilyIncome;
  String? businessType;
  double? projectCost;
  double? requestedLoanAmount;
  String? educationLevel;
  String? state;
  String? district;

  UserProfileModel({
    this.category,
    this.annualFamilyIncome,
    this.businessType,
    this.projectCost,
    this.requestedLoanAmount,
    this.educationLevel,
    this.state,
    this.district,
  });

  /// Used by the adaptive questioning screen to decide what to ask next.
  List<String> missingRequiredFields() {
    final missing = <String>[];
    if (businessType == null || businessType!.isEmpty) missing.add('businessType');
    if (annualFamilyIncome == null) missing.add('annualFamilyIncome');
    if (requestedLoanAmount == null) missing.add('requestedLoanAmount');
    if (category == null || category!.isEmpty) missing.add('category');
    if (state == null || state!.isEmpty) missing.add('state');
    return missing;
  }

  bool get isComplete => missingRequiredFields().isEmpty;

  Map<String, dynamic> toJson() => {
        'category': category,
        'annualFamilyIncome': annualFamilyIncome,
        'businessType': businessType,
        'projectCost': projectCost,
        'requestedLoanAmount': requestedLoanAmount,
        'educationLevel': educationLevel,
        'state': state,
        'district': district,
      };
}
