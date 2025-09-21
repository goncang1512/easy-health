import 'package:easyhealth/components/hospital_card.dart';
import 'package:easyhealth/components/search_screen/bar_search.dart';
import 'package:easyhealth/components/search_screen/search_field.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final String? keyword;
  const SearchScreen({super.key, this.keyword});

  @override
  State<SearchScreen> createState() => _SearchPage();
}

class _SearchPage extends State<SearchScreen> {
  String? keyword;

  @override
  void initState() {
    super.initState();
    keyword = widget.keyword; // isi setelah state dibuat
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSearch(
        title: (keyword != null && keyword!.isNotEmpty)
            ? "Hasil Pencarian"
            : "Pencarian",
      ),
      body: Column(
        children: [
          InputSearchField(keyword: keyword),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 5),
            child: Column(
              children: [
                HospitalCard(
                  imageUrl:
                      "https://media.istockphoto.com/id/1312706413/photo/modern-hospital-building.jpg?s=612x612&w=0&k=20&c=oUILskmtaPiA711DP53DFhOUvE7pfdNeEK9CfyxlGio=",
                  name: "RS USU",
                  address: "Medan",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
