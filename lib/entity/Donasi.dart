// lib/models/donasi.dart

import 'dart:convert';

class Donasi {
  final String idDonasi;
  final String? idOrganisasi;
  final String namaBarangDonasi;
  final DateTime tglDonasi;
  final String namaPenerima;

  Donasi({
    required this.idDonasi,
    this.idOrganisasi,
    required this.namaBarangDonasi,
    required this.tglDonasi,
    required this.namaPenerima,
  });

  factory Donasi.fromJson(Map<String, dynamic> json) {
    return Donasi(
      idDonasi: json['ID_DONASI'] as String,
      idOrganisasi: json['ID_ORGANISASI'] as String?,
      namaBarangDonasi: json['NAMA_BARANG_DONASI'] as String,
      tglDonasi: DateTime.parse(json['TGL_DONASI'] as String),
      namaPenerima: json['NAMA_PENERIMA'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID_DONASI': idDonasi,
      'ID_ORGANISASI': idOrganisasi,
      'NAMA_BARANG_DONASI': namaBarangDonasi,
      'TGL_DONASI': tglDonasi.toIso8601String().split('T')[0], // Format YYYY-MM-DD
      'NAMA_PENERIMA': namaPenerima,
    };
  }

  Donasi copyWith({
    String? idDonasi,
    String? idOrganisasi,
    String? namaBarangDonasi,
    DateTime? tglDonasi,
    String? namaPenerima,
  }) {
    return Donasi(
      idDonasi: idDonasi ?? this.idDonasi,
      idOrganisasi: idOrganisasi ?? this.idOrganisasi,
      namaBarangDonasi: namaBarangDonasi ?? this.namaBarangDonasi,
      tglDonasi: tglDonasi ?? this.tglDonasi,
      namaPenerima: namaPenerima ?? this.namaPenerima,
    );
  }
}
