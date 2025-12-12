class NotifModel {
  final String id;
  final String title;
  final String message;
  final bool read;

  NotifModel({
    required this.id,
    required this.title,
    required this.message,
    required this.read,
  });

  factory NotifModel.fromJson(Map<String, dynamic> json) {
    return NotifModel(
      id: json['id'] ?? "",
      title: json['title'] ?? "",
      message: json['message'] ?? "",
      read: json['read'] ?? false,
    );
  }
}
