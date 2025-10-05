class HospitalModel {
  final String? id;
  final String? name;
  final String? address;
  final String? numberPhone;
  final String? email;
  final String? userId;
  final String? open;
  final String? room;
  final String? image;

  const HospitalModel({
    this.id,
    this.address,
    this.name,
    this.numberPhone,
    this.email,
    this.userId,
    this.open,
    this.room,
    this.image,
  });

  // factory untuk parsing dari JSON
  factory HospitalModel.fromJson(Map<String, dynamic> json) {
    return HospitalModel(
      id: json["id"] ?? "",
      address: json["address"] ?? "",
      name: json["name"] ?? "",
      numberPhone: json["numberPhone"] ?? "",
      email: json["email"] ?? "",
      userId: json["userId"] ?? "",
      open: json["open"] ?? "",
      room: json["room"] ?? "",
      image: json['image'] ?? "",
    );
  }
}
