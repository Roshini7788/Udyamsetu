import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../scheme_matching/data/models/scheme_model.dart';
import '../providers/partner_provider.dart';

/// Screen 9. List view for Phase 1/8; the map view (Section 9: "Map +
/// list view") slots in alongside this once google_maps_flutter is wired
/// up with real location permissions in Phase 8 - the PartnerProvider
/// and partner cards below don't change.
class NearbyPartnersScreen extends StatefulWidget {
  final SchemeModel? scheme;
  const NearbyPartnersScreen({super.key, this.scheme});

  @override
  State<NearbyPartnersScreen> createState() => _NearbyPartnersScreenState();
}

class _NearbyPartnersScreenState extends State<NearbyPartnersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final schemeId = widget.scheme?.id ?? 'scheme_001'; // default for standalone dashboard entry
      context.read<PartnerProvider>().loadForScheme(schemeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PartnerProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.nearbyPartners)),
      body: SafeArea(
        child: provider.isLoading
            ? const LoadingIndicator(message: 'Finding authorized partners near you...')
            : provider.partners.isEmpty
                ? const ErrorView(
                    message: 'No authorized partners found nearby for this scheme yet.',
                    icon: Icons.location_off_outlined,
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: provider.partners.length,
                    itemBuilder: (context, index) {
                      final p = provider.partners[index];
                      return AppCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(p.name,
                                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                                ),
                                Text('${p.distanceKm.toStringAsFixed(1)} km',
                                    style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(p.address, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.call_outlined, size: 18),
                                    label: const Text('Contact'),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.directions_outlined, size: 18),
                                    label: const Text('Navigate'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
