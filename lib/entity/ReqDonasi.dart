// lib/models/req_donasi.dart

import 'dart:convert';

class ReqDonasi {
  final String idReqDonasi;
  final String? idOrganisasi;
  final String namaBarangReqDonasi;
  final DateTime? tglReq;

  ReqDonasi({
    required this.idReqDonasi,
    this.idOrganisasi,
    required this.namaBarangReqDonasi,
    this.tglReq,
  });

  factory ReqDonasi.fromJson(Map<String, dynamic> json) {
    return ReqDonasi(
      idReqDonasi: json['ID_REQDONASI'] as String,
      idOrganisasi: json['ID_ORGANISASI'] as String?,
      namaBarangReqDonasi: json['NAMA_BARANG_REQDONASI'] as String,
      tglReq: json['TGL_REQ'] != null
          ? DateTime.tryParse(json['TGL_REQ'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID_REQDONASI': idReqDonasi,
      'ID_ORGANISASI': idOrganisasi,
      'NAMA_BARANG_REQDONASI': namaBarangReqDonasi,
      'TGL_REQ': tglReq?.toIso8601String().split('T')[0], // Format YYYY-MM-DD
    };
  }

  ReqDonasi copyWith({
    String? idReqDonasi,
    String? idOrganisasi,
    String? namaBarangReqDonasi,
    DateTime? tglReq,
  }) {
    return ReqDonasi(
      idReqDonasi: idReqDonasi ?? this.idReqDonasi,
      idOrganisasi: idOrganisasi ?? this.idOrganisasi,
      namaBarangReqDonasi: namaBarangReqDonasi ?? this.namaBarangReqDonasi,
      tglReq: tglReq ?? this.tglReq,
    );
  }
}
