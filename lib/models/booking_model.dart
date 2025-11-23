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
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      bookingId: json['bookingId'],
      status: json['status'],
      doctorName: json['doctorName'],
      doctorSpecialist: json['doctorSpecialist'],
      doctorImage: json['doctorImage'],
      hospital: json['hospital'],
      date: json['date'],
      time: json['time'],
      queueNumber: json['queueNumber'],
      price: json['price'],
      paymentMethod: json['paymentMethod'],
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
    };
  }
}
