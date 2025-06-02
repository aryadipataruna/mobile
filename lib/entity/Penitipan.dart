// lib/models/penitipan_barang.dart

import 'dart:convert';

class PenitipanBarang {
  final String noNota;
  final String? idPenitip;
  final String? namaPenitip;
  final String? alamatPenitip;
  final String? deliveryKurir;
  final String? qcOleh;
  final DateTime? tanggalPenitipan;
  final DateTime? masaPenitipanSampai;

  PenitipanBarang({
    required this.noNota,
    this.idPenitip,
    this.namaPenitip,
    this.alamatPenitip,
    this.deliveryKurir,
    this.qcOleh,
    this.tanggalPenitipan,
    this.masaPenitipanSampai,
  });

  factory PenitipanBarang.fromJson(Map<String, dynamic> json) {
    return PenitipanBarang(
      noNota: json['no_nota'] as String,
      idPenitip: json['id_penitip'] as String?,
      namaPenitip: json['nama_penitip'] as String?,
      alamatPenitip: json['alamat_penitip'] as String?,
      deliveryKurir: json['delivery_kurir'] as String?,
      qcOleh: json['qc_oleh'] as String?,
      tanggalPenitipan: json['tanggal_penitipan'] != null
          ? DateTime.tryParse(json['tanggal_penitipan'] as String)
          : null,
      masaPenitipanSampai: json['masa_penitipan_sampai'] != null
          ? DateTime.tryParse(json['masa_penitipan_sampai'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'no_nota': noNota,
      'id_penitip': idPenitip,
      'nama_penitip': namaPenitip,
      'alamat_penitip': alamatPenitip,
      'delivery_kurir': deliveryKurir,
      'qc_oleh': qcOleh,
      'tanggal_penitipan': tanggalPenitipan?.toIso8601String(),
      'masa_penitipan_sampai': masaPenitipanSampai?.toIso8601String(),
    };
  }

  PenitipanBarang copyWith({
    String? noNota,
    String? idPenitip,
    String? namaPenitip,
    String? alamatPenitip,
    String? deliveryKurir,
    String? qcOleh,
    DateTime? tanggalPenitipan,
    DateTime? masaPenitipanSampai,
  }) {
    return PenitipanBarang(
      noNota: noNota ?? this.noNota,
      idPenitip: idPenitip ?? this.idPenitip,
      namaPenitip: namaPenitip ?? this.namaPenitip,
      alamatPenitip: alamatPenitip ?? this.alamatPenitip,
      deliveryKurir: deliveryKurir ?? this.deliveryKurir,
      qcOleh: qcOleh ?? this.qcOleh,
      tanggalPenitipan: tanggalPenitipan ?? this.tanggalPenitipan,
      masaPenitipanSampai: masaPenitipanSampai ?? this.masaPenitipanSampai,
    );
  }
}
