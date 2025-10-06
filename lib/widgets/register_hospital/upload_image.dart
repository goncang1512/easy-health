import 'dart:io';
import 'package:easyhealth/provider/hospital_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ImageUploadPreview extends StatefulWidget {
  const ImageUploadPreview({super.key});

  @override
  State<ImageUploadPreview> createState() => _ImageUploadPreviewState();
}

class _ImageUploadPreviewState extends State<ImageUploadPreview> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final provider = context.read<HospitalProvider>();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        File file = File(pickedFile.path);
        provider.setImage(file);
        _selectedImage = file;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final hospitalProvider = context.watch<HospitalProvider>();
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
          child: _buildImagePreview(hospitalProvider),
        ),
      ),
    );
  }

  Widget _buildImagePreview(HospitalProvider hospitalProvider) {
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
    if (hospitalProvider.imageUrl != null &&
        hospitalProvider.imageUrl!.isNotEmpty) {
      return Image.network(
        hospitalProvider.imageUrl!,
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
            "Tap to upload image",
            style: TextStyle(color: Colors.grey.shade800),
          ),
        ],
      ),
    );
  }
}
