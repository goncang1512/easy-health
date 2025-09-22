import 'package:flutter/material.dart';

class BookingProvider with ChangeNotifier {
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final descController = TextEditingController();
}
