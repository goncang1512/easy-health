import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Global ValueNotifier untuk komunikasi antar widget
final searchController = ValueNotifier<String>('');

class InputSearchField extends StatefulWidget {
  final String? keyword;
  const InputSearchField({super.key, this.keyword});

  @override
  State<InputSearchField> createState() => InputComponent();
}

class InputComponent extends State<InputSearchField> {
  final TextEditingController _searchController = TextEditingController();
  late final VoidCallback _listener;

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.keyword ?? "";

    // Buat listener yang bisa dihapus nanti
    _listener = () {
      if (searchController.value == 'clear') {
        _searchController.clear();
        // setelah clear, reset value supaya tidak terus trigger
        searchController.value = '';
      }
    };

    searchController.addListener(_listener);
  }

  @override
  void dispose() {
    searchController.removeListener(_listener);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String value) {
    context.push("/search?keyword=$value");
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
