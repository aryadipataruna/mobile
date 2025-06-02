// lib/models/penukaran.dart

import 'dart:convert';

class Penukaran {
  final String idPenukaran;
  final String? idPembeli;
  final String namaPenukar;
  final DateTime? tanggalTukar;

  Penukaran({
    required this.idPenukaran,
    this.idPembeli,
    required this.namaPenukar,
    this.tanggalTukar,
  });

  factory Penukaran.fromJson(Map<String, dynamic> json) {
    return Penukaran(
      idPenukaran: json['ID_PENUKARAN'] as String,
      idPembeli: json['ID_PEMBELI'] as String?,
      namaPenukar: json['NAMA_PENUKAR'] as String,
      tanggalTukar: json['TANGGAL_TUKAR'] != null
          ? DateTime.tryParse(json['TANGGAL_TUKAR'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID_PENUKARAN': idPenukaran,
      'ID_PEMBELI': idPembeli,
      'NAMA_PENUKAR': namaPenukar,
      'TANGGAL_TUKAR':
          tanggalTukar?.toIso8601String().split('T')[0], // Format YYYY-MM-DD
    };
  }

  Penukaran copyWith({
    String? idPenukaran,
    String? idPembeli,
    String? namaPenukar,
    DateTime? tanggalTukar,
  }) {
    return Penukaran(
      idPenukaran: idPenukaran ?? this.idPenukaran,
      idPembeli: idPembeli ?? this.idPembeli,
      namaPenukar: namaPenukar ?? this.namaPenukar,
      tanggalTukar: tanggalTukar ?? this.tanggalTukar,
    );
  }
}
