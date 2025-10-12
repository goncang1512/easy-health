class User {
  final String id;
  final String email;
  final String name;
  final String? image;
  final String role;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.image,
    required this.role,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      image: map['image'],
      role: map['role'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'image': image,
      'role': role,
    };
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

class HospitalData {
  final String id;
  final String name;
  final String address;

  const HospitalData({
    required this.id,
    required this.name,
    required this.address,
  });

  factory HospitalData.fromMap(Map<String, dynamic> map) {
    return HospitalData(
      id: map['id'],
      name: map['name'],
      address: map['address'],
    );
  }
}

class UserSession {
  final User user;
  final SessionData session;
  final HospitalData? hospital;

  UserSession({required this.user, required this.session, this.hospital});

  factory UserSession.fromMap(
    Map<String, dynamic> user,
    Map<String, dynamic> session,
    Map<String, dynamic>? hospital,
  ) {
    return UserSession(
      user: User.fromMap(user),
      session: SessionData.fromMap(session),
      hospital: hospital != null ? HospitalData.fromMap(hospital) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {'user': user.toMap(), 'sessionData': session.toMap()};
  }

  UserSession copyWith({
    User? user,
    HospitalData? hospital,
    SessionData? session,
  }) {
    return UserSession(
      user: user ?? this.user,
      session: session ?? this.session, // session/token tetap sama
      hospital: hospital ?? this.hospital,
    );
  }
}
