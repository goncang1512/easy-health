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
        .collection("room")
        .doc(roomId)
        .collection("message")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => MessageModel.fromJson(doc.data()))
              .toList();
        });
  }

  Stream<List<Map<String, dynamic>>> getRoomsByHospitalId(String hospitalId) {
    return _firestore
        .collection("room")
        .where("hospitalId", isEqualTo: hospitalId)
        .snapshots()
        .asyncMap((roomSnapshot) async {
          // Jalankan query subcollection secara paralel (tanpa for)
          final futures = roomSnapshot.docs.map((roomDoc) async {
            final msgSnap = await roomDoc.reference
                .collection("message")
                .orderBy("createdAt", descending: true)
                .limit(1)
                .get();

            final latestMsg = msgSnap.docs.isNotEmpty
                ? msgSnap.docs.first.data()
                : {"text": "", "createdAt": null};

            return {
              "id": roomDoc.id,
              ...roomDoc.data(),
              "latestMessage": latestMsg["text"],
              "latestMessageTime": latestMsg["createdAt"],
            };
          }).toList();

          // Tunggu semua async task selesai
          return Future.wait(futures);
        });
  }
}
