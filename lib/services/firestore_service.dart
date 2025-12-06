import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyhealth/models/message_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ignore: unused_element
  CollectionReference _messagesCollection() {
    return _firestore.collection("message");
  }

  Stream<List<MessageModel>> getMessageRoom(String roomId) {
    return _firestore
        .collection("message")
        .where("roomid", isEqualTo: roomId)
        .orderBy("createdAt", descending: false)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => MessageModel.fromJson(doc.data()))
              .toList();
        });
  }
}
