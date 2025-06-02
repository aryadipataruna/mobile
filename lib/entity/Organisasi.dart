// lib/models/organisasi.dart

import 'dart:convert';

class Organisasi {
  final String idOrganisasi;
  final String namaOrganisasi;
  final String? notelpOrganisasi;
  final String? alamatOrganisasi;
  final String? emailOrganisasi;
  // Password tidak disertakan karena ini adalah model, bukan untuk otentikasi langsung

  Organisasi({
    required this.idOrganisasi,
    required this.namaOrganisasi,
    this.notelpOrganisasi,
    this.alamatOrganisasi,
    this.emailOrganisasi,
  });

  factory Organisasi.fromJson(Map<String, dynamic> json) {
    return Organisasi(
      idOrganisasi: json['ID_ORGANISASI'] as String,
      namaOrganisasi: json['NAMA_ORGANISASI'] as String,
      notelpOrganisasi: json['NOTELP_ORGANISASI'] as String?,
      alamatOrganisasi: json['ALAMAT_ORGANISASI'] as String?,
      emailOrganisasi: json['EMAIL_ORGANISASI'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID_ORGANISASI': idOrganisasi,
      'NAMA_ORGANISASI': namaOrganisasi,
      'NOTELP_ORGANISASI': notelpOrganisasi,
      'ALAMAT_ORGANISASI': alamatOrganisasi,
      'EMAIL_ORGANISASI': emailOrganisasi,
    };
  }

  Organisasi copyWith({
    String? idOrganisasi,
    String? namaOrganisasi,
    String? notelpOrganisasi,
    String? alamatOrganisasi,
    String? emailOrganisasi,
  }) {
    return Organisasi(
      idOrganisasi: idOrganisasi ?? this.idOrganisasi,
      namaOrganisasi: namaOrganisasi ?? this.namaOrganisasi,
      notelpOrganisasi: notelpOrganisasi ?? this.notelpOrganisasi,
      alamatOrganisasi: alamatOrganisasi ?? this.alamatOrganisasi,
      emailOrganisasi: emailOrganisasi ?? this.emailOrganisasi,
    );
  }
}
