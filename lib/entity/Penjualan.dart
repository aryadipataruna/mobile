// lib/models/penjualan.dart

import 'dart:convert';

class Penjualan {
  final String idPenjualan;
  final String? idPembeli;
  final String? idBarang;
  final String? idKomisi;
  final String? idPegawai;
  final DateTime? tglPesan;
  final DateTime? tglKirim;
  final DateTime? tglAmbil;
  final String status;
  final String? jenisPengantaran;
  final DateTime? tglPembayaran;
  final double? totalOngkir;
  final double? hargaSetelahOngkir;
  final double? potonganHarga;
  final double? totalHarga;

  Penjualan({
    required this.idPenjualan,
    this.idPembeli,
    this.idBarang,
    this.idKomisi,
    this.idPegawai,
    this.tglPesan,
    this.tglKirim,
    this.tglAmbil,
    required this.status,
    this.jenisPengantaran,
    this.tglPembayaran,
    this.totalOngkir,
    this.hargaSetelahOngkir,
    this.potonganHarga,
    this.totalHarga,
  });

  factory Penjualan.fromJson(Map<String, dynamic> json) {
    return Penjualan(
      idPenjualan: json['id_penjualan'] as String,
      idPembeli: json['id_pembeli'] as String?,
      idBarang: json['id_barang'] as String?,
      idKomisi: json['id_komisi'] as String?,
      idPegawai: json['id_pegawai'] as String?,
      tglPesan: json['tgl_pesan'] != null
          ? DateTime.tryParse(json['tgl_pesan'] as String)
          : null,
      tglKirim: json['tgl_kirim'] != null
          ? DateTime.tryParse(json['tgl_kirim'] as String)
          : null,
      tglAmbil: json['tgl_ambil'] != null
          ? DateTime.tryParse(json['tgl_ambil'] as String)
          : null,
      status: json['status'] as String,
      jenisPengantaran: json['jenis_pengantaran'] as String?,
      tglPembayaran: json['tgl_pembayaran'] != null
          ? DateTime.tryParse(json['tgl_pembayaran'] as String)
          : null,
      totalOngkir: (json['total_ongkir'] as num?)?.toDouble(),
      hargaSetelahOngkir: (json['harga_setelah_ongkir'] as num?)?.toDouble(),
      potonganHarga: (json['potongan_harga'] as num?)?.toDouble(),
      totalHarga: (json['total_harga'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_penjualan': idPenjualan,
      'id_pembeli': idPembeli,
      'id_barang': idBarang,
      'id_komisi': idKomisi,
      'id_pegawai': idPegawai,
      'tgl_pesan': tglPesan?.toIso8601String().split('T')[0], // Format YYYY-MM-DD
      'tgl_kirim': tglKirim?.toIso8601String().split('T')[0], // Format YYYY-MM-DD
      'tgl_ambil': tglAmbil?.toIso8601String().split('T')[0], // Format YYYY-MM-DD
      'status': status,
      'jenis_pengantaran': jenisPengantaran,
      'tgl_pembayaran': tglPembayaran?.toIso8601String().split('T')[0], // Format YYYY-MM-DD
      'total_ongkir': totalOngkir,
      'harga_setelah_ongkir': hargaSetelahOngkir,
      'potongan_harga': potonganHarga,
      'total_harga': totalHarga,
    };
  }

  Penjualan copyWith({
    String? idPenjualan,
    String? idPembeli,
    String? idBarang,
    String? idKomisi,
    String? idPegawai,
    DateTime? tglPesan,
    DateTime? tglKirim,
    DateTime? tglAmbil,
    String? status,
    String? jenisPengantaran,
    DateTime? tglPembayaran,
    double? totalOngkir,
    double? hargaSetelahOngkir,
    double? potonganHarga,
    double? totalHarga,
  }) {
    return Penjualan(
      idPenjualan: idPenjualan ?? this.idPenjualan,
      idPembeli: idPembeli ?? this.idPembeli,
      idBarang: idBarang ?? this.idBarang,
      idKomisi: idKomisi ?? this.idKomisi,
      idPegawai: idPegawai ?? this.idPegawai,
      tglPesan: tglPesan ?? this.tglPesan,
      tglKirim: tglKirim ?? this.tglKirim,
      tglAmbil: tglAmbil ?? this.tglAmbil,
      status: status ?? this.status,
      jenisPengantaran: jenisPengantaran ?? this.jenisPengantaran,
      tglPembayaran: tglPembayaran ?? this.tglPembayaran,
      totalOngkir: totalOngkir ?? this.totalOngkir,
      hargaSetelahOngkir: hargaSetelahOngkir ?? this.hargaSetelahOngkir,
      potonganHarga: potonganHarga ?? this.potonganHarga,
      totalHarga: totalHarga ?? this.totalHarga,
    );
  }
}
