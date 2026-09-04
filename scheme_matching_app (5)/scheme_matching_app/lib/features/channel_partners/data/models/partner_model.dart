class PartnerModel {
  final String id;
  final String name;
  final String address;
  final String contact;
  final double latitude;
  final double longitude;
  final double distanceKm; // computed relative to user location
  final List<String> eligibleSchemeIds;

  const PartnerModel({
    required this.id,
    required this.name,
    required this.address,
    required this.contact,
    required this.latitude,
    required this.longitude,
    required this.distanceKm,
    required this.eligibleSchemeIds,
  });

  factory PartnerModel.fromJson(Map<String, dynamic> json) {
    return PartnerModel(
      id: json['_id'] ?? json['id'],
      name: json['name'],
      address: json['address'],
      contact: json['contact'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      distanceKm: (json['distanceKm'] as num?)?.toDouble() ?? 0,
      eligibleSchemeIds: List<String>.from(json['eligibleSchemeIds'] ?? []),
    );
  }
}
