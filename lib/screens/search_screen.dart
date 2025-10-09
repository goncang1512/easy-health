import 'package:easyhealth/models/docter_model.dart';
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
  late Future<Map<String, dynamic>> _futureHospital;

  @override
  void initState() {
    super.initState();
    _futureHospital = getHospital(widget.keyword);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (searchController.value == 'clear') {
        searchController.value = ''; // reset agar tidak trigger ulang
      }
    });
  }

  Future<void> _refreshData() async {
    // panggil ulang future dan setState agar FutureBuilder ter-*rebuild*
    setState(() {
      _futureHospital = getHospital(widget.keyword);
    });
  }

  Future<Map<String, dynamic>> getHospital(String? keyword) async {
    final String path = keyword != null
        ? "/api/hospital?keyword=$keyword"
        : "/api/hospital";

    final result = await HTTP.get(path);

    final data = result["result"];

    final List<HospitalModel> hospitals = (data["results"] as List<dynamic>)
        .map((item) => HospitalModel.fromJson(item as Map<String, dynamic>))
        .toList();

    final List<DocterModel> docters = (data["docters"] as List<dynamic>)
        .map((item) => DocterModel.fromJson(item as Map<String, dynamic>))
        .toList();

    return {"hospitals": hospitals, "docters": docters};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSearch(
        title: (widget.keyword != null && widget.keyword!.isNotEmpty)
            ? "Hasil Pencarian"
            : "Pencarian",
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder<Map<String, dynamic>>(
          future: _futureHospital,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("Tidak ada data"));
            }

            final hospitals =
                snapshot.data!["hospitals"] as List<HospitalModel>;
            final docters = snapshot.data!["docters"] as List<DocterModel>;

            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              // padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              children: [
                InputSearchField(keyword: widget.keyword),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  child: Column(
                    children: [
                      if (hospitals.isNotEmpty)
                        ListViewNewHospital(
                          hospitals: hospitals,
                          title:
                              widget.keyword != null &&
                                  widget.keyword!.isNotEmpty
                              ? "Rumah Sakit"
                              : "Rumah Sakit Terbaru",
                        ),

                      if (widget.keyword != null &&
                          widget.keyword!.trim().isNotEmpty &&
                          docters.isNotEmpty)
                        ListViewDoctor(docters: docters, title: "Dokter"),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
