import 'package:easyhealth/widgets/add_docter/form_add_docter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddDocterScreen extends StatelessWidget {
  final String hospitalId;
  const AddDocterScreen({super.key, required this.hospitalId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text("Tambahkan Dokter"),
        centerTitle: true,
        backgroundColor: Color(0xFF10B981),
        foregroundColor: Colors.white,
        // biar icon/teks jadi hitam
      ),
      body: SingleChildScrollView(
        child: Column(children: [FormAddDocter(method: "CREATE")]),
      ),
    );
  }
}
