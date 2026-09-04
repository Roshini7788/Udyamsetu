enum ApplicationStatus { draft, submitted, underReview, approved, rejected }

class ApplicationModel {
  final String id;
  final String schemeId;
  final String schemeName;
  final ApplicationStatus status;
  final DateTime updatedAt;

  const ApplicationModel({
    required this.id,
    required this.schemeId,
    required this.schemeName,
    required this.status,
    required this.updatedAt,
  });

  String get statusLabel {
    switch (status) {
      case ApplicationStatus.draft:
        return 'Draft';
      case ApplicationStatus.submitted:
        return 'Submitted';
      case ApplicationStatus.underReview:
        return 'Under Review';
      case ApplicationStatus.approved:
        return 'Approved';
      case ApplicationStatus.rejected:
        return 'Rejected';
    }
  }
}
