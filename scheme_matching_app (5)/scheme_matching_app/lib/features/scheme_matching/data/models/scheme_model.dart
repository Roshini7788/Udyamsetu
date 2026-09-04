/// Mirrors the `schemes` MongoDB collection. Every field listed here is
/// required by the master spec (Section 4) so the app never has to
/// fall back on guessed/hard-coded values.
class SchemeModel {
  final String id;
  final String name;
  final String targetGroup;
  final String eligibilitySummary;
  final double incomeLimit; // annual family income limit, in INR
  final double maxProjectCost;
  final double maxLoanAmount;
  final double interestRatePercent;
  final int repaymentMonths;
  final int moratoriumMonths;
  final String purpose;
  final List<String> requiredDocuments;
  final String applicationMethod;
  final String officialSource;
  final DateTime lastVerified;

  const SchemeModel({
    required this.id,
    required this.name,
    required this.targetGroup,
    required this.eligibilitySummary,
    required this.incomeLimit,
    required this.maxProjectCost,
    required this.maxLoanAmount,
    required this.interestRatePercent,
    required this.repaymentMonths,
    required this.moratoriumMonths,
    required this.purpose,
    required this.requiredDocuments,
    required this.applicationMethod,
    required this.officialSource,
    required this.lastVerified,
  });

  factory SchemeModel.fromJson(Map<String, dynamic> json) {
    return SchemeModel(
      id: json['_id'] ?? json['id'],
      name: json['name'],
      targetGroup: json['targetGroup'],
      eligibilitySummary: json['eligibilitySummary'],
      incomeLimit: (json['incomeLimit'] as num).toDouble(),
      maxProjectCost: (json['maxProjectCost'] as num).toDouble(),
      maxLoanAmount: (json['maxLoanAmount'] as num).toDouble(),
      interestRatePercent: (json['interestRatePercent'] as num).toDouble(),
      repaymentMonths: json['repaymentMonths'],
      moratoriumMonths: json['moratoriumMonths'],
      purpose: json['purpose'],
      requiredDocuments: List<String>.from(json['requiredDocuments'] ?? []),
      applicationMethod: json['applicationMethod'],
      officialSource: json['officialSource'],
      lastVerified: DateTime.parse(json['lastVerified']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'targetGroup': targetGroup,
        'eligibilitySummary': eligibilitySummary,
        'incomeLimit': incomeLimit,
        'maxProjectCost': maxProjectCost,
        'maxLoanAmount': maxLoanAmount,
        'interestRatePercent': interestRatePercent,
        'repaymentMonths': repaymentMonths,
        'moratoriumMonths': moratoriumMonths,
        'purpose': purpose,
        'requiredDocuments': requiredDocuments,
        'applicationMethod': applicationMethod,
        'officialSource': officialSource,
        'lastVerified': lastVerified.toIso8601String(),
      };
}
