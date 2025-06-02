// lib/models/pembeli.dart

import 'dart:convert';

class Pembeli {
  final String idPembeli;
  final String namaPembeli;
  final String? emailPembeli;
  final String? noPembeli;
  final String? alamatPembeli;
  final double? poinPembeli;
  // Password tidak disertakan karena ini adalah model, bukan untuk otentikasi langsung

  Pembeli({
    required this.idPembeli,
    required this.namaPembeli,
    this.emailPembeli,
    this.noPembeli,
    this.alamatPembeli,
    this.poinPembeli,
  });

  factory Pembeli.fromJson(Map<String, dynamic> json) {
    return Pembeli(
      idPembeli: json['ID_PEMBELI'] as String,
      namaPembeli: json['NAMA_PEMBELI'] as String,
      emailPembeli: json['EMAIL_PEMBELI'] as String?,
      noPembeli: json['NO_PEMBELI'] as String?,
      alamatPembeli: json['ALAMAT_PEMBELI'] as String?,
      poinPembeli: (json['POIN_PEMBELI'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID_PEMBELI': idPembeli,
      'NAMA_PEMBELI': namaPembeli,
      'EMAIL_PEMBELI': emailPembeli,
      'NO_PEMBELI': noPembeli,
      'ALAMAT_PEMBELI': alamatPembeli,
      'POIN_PEMBELI': poinPembeli,
    };
  }

  Pembeli copyWith({
    String? idPembeli,
    String? namaPembeli,
    String? emailPembeli,
    String? noPembeli,
    String? alamatPembeli,
    double? poinPembeli,
  }) {
    return Pembeli(
      idPembeli: idPembeli ?? this.idPembeli,
      namaPembeli: namaPembeli ?? this.namaPembeli,
      emailPembeli: emailPembeli ?? this.emailPembeli,
      noPembeli: noPembeli ?? this.noPembeli,
      alamatPembeli: alamatPembeli ?? this.alamatPembeli,
      poinPembeli: poinPembeli ?? this.poinPembeli,
    );
  }
}
