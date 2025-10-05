import 'package:easyhealth/models/hospital_model.dart';
import 'package:easyhealth/utils/fetch.dart';
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
  List<HospitalModel> hospitals = [];

  @override
  void initState() {
    super.initState();
  }

  Future<List<HospitalModel>> getHospital(String? keyword) async {
    final String path = keyword != null
        ? "/api/hospital?keyword=$keyword"
        : "/api/hospital";

    final data = await HTTP.get(path);

    return (data["result"] as List<dynamic>)
        .map((item) => HospitalModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

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
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputSearchField(keyword: widget.keyword),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
                child: FutureBuilder(
                  future: getHospital(widget.keyword),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text("Tidak ada data"));
                    }

                    final hospitals =
                        snapshot.data!; // ✅ hasil dari return _fetchData
                    return ListViewNewHospital(
                      hospitals: hospitals,
                      title:
                          widget.keyword != null && widget.keyword!.isNotEmpty
                          ? "Rumah Sakit"
                          : "Rumah Sakit Terbaru",
                    );
                  },
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
      ),
    );
  }
}
