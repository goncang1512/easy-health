class RoomModel {
  final String id;
  final List<MessageModel> message;

  RoomModel({required this.id, required this.message});

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'],
      message: json['message'].isNotEmpty
          ? json["message"].map((item) => MessageModel.fromJson(item)).toList()
          : [],
    );
  }
}

class MessageModel {
  final String? id;
  final String? text;
  final String? senderId;

  MessageModel({this.id, this.text, this.senderId});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      text: json['text'],
      senderId: json['senderId'],
    );
  }
}
