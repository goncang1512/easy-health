import 'package:flutter/material.dart';

class InputSearchComponent extends StatelessWidget {
  final String? keyword;
  final String? placeholder;
  final TextEditingController? controller;
  final ValueChanged<String>? onSubmit;

  const InputSearchComponent({
    super.key,
    this.keyword,
    this.placeholder,
    this.controller,
    this.onSubmit,
  });

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
          controller: controller,
          onSubmitted: onSubmit,
          decoration: InputDecoration(
            hintText: placeholder,
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
