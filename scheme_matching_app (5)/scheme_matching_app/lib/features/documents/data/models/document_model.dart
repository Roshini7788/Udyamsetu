class DocumentModel {
  final String name;
  final String description;
  bool isUploaded;

  DocumentModel({
    required this.name,
    required this.description,
    this.isUploaded = false,
  });
}
