// lib/models/diskusi.dart

import 'dart:convert';

class Diskusi {
  final String idDiskusi;
  final String? idPembeli;
  final String? idPenitip;
  final String? idBarang;

  Diskusi({
    required this.idDiskusi,
    this.idPembeli,
    this.idPenitip,
    this.idBarang,
  });

  factory Diskusi.fromJson(Map<String, dynamic> json) {
    return Diskusi(
      idDiskusi: json['ID_DISKUSI'] as String,
      idPembeli: json['ID_PEMBELI'] as String?,
      idPenitip: json['ID_PENITIP'] as String?,
      idBarang: json['ID_BARANG'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID_DISKUSI': idDiskusi,
      'ID_PEMBELI': idPembeli,
      'ID_PENITIP': idPenitip,
      'ID_BARANG': idBarang,
    };
  }

  Diskusi copyWith({
    String? idDiskusi,
    String? idPembeli,
    String? idPenitip,
    String? idBarang,
  }) {
    return Diskusi(
      idDiskusi: idDiskusi ?? this.idDiskusi,
      idPembeli: idPembeli ?? this.idPembeli,
      idPenitip: idPenitip ?? this.idPenitip,
      idBarang: idBarang ?? this.idBarang,
    );
  }
}
