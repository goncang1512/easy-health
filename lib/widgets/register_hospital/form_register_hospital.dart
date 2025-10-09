import 'package:easyhealth/provider/hospital_provider.dart';
import 'package:easyhealth/provider/session_provider.dart';
import 'package:easyhealth/widgets/input_field.dart';
import 'package:easyhealth/widgets/register_hospital/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormRegisterHospital extends StatefulWidget {
  final String method;
  final String? hospitalId;
  const FormRegisterHospital({
    super.key,
    required this.method,
    this.hospitalId,
  });

  @override
  State<FormRegisterHospital> createState() => _FormRegisterHospital();
}

class _FormRegisterHospital extends State<FormRegisterHospital> {
  @override
  Widget build(BuildContext context) {
    final regis = context.watch<HospitalProvider>();

    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        children: [
          Image.asset("assets/images/hospital.png"),

          const SizedBox(height: 10),
          CustomInputField(
            controller: regis.nameHospital,
            filled: true,
            fillColor: Colors.white,
            label: "Nama",
            hint: "Masukkan nama lengkap rumah sakit",
          ),
          const SizedBox(height: 10),
          CustomInputField(
            controller: regis.numberHospital,
            filled: true,
            fillColor: Colors.white,
            label: "Nomor HP",
            hint: "08xxxxxxxxxxx",
          ),
          const SizedBox(height: 10),
          CustomInputField(
            controller: regis.emailHospital,
            filled: true,
            fillColor: Colors.white,
            label: "Email",
            hint: "example@gmail.com",
          ),
          const SizedBox(height: 10),
          CustomInputField(
            controller: regis.addressHospital,
            filled: true,
            fillColor: Colors.white,
            label: "Alamat",
            hint: "Jlxxxxx",
          ),
          const SizedBox(height: 10),
          CustomInputField(
            controller: regis.roomHospital,
            filled: true,
            fillColor: Colors.white,
            label: "Ruangan",
            hint: "100",
          ),

          const SizedBox(height: 10),

          ImageUploadPreview(
            placeholder: "Klik untuk upload",
            setImage: (value) {
              regis.setImage(value);
            },
            imageUrl: regis.imageUrl,
          ),

          const SizedBox(height: 10),

          SizedBox(
            width: double.infinity, // biar full lebar
            child: ElevatedButton(
              onPressed: regis.isLoading
                  ? null
                  : () async {
                      if (widget.method == "CREATE") {
                        bool res = await regis.registerHospital();
                        if (res) {
                          await context.read<SessionManager>().loadSession();
                        }
                      } else {
                        bool res = await regis.updateHospital(
                          widget.hospitalId.toString(),
                        );

                        if (res) {
                          await context.read<SessionManager>().loadSession();
                        }
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
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
                  if (regis.isLoading) ...[
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
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
