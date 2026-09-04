import 'scheme_model.dart';

/// The output of the (future) rule engine + matching algorithm.
/// `reasonsMatched` / `reasonsToVerify` drive the "Why this scheme
/// matches you" explainability panel required by Section 5 - the app
/// never just shows a bare percentage.
class MatchResultModel {
  final SchemeModel scheme;
  final int matchPercent; // 0-100, computed server-side, never by the AI
  final List<String> reasonsMatched;
  final List<String> reasonsToVerify;

  const MatchResultModel({
    required this.scheme,
    required this.matchPercent,
    required this.reasonsMatched,
    required this.reasonsToVerify,
  });

  factory MatchResultModel.fromJson(Map<String, dynamic> json) {
    return MatchResultModel(
      scheme: SchemeModel.fromJson(json['scheme']),
      matchPercent: json['matchPercent'],
      reasonsMatched: List<String>.from(json['reasonsMatched'] ?? []),
      reasonsToVerify: List<String>.from(json['reasonsToVerify'] ?? []),
    );
  }
}
