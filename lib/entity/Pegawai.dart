// lib/models/pegawai.dart

import 'dart:convert';

class Pegawai {
  final String idPegawai;
  final String? idJabatan;
  final String namaPegawai;
  final String? tglLahirPegawai; // Asumsi tetap String karena di Laravel varchar
  final String? notelpPegawai;
  final String? emailPegawai;
  final String? alamatPegawai;
  // Password tidak disertakan karena ini adalah model, bukan untuk otentikasi langsung

  Pegawai({
    required this.idPegawai,
    this.idJabatan,
    required this.namaPegawai,
    this.tglLahirPegawai,
    this.notelpPegawai,
    this.emailPegawai,
    this.alamatPegawai,
  });

  factory Pegawai.fromJson(Map<String, dynamic> json) {
    return Pegawai(
      idPegawai: json['ID_PEGAWAI'] as String,
      idJabatan: json['ID_JABATAN'] as String?,
      namaPegawai: json['NAMA_PEGAWAI'] as String,
      tglLahirPegawai: json['TGL_LAHIR_PEGAWAI'] as String?,
      notelpPegawai: json['NOTELP_PEGAWAI'] as String?,
      emailPegawai: json['EMAIL_PEGAWAI'] as String?,
      alamatPegawai: json['ALAMAT_PEGAWAI'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID_PEGAWAI': idPegawai,
      'ID_JABATAN': idJabatan,
      'NAMA_PEGAWAI': namaPegawai,
      'TGL_LAHIR_PEGAWAI': tglLahirPegawai,
      'NOTELP_PEGAWAI': notelpPegawai,
      'EMAIL_PEGAWAI': emailPegawai,
      'ALAMAT_PEGAWAI': alamatPegawai,
    };
  }

  Pegawai copyWith({
    String? idPegawai,
    String? idJabatan,
    String? namaPegawai,
    String? tglLahirPegawai,
    String? notelpPegawai,
    String? emailPegawai,
    String? alamatPegawai,
  }) {
    return Pegawai(
      idPegawai: idPegawai ?? this.idPegawai,
      idJabatan: idJabatan ?? this.idJabatan,
      namaPegawai: namaPegawai ?? this.namaPegawai,
      tglLahirPegawai: tglLahirPegawai ?? this.tglLahirPegawai,
      notelpPegawai: notelpPegawai ?? this.notelpPegawai,
      emailPegawai: emailPegawai ?? this.emailPegawai,
      alamatPegawai: alamatPegawai ?? this.alamatPegawai,
    );
  }
}
