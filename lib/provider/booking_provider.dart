import 'package:easyhealth/models/docter_model.dart';
import 'package:easyhealth/utils/fetch.dart';
import 'package:flutter/material.dart';

class BookingProvider with ChangeNotifier {
  final String docterId;
  BookingProvider({required this.docterId});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final descController = TextEditingController();

  Future<DocterModel?> getDetailDocter() async {
    try {
      final result = await HTTP.get("/api/docter/detail-docter/$docterId");
      return DocterModel.fromJson(result["result"]);
    } catch (error) {
      return null;
    }
  }

  Future<bool> onSubmit(String hospitalId, String docterId) async {
    _isLoading = true;
    notifyListeners();
    try {
      await HTTP.post(
        "/api/booking",
        body: {
          "name": nameController.text,
          "bookDate": dateController.text,
          "bookTime": timeController.text,
          "noPhone": numberController.text,
          "docterId": docterId,
          "hospitalId": hospitalId,
        },
      );

      return true;
    } catch (error) {
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
