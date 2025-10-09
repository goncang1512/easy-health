import 'package:easyhealth/provider/docter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DocterSchedule extends StatefulWidget {
  const DocterSchedule({super.key});

  @override
  State<DocterSchedule> createState() => _DocterScheduleState();
}

class _DocterScheduleState extends State<DocterSchedule> {
  final List<String> hariList = [
    "Senin",
    "Selasa",
    "Rabu",
    "Kamis",
    "Jumat",
    "Sabtu",
    "Minggu",
  ];

  final Map<String, bool> aktifHari = {};
  final Map<String, TextEditingController> jamMulai = {};
  final Map<String, TextEditingController> jamSelesai = {};

  @override
  void initState() {
    super.initState();
    for (var hari in hariList) {
      aktifHari[hari] = false;
      jamMulai[hari] = TextEditingController(text: "09:00");
      jamSelesai[hari] = TextEditingController(
        text: (hari == "Sabtu" || hari == "Minggu") ? "13:00" : "17:00",
      );
    }

    // Delay agar context sudah terpasang
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _applyDefaultFromProvider();
    });
  }

  void _applyDefaultFromProvider() {
    final provider = context.read<DocterProvider>();
    final dbSchedule = provider.schedule;

    if (dbSchedule.isNotEmpty) {
      setState(() {
        for (var hari in hariList) {
          final value = dbSchedule[hari];
          if (value != null && value is Map) {
            aktifHari[hari] = value["active"] ?? false;
            jamMulai[hari]?.text = value["start"] ?? "09:00";
            jamSelesai[hari]?.text = value["due"] ?? "17:00";
          }
        }
      });
    }
  }

  @override
  void dispose() {
    for (var c in jamMulai.values) {
      c.dispose();
    }
    for (var c in jamSelesai.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _selectTime(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final parts = controller.text.split(":");
    final initialTime = TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );

    final timeOfDay = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (timeOfDay != null) {
      controller.text =
          "${timeOfDay.hour.toString().padLeft(2, '0')}:${timeOfDay.minute.toString().padLeft(2, '0')}";

      _updateProviderSchedule();
    }
  }

  void _updateProviderSchedule() {
    final provider = context.read<DocterProvider>();

    for (var hari in hariList) {
      provider.updateSchedule(
        hari,
        aktifHari[hari] ?? false,
        jamMulai[hari]!.text,
        jamSelesai[hari]!.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Jadwal Praktik",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: hariList.length,
          itemBuilder: (context, index) {
            final hari = hariList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    activeColor: Color(0xFF10B981),
                    value: aktifHari[hari],
                    onChanged: (val) {
                      setState(() {
                        aktifHari[hari] = val ?? false;
                      });
                      _updateProviderSchedule();
                    },
                  ),
                  SizedBox(width: 70, child: Text(hari)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Row(
                      children: [
                        // jam mulai
                        Expanded(
                          child: TextField(
                            controller: jamMulai[hari],
                            readOnly: true,
                            onTap: aktifHari[hari]!
                                ? () => _selectTime(context, jamMulai[hari]!)
                                : null,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 8,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text("-"),
                        const SizedBox(width: 8),
                        // jam selesai
                        Expanded(
                          child: TextField(
                            controller: jamSelesai[hari],
                            readOnly: true,
                            onTap: aktifHari[hari]!
                                ? () => _selectTime(context, jamSelesai[hari]!)
                                : null,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 8,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
