import 'package:flutter/foundation.dart';
import '../data/models/application_model.dart';
import '../data/services/application_service.dart';

class ApplicationProvider extends ChangeNotifier {
  final ApplicationService _service = ApplicationService();

  List<ApplicationModel> applications = [];
  bool isLoading = false;

  Future<void> loadApplications() async {
    isLoading = true;
    notifyListeners();
    applications = await _service.myApplications();
    isLoading = false;
    notifyListeners();
  }

  Future<void> startApplication(String schemeId, String schemeName) async {
    await _service.startApplication(schemeId, schemeName);
    await loadApplications();
  }
}
