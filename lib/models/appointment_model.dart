import 'package:easyhealth/utils/fetch.dart';

class Appointment {
  final String id;
  final String name;
  final String status;
  final String bookTime;
  final String bookDate;

  Appointment({
    required this.id,
    required this.name,
    required this.status,
    required this.bookTime,
    required this.bookDate,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      name: json["name"],
      status: json["status"],
      bookTime: json["bookTime"],
      bookDate: json["bookDate"],
    );
  }
}

Future<List<Appointment>> fetchDoctorDashboard(String docterId) async {
  final result = await HTTP.get("/api/docter/dashboard/$docterId");
  final List<dynamic> data = result["result"];

  if (result['statusCode'] == 200) {
    return data.map((item) => Appointment.fromJson(item)).toList();
  } else {
    throw Exception("Failed to load dashboard data");
  }
}

Future<bool> updateStatusBooking(String bookingId, String status) async {
  final result = await HTTP.put(
    "/api/booking/status/$bookingId",
    body: {"status": status},
  );

  if (result['status']) {
    return true;
  } else {
    return false;
  }
}
