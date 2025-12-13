class BookingModel {
  final String bookingId;
  final String status;
  final String doctorName;
  final String doctorSpecialist;
  final String doctorImage;
  final String hospital;
  final String date;
  final String time;

  final String queueNumber;
  final String price;
  final String paymentMethod;

  // Field tambahan untuk detail booking
  final String? note;
  final String? userId;
  final String? noPhone;
  final String? hospitalId;
  final String? createdAt;
  final String? updatedAt;

  BookingModel({
    required this.bookingId,
    required this.status,
    required this.doctorName,
    required this.doctorSpecialist,
    required this.doctorImage,
    required this.hospital,
    required this.date,
    required this.time,
    required this.queueNumber,
    required this.price,
    required this.paymentMethod,
    this.note,
    this.userId,
    this.noPhone,
    this.hospitalId,
    this.createdAt,
    this.updatedAt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    final docter = json['docter'] ?? {};
    final user = docter['user'] ?? {};
    final hospital = docter['hospital'] ?? {};

    return BookingModel(
      bookingId: json['bookingNumber'] ?? '',
      status: json['status'] ?? '',
      doctorName: user['name'] ?? '',
      doctorSpecialist: docter['specialits'] ?? '',
      doctorImage: docter['photoUrl'] ?? '',
      hospital: hospital['name'] ?? '',
      date: json['bookDate'] ?? '',
      time: json['bookTime'] ?? '',
      queueNumber: json['bookingNumber'] ?? '',
      price: json['price'] ?? '0',
      paymentMethod: json['paymentMethod'] ?? 'Unknown',
      note: json['note'], // opsional
      userId: json['userId'], // opsional
      noPhone: json['noPhone'], // opsional
      hospitalId: json['hospitalId'], // opsional
      createdAt: json['createdAt'], // opsional
      updatedAt: json['updatedAt'], // opsional
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookingId': bookingId,
      'status': status,
      'doctorName': doctorName,
      'doctorSpecialist': doctorSpecialist,
      'doctorImage': doctorImage,
      'hospital': hospital,
      'date': date,
      'time': time,
      'queueNumber': queueNumber,
      'price': price,
      'paymentMethod': paymentMethod,
      'note': note,
      'userId': userId,
      'noPhone': noPhone,
      'hospitalId': hospitalId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
