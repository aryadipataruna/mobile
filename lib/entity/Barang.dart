import 'dart:convert';

class Barang {
  final String idBarang;
  final String? idPenitip;
  final String? idDiskusi;
  final String? idPegawai;
  final String namaBarang;
  final String? deskripsiBarang;
  final String kategori;
  final double hargaBarang;
  final DateTime? tglTitip;
  final DateTime? tglLaku;
  final DateTime? tglAkhir;
  final bool garansi;
  final bool perpanjangan;
  final int countPerpanjangan;
  final String status;
  final String? gambarBarang;
  final String? buktiPembayaran;
  final double? rating;

  Barang({
    required this.idBarang,
    this.idPenitip,
    this.idDiskusi,
    this.idPegawai,
    required this.namaBarang,
    this.deskripsiBarang,
    required this.kategori,
    required this.hargaBarang,
    this.tglTitip,
    this.tglLaku,
    this.tglAkhir,
    required this.garansi,
    required this.perpanjangan,
    required this.countPerpanjangan,
    required this.status,
    this.gambarBarang,
    this.buktiPembayaran,
    this.rating,
  });

  factory Barang.fromJson(Map<String, dynamic> json) {
    return Barang(
      idBarang: json['id_barang'] as String,
      idPenitip: json['id_penitip'] as String?,
      idDiskusi: json['id_diskusi'] as String?,
      idPegawai: json['id_pegawai'] as String?,
      namaBarang: json['nama_barang'] as String,
      deskripsiBarang: json['deskripsi_barang'] as String?,
      kategori: json['kategori'] as String,
      hargaBarang: (json['harga_barang'] as num).toDouble(),
      tglTitip: json['tgl_titip'] != null
          ? DateTime.tryParse(json['tgl_titip'] as String)
          : null,
      tglLaku: json['tgl_laku'] != null
          ? DateTime.tryParse(json['tgl_laku'] as String)
          : null,
      tglAkhir: json['tgl_akhir'] != null
          ? DateTime.tryParse(json['tgl_akhir'] as String)
          : null,
      garansi: json['garansi'] == 1 || json['garansi'] == true, // Handle boolean from int or bool
      perpanjangan: json['perpanjangan'] == 1 || json['perpanjangan'] == true, // Handle boolean from int or bool
      countPerpanjangan: json['count_perpanjangan'] as int,
      status: json['status'] as String,
      gambarBarang: json['gambar_barang'] as String?,
      buktiPembayaran: json['bukti_pembayaran'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_barang': idBarang,
      'id_penitip': idPenitip,
      'id_diskusi': idDiskusi,
      'id_pegawai': idPegawai,
      'nama_barang': namaBarang,
      'deskripsi_barang': deskripsiBarang,
      'kategori': kategori,
      'harga_barang': hargaBarang,
      'tgl_titip': tglTitip?.toIso8601String().split('T')[0], // Format YYYY-MM-DD
      'tgl_laku': tglLaku?.toIso8601String().split('T')[0], // Format YYYY-MM-DD
      'tgl_akhir': tglAkhir?.toIso8601String().split('T')[0], // Format YYYY-MM-DD
      'garansi': garansi ? 1 : 0, // Convert boolean to int for Laravel
      'perpanjangan': perpanjangan ? 1 : 0, // Convert boolean to int for Laravel
      'count_perpanjangan': countPerpanjangan,
      'status': status,
      'gambar_barang': gambarBarang,
      'bukti_pembayaran': buktiPembayaran,
      'rating': rating,
    };
  }

  Barang copyWith({
    String? idBarang,
    String? idPenitip,
    String? idDiskusi,
    String? idPegawai,
    String? namaBarang,
    String? deskripsiBarang,
    String? kategori,
    double? hargaBarang,
    DateTime? tglTitip,
    DateTime? tglLaku,
    DateTime? tglAkhir,
    bool? garansi,
    bool? perpanjangan,
    int? countPerpanjangan,
    String? status,
    String? gambarBarang,
    String? buktiPembayaran,
    double? rating,
  }) {
    return Barang(
      idBarang: idBarang ?? this.idBarang,
      idPenitip: idPenitip ?? this.idPenitip,
      idDiskusi: idDiskusi ?? this.idDiskusi,
      idPegawai: idPegawai ?? this.idPegawai,
      namaBarang: namaBarang ?? this.namaBarang,
      deskripsiBarang: deskripsiBarang ?? this.deskripsiBarang,
      kategori: kategori ?? this.kategori,
      hargaBarang: hargaBarang ?? this.hargaBarang,
      tglTitip: tglTitip ?? this.tglTitip,
      tglLaku: tglLaku ?? this.tglLaku,
      tglAkhir: tglAkhir ?? this.tglAkhir,
      garansi: garansi ?? this.garansi,
      perpanjangan: perpanjangan ?? this.perpanjangan,
      countPerpanjangan: countPerpanjangan ?? this.countPerpanjangan,
      status: status ?? this.status,
      gambarBarang: gambarBarang ?? this.gambarBarang,
      buktiPembayaran: buktiPembayaran ?? this.buktiPembayaran,
      rating: rating ?? this.rating,
    );
  }
}
