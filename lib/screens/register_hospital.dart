import 'package:easyhealth/provider/hospital_provider.dart';
import 'package:easyhealth/provider/session_provider.dart';
import 'package:easyhealth/widgets/register_hospital/form_register_hospital.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegisterHospital extends StatelessWidget {
  const RegisterHospital({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.watch<SessionManager>();

    return ChangeNotifierProvider(
      create: (_) => HospitalProvider(session: data.session),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text(
            "Daftar Rumah Sakit",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFFFFFFFF),
          foregroundColor: Colors.black,
          // biar icon/teks jadi hitam
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: [FormRegisterHospital(method: "CREATE")]),
          ),
        ),
      ),
    );
  }
}
