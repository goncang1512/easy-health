import 'package:easyhealth/models/session_models.dart';
import 'package:easyhealth/utils/fetch.dart';
import 'package:flutter/material.dart';

class HospitalProvider with ChangeNotifier {
  final UserSession? session;

  HospitalProvider({required this.session});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final nameHospital = TextEditingController();
  final numberHospital = TextEditingController();
  final emailHospital = TextEditingController();
  final addressHospital = TextEditingController();
  final openHospital = TextEditingController();
  final roomHospital = TextEditingController();

  Future registerHospital() async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await HTTP.post(
        "/api/hospital",
        body: {
          "name": nameHospital.text,
          "address": addressHospital.text,
          "email": emailHospital.text,
          "numberPhone": numberHospital.text,
          "open": openHospital.text,
          "room": roomHospital.text,
          "admin_id": session?.user.id,
        },
      );

      return data;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future updateHospital(String hospitalId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await HTTP.put(
        "/api/hospital/edit/$hospitalId",
        body: {
          "name": nameHospital.text,
          "address": addressHospital.text,
          "email": emailHospital.text,
          "numberPhone": numberHospital.text,
          "open": openHospital.text,
          "room": roomHospital.text,
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

  Future getDetailHospital(String hospitalId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await HTTP.get("/api/hospital/$hospitalId");
      final data = result["result"];

      nameHospital.text = data['name'] ?? '';
      numberHospital.text = data['numberPhone'] ?? '';
      emailHospital.text = data['email'] ?? '';
      addressHospital.text = data['address'] ?? '';
      openHospital.text = data['open'] ?? '';
      roomHospital.text = data['room'].toString();

      return result;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
