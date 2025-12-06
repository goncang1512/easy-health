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
        .orderBy("createdAt", descending: false)
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
        .asyncMap((roomsSnapshot) async {
          List<Map<String, dynamic>> result = [];

          for (var roomDoc in roomsSnapshot.docs) {
            final latestMessageSnap = await roomDoc.reference
                .collection("message")
                .orderBy("createdAt", descending: true)
                .limit(1)
                .get();

            final latestMessage = latestMessageSnap.docs.isNotEmpty
                ? latestMessageSnap.docs.first.data()
                : null;

            result.add({
              "id": roomDoc.id,
              ...roomDoc.data(),
              "latestMessage": latestMessage!['text'],
            });
          }

          return result;
        });
  }
}
