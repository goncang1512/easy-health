class StatsDashboardModel {
  final int bookingHariIni;
  final int dokterAktif;
  final int selesai;
  final int dibatalkan;
  final List<BookRange> bookRange;

  StatsDashboardModel({
    required this.bookingHariIni,
    required this.dokterAktif,
    required this.selesai,
    required this.dibatalkan,
    required this.bookRange,
  });

  factory StatsDashboardModel.fromJson(Map<String, dynamic> json) {
    return StatsDashboardModel(
      bookingHariIni: json['bookingHariIni'] ?? 0,
      dokterAktif: json['dokterAktif'] ?? 0,
      selesai: json['selesai'] ?? 0,
      dibatalkan: json['dibatalkan'] ?? 0,
      bookRange:
          (json['bookRange'] as List<dynamic>?)
              ?.map((e) => BookRange.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookingHariIni': bookingHariIni,
      'dokterAktif': dokterAktif,
      'selesai': selesai,
      'dibatalkan': dibatalkan,
      'bookRange': bookRange.map((e) => e.toJson()).toList(),
    };
  }
}

class BookRange {
  final String id;
  final String name;
  final String bookDate;
  final String bookTime;
  final String status;
  final DocterStats docter;

  BookRange({
    required this.id,
    required this.name,
    required this.bookDate,
    required this.bookTime,
    required this.status,
    required this.docter,
  });

  factory BookRange.fromJson(Map<String, dynamic> json) {
    return BookRange(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      bookDate: json['bookDate'] ?? '',
      bookTime: json['bookTime'] ?? '',
      status: json['status'] ?? '',
      docter: DocterStats.fromJson(json['docter'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'bookDate': bookDate,
      'bookTime': bookTime,
      'status': status,
      'docter': docter.toJson(),
    };
  }
}

class DocterStats {
  final String name;

  DocterStats({required this.name});

  factory DocterStats.fromJson(Map<String, dynamic> json) {
    return DocterStats(name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}
