// ignore_for_file: use_build_context_synchronously

import 'package:easyhealth/utils/get_session.dart';
import 'package:flutter/material.dart';
import 'package:easyhealth/utils/theme.dart';
import 'package:easyhealth/models/session_models.dart';
import 'package:easyhealth/utils/fetch.dart'; // Digunakan untuk simulasi HTTP.post

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileScreen> {
  User? user;
  bool _isLoading = true;
  bool _isSaving = false; // Status untuk tombol simpan
  bool _isEditing = false; // Status mode edit

  // Controllers untuk field yang dapat diedit
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  final Color primaryColor = ThemeColors.primary;
  final Color secondaryColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _loadSessionData();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _loadSessionData() async {
    final UserSession? sessionData = await UseSession.getSession();

    setState(() {
      if (sessionData != null) {
        user = sessionData.user;
        _phoneController.text = user!.phone ?? "";
        _addressController.text = user!.address ?? "";
      } else {
        user = null;
      }
      _isLoading = false;
      _isEditing = false;
    });
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  
  void _saveProfile() async {
    if (!_isEditing || _isSaving) return;

    setState(() {
      _isSaving = true;
    });

    try {
      final newPhone = _phoneController.text;
      final newAddress = _addressController.text;

      final UserSession? currentSession = await UseSession.getSession();
      final String? token = currentSession?.session.token;

      if (token == null) {
        throw Exception("Token tidak ditemukan. Silakan login ulang.");
      }

      final response = await HTTP.post(
        "/api/user/update-profile",
        headers: {"Authorization": "Bearer $token"},
        body: {"userId": user!.id, "phone": newPhone, "address": newAddress},
      );

      if (response["status"] == "success") {
        final updatedUserMap = response["data"]["user"] as Map<String, dynamic>;
        final updatedUser = User.fromMap(updatedUserMap);

        setState(() {
          user = updatedUser;
          _isEditing = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profil berhasil diperbarui!")),
        );
      } else {
        throw Exception(response["message"] ?? "Gagal menyimpan data.");
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  Widget _buildProfileField({
    required String label,
    required String value,
    TextEditingController? controller,
    bool isEditable = false,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 4),
        Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: isEditable && _isEditing
                  ? primaryColor
                  : Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(8),
            color: isEditable && _isEditing
                ? Colors.white
                : Colors.grey.shade50,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: isEditable && _isEditing
              ? TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  keyboardType: label == "Telepon"
                      ? TextInputType.phone
                      : TextInputType.text,
                  style: const TextStyle(fontSize: 16),
                )
              : isPassword
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(value, style: const TextStyle(fontSize: 16)),
                    Text(
                      'lihat sel...',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              : Align(
                  alignment: Alignment.centerLeft,
                  child: Text(value, style: const TextStyle(fontSize: 16)),
                ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (user == null) {
      Future.microtask(() => UseSession.logOut(context));
      return const Scaffold(
        body: Center(child: Text("Sesi berakhir. Mengalihkan...")),
      );
    }

    final String userName = user!.name;
    final String userEmail = user!.email;
    final String userImage = user!.image ?? "";

    return Scaffold(
      backgroundColor: ThemeColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    primaryColor,
                    primaryColor.withOpacity(0.8),
                    primaryColor.withOpacity(0.3),
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const Expanded(
                            child: Text(
                              "Profil",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(width: 48),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    ClipOval(
                      child: (userImage.isNotEmpty)
                          ? Image.network(
                              userImage,
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                    Icons.person,
                                    size: 90,
                                    color: Colors.white70,
                                  ),
                            )
                          : const Icon(
                              Icons.person,
                              size: 90,
                              color: Colors.white70,
                            ),
                    ),
                  ],
                ),
              ),
            ),

            Transform.translate(
              offset: const Offset(0, -30),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            userName,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: _isEditing ? _saveProfile : _toggleEditMode,
                          child: _isEditing
                              ? _isSaving
                                    ? SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: primaryColor,
                                        ),
                                      )
                                    : Icon(
                                        Icons.check_circle,
                                        color: primaryColor,
                                        size: 24,
                                      )
                              : Icon(Icons.edit, color: primaryColor, size: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "peduli diri = peduli sekitar",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 24),

                    _buildProfileField(label: "Email", value: userEmail),
                    _buildProfileField(
                      label: "Telepon",
                      value: user!.phone ?? "Telepon tidak tersedia",
                      controller: _phoneController,
                      isEditable: true,
                    ),
                    _buildProfileField(
                      label: "Alamat",
                      value: user!.address ?? "Alamat tidak tersedia",
                      controller: _addressController,
                      isEditable: true,
                    ),
                    _buildProfileField(
                      label: "Password",
                      value: "**************",
                      isPassword: true,
                    ),

                    const SizedBox(height: 8),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: secondaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          UseSession.logOut(context);
                        },
                        child: const Text(
                          "Logout",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
