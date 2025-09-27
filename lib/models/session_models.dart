class User {
  final String id;
  final String email;
  final String name;
  final String? image;

  User({required this.id, required this.email, required this.name, this.image});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      image: map['image'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'email': email, 'name': name, 'image': image};
  }
}

class SessionData {
  final String token;
  final DateTime expiresAt;
  final String id;
  final DateTime createdAt;

  SessionData({
    required this.token,
    required this.expiresAt,
    required this.id,
    required this.createdAt,
  });

  factory SessionData.fromMap(Map<String, dynamic> map) {
    return SessionData(
      token: map['token'],
      expiresAt: DateTime.parse(map['expiresAt']),
      id: map['id'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'expiresAt': expiresAt.toIso8601String(),
      'id': id,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class UserSession {
  final User user;
  final SessionData session;

  UserSession({required this.user, required this.session});

  factory UserSession.fromMap(Map<String, dynamic> map) {
    return UserSession(
      user: User.fromMap(map['result']["user"]),
      session: SessionData.fromMap(map['result']["session"]),
    );
  }

  Map<String, dynamic> toMap() {
    return {'user': user.toMap(), 'sessionData': session.toMap()};
  }
}
