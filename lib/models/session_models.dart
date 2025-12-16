// session_models.dart

class User {
  final String id;
  final String email;
  final String name;
  final String? image;
  final String role;
  final String? phone; 
  final String? address; 

  User({
    required this.id,
    required this.email,
    required this.name,
    this.image,
    required this.role,
    this.phone,
    this.address,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String, 
      email: map['email'] as String,
      name: map['name'] as String,
      image: map['image'] as String?, 
      role: map['role'] as String,
      phone: map['phone'] as String?, 
      address: map['address'] as String?, 
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'image': image,
      'role': role,
      'phone': phone,
      'address': address,
    };
  }
}

extension UserCopy on User {
  User copyWith({
    String? phone,
    String? address,
    String? image,
    String? name,
  }) {
    return User(
      id: id,
      email: email,
      name: name ?? this.name,
      role: role,
      image: image ?? this.image,
      phone: phone ?? this.phone,
      address: address ?? this.address,
    );
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

class DocterSession {
  final String id;
  final String specialits;
  final String photoUrl;

  const DocterSession({
    required this.id,
    required this.specialits,
    required this.photoUrl,
  });

  factory DocterSession.fromMap(Map<String, dynamic> map) {
    return DocterSession(
      id: map['id'],
      specialits: map['specialits'],
      photoUrl: map['photoUrl'],
    );
  }
}

class UserSession {
  final User user;
  final SessionData session;
  final HospitalData? hospital;
  final DocterSession? docter;

  UserSession({
    required this.user,
    required this.session,
    this.hospital,
    this.docter,
  });

  factory UserSession.fromMap(
    Map<String, dynamic> user,
    Map<String, dynamic> session,
    Map<String, dynamic>? hospital,
    Map<String, dynamic>? docter,
  ) {
    return UserSession(
      user: User.fromMap(user),
      session: SessionData.fromMap(session),
      hospital: hospital != null ? HospitalData.fromMap(hospital) : null,
      docter: docter != null ? DocterSession.fromMap(docter) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {'user': user.toMap(), 'sessionData': session.toMap()};
  }

  UserSession copyWith({
    User? user,
    HospitalData? hospital,
    SessionData? session,
    DocterSession? docter,
  }) {
    return UserSession(
      user: user ?? this.user,
      session: session ?? this.session,
      hospital: hospital ?? this.hospital,
      docter: docter ?? this.docter,
    );
  }
}