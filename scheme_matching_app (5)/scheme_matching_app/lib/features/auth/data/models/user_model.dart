class UserModel {
  final String id;
  final String name;
  final String phoneOrEmail;

  const UserModel({
    required this.id,
    required this.name,
    required this.phoneOrEmail,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? json['id'],
      name: json['name'],
      phoneOrEmail: json['phoneOrEmail'] ?? json['email'] ?? json['phone'],
    );
  }
}
