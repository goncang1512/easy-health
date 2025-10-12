import 'package:easyhealth/models/stats_model.dart';
import 'package:flutter/material.dart';

class DashbaordStats extends StatefulWidget {
  final StatsDashboardModel? stats;
  const DashbaordStats({super.key, this.stats});

  @override
  State<DashbaordStats> createState() => _DashboardStats();
}

class _DashboardStats extends State<DashbaordStats> {
  List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();

    items = [
      {
        'icon': Icons.calendar_today,
        'title': 'Booking Hari Ini',
        'value': widget.stats?.bookingHariIni.toString(),
        'color': Colors.green,
      },
      {
        'icon': Icons.medical_information_outlined,
        'title': 'Dokter Aktif',
        'value': widget.stats?.dokterAktif.toString(),
        'color': Colors.blue,
      },
      {
        'icon': Icons.check_circle_outline,
        'title': 'Selesai',
        'value': widget.stats?.selesai.toString(),
        'color': Colors.green,
      },
      {
        'icon': Icons.cancel_outlined,
        'title': 'Dibatalkan',
        'value': widget.stats?.dibatalkan.toString(),
        'color': Colors.red,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // dua kolom
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.8,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: item['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(item['icon'], color: item['color'], size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item['value'],
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['title'],
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
