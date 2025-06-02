// lib/models/komisi.dart

import 'dart:convert';

class Komisi {
  final String idKomisi;
  final String? idPenjualan;
  final String? idPegawai;
  final double komisiPerusahaan;
  final double komisiHunter;
  final double bonus;

  Komisi({
    required this.idKomisi,
    this.idPenjualan,
    this.idPegawai,
    required this.komisiPerusahaan,
    required this.komisiHunter,
    required this.bonus,
  });

  factory Komisi.fromJson(Map<String, dynamic> json) {
    return Komisi(
      idKomisi: json['id_komisi'] as String,
      idPenjualan: json['id_penjualan'] as String?,
      idPegawai: json['id_pegawai'] as String?,
      komisiPerusahaan: (json['komisi_perusahaan'] as num).toDouble(),
      komisiHunter: (json['komisi_hunter'] as num).toDouble(),
      bonus: (json['bonus'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_komisi': idKomisi,
      'id_penjualan': idPenjualan,
      'id_pegawai': idPegawai,
      'komisi_perusahaan': komisiPerusahaan,
      'komisi_hunter': komisiHunter,
      'bonus': bonus,
    };
  }

  Komisi copyWith({
    String? idKomisi,
    String? idPenjualan,
    String? idPegawai,
    double? komisiPerusahaan,
    double? komisiHunter,
    double? bonus,
  }) {
    return Komisi(
      idKomisi: idKomisi ?? this.idKomisi,
      idPenjualan: idPenjualan ?? this.idPenjualan,
      idPegawai: idPegawai ?? this.idPegawai,
      komisiPerusahaan: komisiPerusahaan ?? this.komisiPerusahaan,
      komisiHunter: komisiHunter ?? this.komisiHunter,
      bonus: bonus ?? this.bonus,
    );
  }
}
