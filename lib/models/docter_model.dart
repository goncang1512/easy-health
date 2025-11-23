class DocterModel {
  final String id;
  final String name;
  final String specialits;
  final String? photoUrl;
  final String? photoId;
  final String status;
  final HospitalDocter? hospital;

  DocterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.specialits,
    this.photoUrl,
    this.photoId,
    this.hospital,
  });

  factory DocterModel.fromJson(Map<String, dynamic> json) {
    return DocterModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      specialits: json['specialits'],
      photoUrl: json['photoUrl'],
      photoId: json['photoId'],
      hospital: json['hospital'] != null
          ? HospitalDocter.fromJson(json['hospital'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialits': specialits,
      'photoUrl': photoUrl,
      'photoId': photoId,
      'hospital': hospital?.toJson(),
    };
  }
}

class HospitalDocter {
  final String? id;
  final String name;

  HospitalDocter({this.id, required this.name});

  factory HospitalDocter.fromJson(Map<String, dynamic> json) {
    return HospitalDocter(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
