import '../models/application_model.dart';

class ApplicationService {
  final List<ApplicationModel> _applications = [
    ApplicationModel(
      id: 'app_001',
      schemeId: 'scheme_003',
      schemeName: 'Mudra Loan - Shishu Category',
      status: ApplicationStatus.underReview,
      updatedAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  Future<List<ApplicationModel>> myApplications() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_applications);
  }

  Future<void> startApplication(String schemeId, String schemeName) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _applications.add(ApplicationModel(
      id: 'app_${_applications.length + 1}'.padLeft(7, '0'),
      schemeId: schemeId,
      schemeName: schemeName,
      status: ApplicationStatus.draft,
      updatedAt: DateTime.now(),
    ));
  }
}
