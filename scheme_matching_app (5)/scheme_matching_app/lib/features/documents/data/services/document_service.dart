import '../models/document_model.dart';
import '../../../scheme_matching/data/services/dummy_data.dart';

class DocumentService {
  Future<List<DocumentModel>> requiredDocumentsFor(String schemeId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return DummyData.documentsFor(schemeId);
  }
}
