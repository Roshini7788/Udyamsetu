import '../models/partner_model.dart';
import '../../../scheme_matching/data/services/dummy_data.dart';

/// Section 18: partners must be scoped to the *selected scheme's*
/// authorized network, not a generic bank list. This filter is the
/// core behavior to preserve when Phase 8 swaps in the real
/// GET /partners/nearby + Google Maps distance calculation.
class PartnerService {
  Future<List<PartnerModel>> nearbyPartnersForScheme(String schemeId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final filtered = DummyData.partners
        .where((p) => p.eligibleSchemeIds.contains(schemeId))
        .toList();
    filtered.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
    return filtered;
  }
}
