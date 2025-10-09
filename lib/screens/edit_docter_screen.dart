import 'package:easyhealth/provider/docter_provider.dart';
import 'package:easyhealth/widgets/add_docter/form_add_docter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EditDocterScreen extends StatefulWidget {
  final String docterId;
  const EditDocterScreen({super.key, required this.docterId});

  @override
  State<EditDocterScreen> createState() => _EditDocterScreen();
}

class _EditDocterScreen extends State<EditDocterScreen> {
  Future? _detailDocterFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<DocterProvider>();
      _detailDocterFuture = provider.getDetailDocter();
      setState(() {}); // trigger rebuild FutureBuilder setelah future di-set
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          "Edit Dokter",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF10B981),
        foregroundColor: Colors.white,
        // biar icon/teks jadi hitam
      ),
      body: FutureBuilder(
        future: _detailDocterFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          return SingleChildScrollView(
            child: Column(children: [FormAddDocter(method: "PUT")]),
          );
        },
      ),
    );
  }
}
