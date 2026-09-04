import 'package:flutter/foundation.dart';
import '../data/models/match_result_model.dart';
import '../data/services/scheme_service.dart';
import '../../eligibility/data/models/user_profile_model.dart';

enum MatchLoadState { idle, loading, success, empty, error }

class SchemeMatchProvider extends ChangeNotifier {
  final SchemeService _service = SchemeService();

  List<MatchResultModel> results = [];
  MatchLoadState state = MatchLoadState.idle;
  String? errorMessage;

  Future<void> findMatches(UserProfileModel profile) async {
    state = MatchLoadState.loading;
    notifyListeners();
    try {
      results = await _service.matchSchemes(profile);
      state = results.isEmpty ? MatchLoadState.empty : MatchLoadState.success;
    } catch (e) {
      errorMessage = 'We could not check schemes right now. Please try again.';
      state = MatchLoadState.error;
    }
    notifyListeners();
  }
}
