import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadPreview extends StatefulWidget {
  final void Function(File) setImage;
  final String? imageUrl;
  final String placeholder;
  const ImageUploadPreview({
    super.key,
    required this.setImage,
    this.imageUrl,
    required this.placeholder,
  });

  @override
  State<ImageUploadPreview> createState() => _ImageUploadPreviewState();
}

class _ImageUploadPreviewState extends State<ImageUploadPreview> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        File file = File(pickedFile.path);
        widget.setImage(file);
        _selectedImage = file;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.8),
          color: const Color.fromARGB(
            255,
            240,
            240,
            240,
          ), // warna gelap seperti preview
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: _buildImagePreview(widget.imageUrl),
        ),
      ),
    );
  }

  Widget _buildImagePreview(String? imageUrl) {
    // 1️⃣ Jika user baru saja pilih gambar (local file)
    if (_selectedImage != null) {
      return Image.file(
        _selectedImage!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    // 2️⃣ Jika ada gambar dari Cloudinary / server
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
        errorBuilder: (context, error, stackTrace) {
          return const Center(child: Icon(Icons.broken_image, size: 48));
        },
      );
    }

    // 3️⃣ Jika belum ada gambar sama sekali
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.camera_alt_outlined,
            color: Colors.grey.shade800,
            size: 48,
          ),
          const SizedBox(height: 8),
          Text(
            widget.placeholder,
            style: TextStyle(color: Colors.grey.shade800),
          ),
        ],
      ),
    );
  }
}
