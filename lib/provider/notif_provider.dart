import 'package:easyhealth/models/notif_model.dart';
import 'package:easyhealth/services/firestore_service.dart';
import 'package:flutter/material.dart';

class NotifProvider with ChangeNotifier {
  final firebase = FirestoreService();
  List<NotifModel> notification = [];

  void getMyNotification(String userId) {
    print("USER ID === $userId");

    firebase.firestore
        .collection("notification")
        .where("userId", isEqualTo: userId)
        .snapshots()
        .listen((snapshot) {
          notification = snapshot.docs
              .map((doc) => NotifModel.fromJson(doc.data()))
              .toList();

          notifyListeners();
        });
  }

  Stream<List<NotifModel>> getNotif(String userId) {
    return firebase.firestore
        .collection("notification")
        .where("userId", isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => NotifModel.fromJson(doc.data()))
              .toList();
        });
  }
}
