// lib/models/rating.dart

import 'dart:convert';

class Rating {
  final String idRating;
  final String? idBarang;
  final String? idPenitip;
  final String? namaBarang; // Opsional, bisa dihilangkan jika selalu diambil dari relasi
  final double rating;

  Rating({
    required this.idRating,
    this.idBarang,
    this.idPenitip,
    this.namaBarang,
    required this.rating,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      idRating: json['id_rating'] as String,
      idBarang: json['id_barang'] as String?,
      idPenitip: json['id_penitip'] as String?,
      namaBarang: json['nama_barang'] as String?,
      rating: (json['rating'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_rating': idRating,
      'id_barang': idBarang,
      'id_penitip': idPenitip,
      'nama_barang': namaBarang,
      'rating': rating,
    };
  }

  Rating copyWith({
    String? idRating,
    String? idBarang,
    String? idPenitip,
    String? namaBarang,
    double? rating,
  }) {
    return Rating(
      idRating: idRating ?? this.idRating,
      idBarang: idBarang ?? this.idBarang,
      idPenitip: idPenitip ?? this.idPenitip,
      namaBarang: namaBarang ?? this.namaBarang,
      rating: rating ?? this.rating,
    );
  }
}
