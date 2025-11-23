import 'dart:convert';
import 'dart:io';

import 'package:easyhealth/models/docter_model.dart';
import 'package:easyhealth/models/session_models.dart';
import 'package:easyhealth/utils/fetch.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DocterProvider with ChangeNotifier {
  UserSession? session;
  String? docterId;

  DocterProvider({this.session, this.docterId});

  final TextEditingController name = TextEditingController();
  final TextEditingController spesialis = TextEditingController();
  final TextEditingController hospitalName = TextEditingController();
  Map<String, dynamic> schedule = {};
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? imageUrl;
  String? imageId;
  File? _image;
  File? get image => _image;

  void setImage(File? file) {
    _image = file;
    notifyListeners();
  }

  void updateSchedule(
    String hari,
    bool aktif,
    String jamMulai,
    String jamSelesai,
  ) {
    if (aktif) {
      schedule[hari] = {"active": true, "start": jamMulai, "due": jamSelesai};
    } else {
      schedule.remove(hari);
    }
    notifyListeners();
  }

  Future<Map<String, Object>> regisDokter() async {
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

      final result = await HTTP.post(
        "/api/docter",
        body: {
          "name": name.text,
          "user_id": session?.user.id,
          "specialits": spesialis.text,
          "schedule": jsonEncode(schedule),
          "hospital_name": hospitalName.text,
          "secure_url": secureUrl,
          "public_id": publicId,
        },
      );

      return {"status": result["status"], "message": result["message"]};
    } catch (error) {
      return {"status": false, "message": "Gagal mengirim booking: $error"};
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<List<DocterModel>> getListDocter() async {
    try {
      final result = await HTTP.get("/api/docter/${session?.hospital?.id}");
      final List<dynamic> data = result["result"];

      return data.map((item) => DocterModel.fromJson(item)).toList();
    } catch (error) {
      return [];
    }
  }

  Future getDetailDocter() async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await HTTP.get("/api/docter/edit-detail/$docterId");
      final data = result["result"];

      name.text = data['name'] ?? '';
      hospitalName.text = session?.hospital?.name ?? "";
      spesialis.text = data['specialits'] ?? '';
      imageUrl = data["photoUrl"];
      imageId = data["photoId"];

      if (data["schedule"] != null && data["schedule"] is Map) {
        final dbSchedule = Map<String, dynamic>.from(data["schedule"]);

        // Gunakan method updateSchedule() untuk setiap hari
        dbSchedule.forEach((hari, value) {
          updateSchedule(
            hari,
            value["active"] ?? false,
            value["start"] ?? "09:00",
            value["due"] ?? "17:00",
          );
        });
      }

      return result;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Map<String, Object>> updateDocter() async {
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
          ..fields['folder'] = "docter"
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

      final result = await HTTP.put(
        "/api/docter/edit-docter/$docterId",
        body: {
          "name": name.text,
          "specialits": spesialis.text,
          "schedule": jsonEncode(schedule),
          "secure_url": secureUrl,
          "public_id": publicId,
          "old_public": imageId,
        },
      );

      return {"status": result["status"], "message": result["message"]};
    } catch (error) {
      return {"status": false, "message": "Gagal mengirim booking: $error"};
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateStatusDocter(String docterId, String status) async {
    final result = await HTTP.put(
      "/api/docter/status/$docterId",
      body: {"status": status},
    );

    if (result['status']) {
      return true;
    } else {
      return false;
    }
  }
}
