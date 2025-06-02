// lib/models/merchandise.dart

import 'dart:convert';

class Merchandise {
  final String idMerchandise;
  final String namaMerchandise;
  final String? idPenukaran;

  Merchandise({
    required this.idMerchandise,
    required this.namaMerchandise,
    this.idPenukaran,
  });

  factory Merchandise.fromJson(Map<String, dynamic> json) {
    return Merchandise(
      idMerchandise: json['ID_MERCHANDISE'] as String,
      namaMerchandise: json['NAMA_MERCHANDISE'] as String,
      idPenukaran: json['ID_PENUKARAN'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID_MERCHANDISE': idMerchandise,
      'NAMA_MERCHANDISE': namaMerchandise,
      'ID_PENUKARAN': idPenukaran,
    };
  }

  Merchandise copyWith({
    String? idMerchandise,
    String? namaMerchandise,
    String? idPenukaran,
  }) {
    return Merchandise(
      idMerchandise: idMerchandise ?? this.idMerchandise,
      namaMerchandise: namaMerchandise ?? this.namaMerchandise,
      idPenukaran: idPenukaran ?? this.idPenukaran,
    );
  }
}
