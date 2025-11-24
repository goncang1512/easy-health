import 'package:easyhealth/utils/theme.dart';
import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  final String name;
  final String status;
  final String time;
  final String date;
  final VoidCallback onCancel;
  final VoidCallback onFinish;

  const AppointmentCard({
    super.key,
    required this.name,
    required this.status,
    required this.time,
    required this.date,
    required this.onCancel,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// NAME + STATUS BADGE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              /// Status badge "Upcoming"
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: status == "confirm"
                      ? ThemeColors.secondary
                      : status == "finish"
                      ? Colors.blue.withValues(alpha: 0.1)
                      : ThemeColors.red100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    color: status == "confirm"
                        ? ThemeColors.primary
                        : status == "finish"
                        ? Colors.blue
                        : ThemeColors.red600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// TIME & DATE
          Row(
            children: [
              Icon(Icons.access_time, size: 18, color: const Color(0xFF10B981)),
              const SizedBox(width: 6),
              Text(time, style: const TextStyle(fontSize: 14)),
              const SizedBox(width: 16),
              Icon(Icons.event, size: 18, color: const Color(0xFF10B981)),
              const SizedBox(width: 6),
              Text(date, style: const TextStyle(fontSize: 14)),
            ],
          ),

          const SizedBox(height: 14),

          /// CANCEL BUTTON
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              status == "canceled"
                  ? SizedBox(
                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green.withValues(alpha: 0.1),
                          foregroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: onCancel,
                        icon: const Icon(Icons.check_circle_outline, size: 18),
                        label: const Text("Confirm"),
                      ),
                    )
                  : SizedBox(
                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red.withValues(alpha: 0.1),
                          foregroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: onCancel,
                        icon: const Icon(Icons.close, size: 18),
                        label: const Text("Cancel"),
                      ),
                    ),

              const SizedBox(width: 10),

              SizedBox(
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue.withValues(alpha: 0.1),
                    foregroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: onFinish,
                  icon: const Icon(Icons.check, size: 18),
                  label: const Text("Finish"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
