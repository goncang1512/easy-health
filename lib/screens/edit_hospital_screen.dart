import 'package:easyhealth/provider/hospital_provider.dart';
import 'package:easyhealth/provider/session_provider.dart';
import 'package:easyhealth/widgets/register_hospital/form_register_hospital.dart';
import 'package:easyhealth/widgets/register_hospital/more_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EditHospitalScreen extends StatefulWidget {
  final String hospitalId;
  const EditHospitalScreen({super.key, required this.hospitalId});

  @override
  State<EditHospitalScreen> createState() => _EditHospitalScreen();
}

class _EditHospitalScreen extends State<EditHospitalScreen> {
  @override
  Widget build(BuildContext context) {
    final data = context.read<SessionManager>();

    return ChangeNotifierProvider(
      create: (_) => HospitalProvider(session: data.session),
      child: Scaffold(
        appBar: AppBar(
          actions: [MoreList()],
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text("Edit Rumah Sakit"),
          centerTitle: true,
          backgroundColor: Color(0xFF10B981),
          foregroundColor: Colors.white,
          // biar icon/teks jadi hitam
        ),
        body: FormBody(hospitalId: widget.hospitalId),
      ),
    );
  }
}

class FormBody extends StatefulWidget {
  final String hospitalId;
  const FormBody({super.key, required this.hospitalId});

  @override
  State<FormBody> createState() => _FormBody();
}

class _FormBody extends State<FormBody> {
  Future? _detailHospitalFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<HospitalProvider>();
      _detailHospitalFuture = provider.getDetailHospital(widget.hospitalId);
      setState(() {}); // trigger rebuild FutureBuilder setelah future di-set
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _detailHospitalFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              FormRegisterHospital(
                method: "PUT",
                hospitalId: widget.hospitalId,
              ),
            ],
          ),
        );
      },
    );
  }
}
