import 'package:flutter/foundation.dart';
import '../data/models/document_model.dart';
import '../data/services/document_service.dart';

class DocumentProvider extends ChangeNotifier {
  final DocumentService _service = DocumentService();

  List<DocumentModel> documents = [];
  bool isLoading = false;

  Future<void> loadForScheme(String schemeId) async {
    isLoading = true;
    notifyListeners();
    documents = await _service.requiredDocumentsFor(schemeId);
    isLoading = false;
    notifyListeners();
  }

  void toggleUploaded(int index) {
    documents[index].isUploaded = !documents[index].isUploaded;
    notifyListeners();
  }

  int get uploadedCount => documents.where((d) => d.isUploaded).length;
}
