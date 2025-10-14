class AdminModel {
  final String id;
  final UserAdmin user;

  AdminModel({required this.id, required this.user});

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      id: json['id'] ?? "",
      user: UserAdmin.fromJson(json['user']),
    );
  }
}

class UserAdmin {
  final String id;
  final String name;

  UserAdmin({required this.id, required this.name});

  factory UserAdmin.fromJson(Map<String, dynamic> json) {
    return UserAdmin(id: json['id'], name: json['name']);
  }
}
