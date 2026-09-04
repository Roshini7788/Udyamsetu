import 'package:flutter/foundation.dart';
import '../data/models/partner_model.dart';
import '../data/services/partner_service.dart';

class PartnerProvider extends ChangeNotifier {
  final PartnerService _service = PartnerService();

  List<PartnerModel> partners = [];
  bool isLoading = false;

  Future<void> loadForScheme(String schemeId) async {
    isLoading = true;
    notifyListeners();
    partners = await _service.nearbyPartnersForScheme(schemeId);
    isLoading = false;
    notifyListeners();
  }
}
