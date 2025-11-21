import 'package:easyhealth/provider/docter_provider.dart';
import 'package:easyhealth/provider/session_provider.dart';
import 'package:easyhealth/utils/alert.dart';
import 'package:easyhealth/widgets/add_docter/docter_schedule.dart';
import 'package:easyhealth/widgets/input_field.dart';
import 'package:easyhealth/widgets/register_hospital/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FormAddDocter extends StatefulWidget {
  final String method;
  const FormAddDocter({super.key, required this.method});

  @override
  State<FormAddDocter> createState() => _FormAddDocter();
}

class _FormAddDocter extends State<FormAddDocter> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DocterProvider>();
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        children: [
          CustomInputField(
            controller: provider.name,
            label: "Name",
            hint: "Nama lengkap dokter",
          ),
          const SizedBox(height: 10),
          CustomInputField(
            controller: provider.spesialis,
            label: "Spesialis",
            hint: "Contoh: kardiologi, Pediatri",
          ),
          const SizedBox(height: 10),
          CustomInputField(
            controller: provider.hospitalName,
            label: "Nama Rumah sakit",
            hint: "Contoh: RS USU",
          ),
          const SizedBox(height: 10),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Photo dokter",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              ImageUploadPreview(
                height: 400,
                setImage: (value) {
                  provider.setImage(value);
                },
                imageUrl: provider.imageUrl,
                placeholder: "Upload photo dokter",
              ),
            ],
          ),

          const SizedBox(height: 10),
          DocterSchedule(),
          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity, // biar full lebar
            child: ElevatedButton(
              onPressed: provider.isLoading
                  ? null
                  : () async {
                      Map<String, Object> res;

                      if (widget.method == "CREATE") {
                        res = await provider.regisDokter();
                      } else {
                        res = await provider.updateDocter();
                      }

                      if (res['status'] == false) {
                        Alert.showBanner("${res["message"]}", context);
                        return;
                      }

                      final sessionProv = context.read<SessionManager>();
                      await sessionProv.loadSession();
                      context.go("/booking");
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF10B981),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                ), // cukup vertical saja
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (provider.isLoading) ...[
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    widget.method == "CREATE" ? "Daftar" : "Edit",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
