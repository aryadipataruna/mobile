// lib/models/penitip.dart

import 'dart:convert';

class Penitip {
  final String idPenitip;
  final String namaPenitip;
  final String? alamatPenitip;
  final String? emailPenitip;
  final double? saldoPenitip;
  final double? poinPenitip;
  // Password tidak disertakan karena ini adalah model, bukan untuk otentikasi langsung

  Penitip({
    required this.idPenitip,
    required this.namaPenitip,
    this.alamatPenitip,
    this.emailPenitip,
    this.saldoPenitip,
    this.poinPenitip,
  });

  factory Penitip.fromJson(Map<String, dynamic> json) {
    return Penitip(
      idPenitip: json['ID_PENITIP'] as String,
      namaPenitip: json['NAMA_PENITIP'] as String,
      alamatPenitip: json['ALAMAT_PENITIP'] as String?,
      emailPenitip: json['EMAIL_PENITIP'] as String?,
      saldoPenitip: (json['SALDO_PENITIP'] as num?)?.toDouble(),
      poinPenitip: (json['POIN_PENITIP'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID_PENITIP': idPenitip,
      'NAMA_PENITIP': namaPenitip,
      'ALAMAT_PENITIP': alamatPenitip,
      'EMAIL_PENITIP': emailPenitip,
      'SALDO_PENITIP': saldoPenitip,
      'POIN_PENITIP': poinPenitip,
    };
  }

  Penitip copyWith({
    String? idPenitip,
    String? namaPenitip,
    String? alamatPenitip,
    String? emailPenitip,
    double? saldoPenitip,
    double? poinPenitip,
  }) {
    return Penitip(
      idPenitip: idPenitip ?? this.idPenitip,
      namaPenitip: namaPenitip ?? this.namaPenitip,
      alamatPenitip: alamatPenitip ?? this.alamatPenitip,
      emailPenitip: emailPenitip ?? this.emailPenitip,
      saldoPenitip: saldoPenitip ?? this.saldoPenitip,
      poinPenitip: poinPenitip ?? this.poinPenitip,
    );
  }
}
