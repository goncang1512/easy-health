import 'package:flutter/material.dart';

class TextFieldLogin extends StatefulWidget {
  final String label;
  final String placeholder;
  final IconData icon;
  final String type;
  final TextEditingController controller;
  final FormFieldValidator? validator;

  const TextFieldLogin({
    super.key,
    required this.label,
    required this.controller,
    required this.placeholder,
    this.validator,
    required this.icon,
    this.type = "text",
  });

  @override
  State<TextFieldLogin> createState() => _TextFieldLogin();
}

class _TextFieldLogin extends State<TextFieldLogin> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 8), // jarak antara label dan field
        TextFormField(
          validator: widget.validator,
          controller: widget.controller,
          obscureText: widget.type == "password" ? _obscureText : false,
          decoration: InputDecoration(
            suffixIcon: widget.type == "password"
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                  )
                : null,
            hintText: widget.placeholder,
            hintStyle: const TextStyle(color: Colors.grey),
            prefixIcon: Icon(widget.icon, color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 16,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.green, width: 1.5),
            ),
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
