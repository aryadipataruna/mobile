// lib/models/jabatan.dart

import 'dart:convert';

class Jabatan {
  final String idJabatan;
  final String namaJabatan;

  Jabatan({
    required this.idJabatan,
    required this.namaJabatan,
  });

  factory Jabatan.fromJson(Map<String, dynamic> json) {
    return Jabatan(
      idJabatan: json['ID_JABATAN'] as String,
      namaJabatan: json['NAMA_JABATAN'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID_JABATAN': idJabatan,
      'NAMA_JABATAN': namaJabatan,
    };
  }

  Jabatan copyWith({
    String? idJabatan,
    String? namaJabatan,
  }) {
    return Jabatan(
      idJabatan: idJabatan ?? this.idJabatan,
      namaJabatan: namaJabatan ?? this.namaJabatan,
    );
  }
}
