import 'package:easyhealth/pages/search_screen.dart';
import 'package:easyhealth/utils/navigation_helper.dart';
import 'package:flutter/material.dart';

class InputSearchField extends StatefulWidget {
  const InputSearchField({super.key});

  @override
  State<InputSearchField> createState() => InputComponent();
}

class InputComponent extends State<InputSearchField> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose(); // jangan lupa dispose biar gak memory leak
    super.dispose();
  }

  void _onSearch(String value) {
    NavigationHelper.push(
      context,
      SearchScreen(keyword: _searchController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // background putih
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.1), // warna shadow
            blurRadius: 6, // seberapa blur
            offset: const Offset(0, 3), // posisi shadow (bawah)
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: _searchController,
          onSubmitted: _onSearch,
          decoration: InputDecoration(
            hintText: "Cari rumah sakit atau dokter",
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            filled: true,
            fillColor: Colors.grey.shade200,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
