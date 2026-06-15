class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String userType;
  final String? photoUrl;
  final DateTime createdAt;
  final Map<String, dynamic>? additionalData;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.userType,
    this.photoUrl,
    required this.createdAt,
    this.additionalData,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'userType': userType,
        'photoUrl': photoUrl,
        'createdAt': createdAt.toIso8601String(),
        'additionalData': additionalData,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        phone: json['phone'],
        userType: json['userType'] ?? 'patient',
        photoUrl: json['photoUrl'],
        createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
        additionalData: json['additionalData'],
      );
}
