import 'package:easyhealth/widgets/search_screen/bar_search.dart';
import 'package:easyhealth/widgets/search_screen/docter_list.dart';
import 'package:easyhealth/widgets/search_screen/new_hospital.dart';
import 'package:easyhealth/widgets/search_screen/search_field.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final String? keyword;
  const SearchScreen({super.key, this.keyword});

  @override
  State<SearchScreen> createState() => _SearchPage();
}

class _SearchPage extends State<SearchScreen> {
  @override
  void didUpdateWidget(covariant SearchScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.keyword != widget.keyword) {
      // lakukan fetch baru dengan widget.keyword
      print("Keyword berubah: ${widget.keyword}");
    }
  }

  final List<Hospital> hospitals = List.generate(
    10,
    (i) => Hospital(
      hospitalId: "asd99asdf9s${i + 1}",
      imageUrl:
          'https://i.pinimg.com/1200x/bc/c0/13/bcc013aa69420dc0f628c713a8e27e78.jpg',
      name: 'RS Contoh #${i + 1}',
      address: 'Kota ${i + 1}',
    ),
  );

  final List<Docter> docters = List.generate(
    5,
    (i) => Docter(
      id: "${i + 1}",
      imageUrl:
          'https://i.pinimg.com/736x/c2/db/2d/c2db2da630a1d117a3e1297ed7fd9b96.jpg',
      name: 'RS Contoh #${i + 1}',
      address: 'Kota ${i + 1}',
      hospital: "RS ${i + 1}",
      specialty: "Spesialis ${i + 1}",
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSearch(
        title: (widget.keyword != null && widget.keyword!.isNotEmpty)
            ? "Hasil Pencarian"
            : "Pencarian",
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputSearchField(keyword: widget.keyword),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: ListViewNewHospital(
                hospitals: hospitals,
                title: widget.keyword != null && widget.keyword!.isNotEmpty
                    ? "Rumah Sakit"
                    : "Rumah Sakit Terbaru",
              ),
            ),
            if (widget.keyword != null && widget.keyword!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 12,
                ),
                child: ListViewDoctor(docters: docters, title: "Dokter"),
              ),
          ],
        ),
      ),
    );
  }
}
