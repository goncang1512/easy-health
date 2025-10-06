import 'dart:convert';
import 'dart:io';

import 'package:easyhealth/models/session_models.dart';
import 'package:easyhealth/utils/fetch.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  String? imageUrl;
  String? imageId;
  File? _image;
  File? get image => _image;

  void setImage(File? file) {
    _image = file;
    notifyListeners();
  }

  Future registerHospital() async {
    _isLoading = true;
    notifyListeners();

    try {
      String secureUrl = "";
      String publicId = "";

      if (image != null) {
        final url = Uri.parse(
          "https://api.cloudinary.com/v1_1/dykunvz4p/upload",
        );

        final request = http.MultipartRequest("POST", url)
          ..fields['upload_preset'] = "eccomerce_app"
          ..files.add(await http.MultipartFile.fromPath("file", image!.path));

        final response = await request.send();

        if (response.statusCode == 200) {
          final responseData = await response.stream.toBytes();
          final responseString = String.fromCharCodes(responseData);
          final jsonMap = jsonDecode(responseString);

          publicId = jsonMap["public_id"];
          secureUrl = jsonMap["secure_url"];
        } else {
          debugPrint("Upload Cloudinary gagal: ${response.statusCode}");
        }
      }

      await HTTP.post(
        "/api/hospital",
        body: {
          "name": nameHospital.text,
          "address": addressHospital.text,
          "email": emailHospital.text,
          "numberPhone": numberHospital.text,
          "open": openHospital.text,
          "room": roomHospital.text,
          "admin_id": session?.user.id,
          "secure_url": secureUrl,
          "public_id": publicId,
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

  Future updateHospital(String hospitalId) async {
    _isLoading = true;
    notifyListeners();

    try {
      String secureUrl = imageUrl.toString();
      String publicId = imageId.toString();

      if (image != null) {
        final url = Uri.parse(
          "https://api.cloudinary.com/v1_1/dykunvz4p/upload",
        );

        final request = http.MultipartRequest("POST", url)
          ..fields['upload_preset'] = "eccomerce_app"
          ..files.add(await http.MultipartFile.fromPath("file", image!.path));

        final response = await request.send();

        if (response.statusCode == 200) {
          final responseData = await response.stream.toBytes();
          final responseString = String.fromCharCodes(responseData);
          final jsonMap = jsonDecode(responseString);

          publicId = jsonMap["public_id"];
          secureUrl = jsonMap["secure_url"];
        } else {
          debugPrint("Upload Cloudinary gagal: ${response.statusCode}");
        }
      }

      await HTTP.put(
        "/api/hospital/edit/$hospitalId",
        body: {
          "name": nameHospital.text,
          "address": addressHospital.text,
          "email": emailHospital.text,
          "numberPhone": numberHospital.text,
          "open": openHospital.text,
          "room": roomHospital.text,
          "secure_url": secureUrl,
          "public_id": publicId,
          "old_public": imageId,
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
      imageUrl = data["image"];
      imageId = data["imageId"];

      return result;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future enrollHospital() async {
    try {
      _isLoading = true;
      notifyListeners();

      final data = await HTTP.delete("/api/admin/${session?.user.id}");

      return data;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
