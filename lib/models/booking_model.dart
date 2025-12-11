import 'package:easyhealth/models/session_models.dart';

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
      bookingId: json['bookingNumber'],
      status: json['status'],
      doctorName: json['docter']['user']['name'],
      doctorSpecialist: json['docter']['specialits'],
      doctorImage: json['docter']['photoUrl'],
      hospital: json['docter']['hospital']['name'],
      date: json['bookDate'],
      time: json['bookTime'],
      queueNumber: json['bookingNumber'],
      price: json['price']?? '0',
      paymentMethod: json['paymentMethod']?? 'Unknown', 
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
