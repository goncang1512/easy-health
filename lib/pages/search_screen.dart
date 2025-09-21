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
      body: Column(children: [InputSearchField()]),
    );
  }
}
