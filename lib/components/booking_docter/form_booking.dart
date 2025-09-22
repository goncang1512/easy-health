import 'package:easyhealth/components/input_field.dart';
import 'package:easyhealth/provider/booking_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormBooking extends StatefulWidget {
  const FormBooking({super.key});

  @override
  State<FormBooking> createState() => _FormBookingComponent();
}

class _FormBookingComponent extends State<FormBooking> {
  @override
  Widget build(BuildContext context) {
    final booking = Provider.of<BookingProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        children: [
          CustomInputField(
            label: "Nama Lengkap",
            hint: "Masukkan nama lengkap",
            controller: booking.nameController,
          ),
          CustomInputField(
            label: "Nomor HP",
            hint: "08xxxxxxxx",
            controller: booking.numberController,
          ),
          CustomInputField(
            label: "Tanggal Konsultasi",
            hint: "Pilih tanggal",
            controller: booking.dateController,
            readOnly: true,
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (date != null) {
                booking.dateController.text =
                    "${date.day}/${date.month}/${date.year}";
              }
            },
          ),
          CustomInputField(
            label: "Jam Konsultasi",
            hint: "Pilih jam",
            controller: booking.timeController,
            readOnly: true,
            onTap: () async {
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (time != null) {
                // ignore: use_build_context_synchronously
                booking.timeController.text = time.format(context);
              }
            },
          ),
          CustomInputField(
            label: "Catatan Tambahan",
            hint: "Jelaskan keluhan atau tambahan khusus...",
            controller: booking.descController,
            maxLines: 5, // jadi text area
          ),
        ],
      ),
    );
  }
}
