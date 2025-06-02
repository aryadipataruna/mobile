// lib/clients/penitipan_barang_client.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../entity/Penitipan.dart'; // Import model PenitipanBarang dari folder entity

class PenitipanBarangClient {
  // URL dasar API Laravel
  static const String _baseUrl = 'http://127.0.0.1:8000/api';

  /// Metode untuk mengambil nota penitipan PDF.
  /// Catatan: Ini akan mengembalikan respons byte, bukan JSON.
  Future<List<int>> generateNotaPdf(String noNota, {String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/generate-nota-pdf/$noNota'),
      headers: {
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      return response.bodyBytes; // Mengembalikan byte dari file PDF
    } else if (response.statusCode == 404) {
      throw Exception('Nota penitipan tidak ditemukan.');
    } else {
      throw Exception('Gagal membuat PDF nota penitipan: ${response.statusCode} - ${response.body}');
    }
  }

  // Metode untuk mengambil daftar semua penitipan barang (jika ada endpoint di Laravel)
  // Anda perlu menambahkan endpoint ini di Laravel jika ingin fungsionalitas ini.
  // Future<List<PenitipanBarang>> fetchAllPenitipanBarang({String? authToken}) async {
  //   final response = await http.get(
  //     Uri.parse('$_baseUrl/penitipan-barang'), // Sesuaikan dengan endpoint Anda
  //     headers: {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       if (authToken != null) 'Authorization': 'Bearer $authToken',
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> responseData = json.decode(response.body);
  //     if (responseData['status'] == true && responseData['data'] is List) {
  //       return (responseData['data'] as List)
  //           .map((item) => PenitipanBarang.fromJson(item))
  //           .toList();
  //     } else {
  //       throw Exception('Gagal memuat penitipan barang: ${responseData['message']}');
  //     }
  //   } else {
  //     throw Exception('Gagal memuat penitipan barang: ${response.statusCode} - ${response.body}');
  //   }
  // }

  // Metode untuk membuat penitipan barang baru (jika ada endpoint di Laravel)
  // Future<PenitipanBarang> createPenitipanBarang(PenitipanBarang penitipan, {String? authToken}) async {
  //   final response = await http.post(
  //     Uri.parse('$_baseUrl/penitipan-barang'), // Sesuaikan dengan endpoint Anda
  //     headers: {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       if (authToken != null) 'Authorization': 'Bearer $authToken',
  //     },
  //     body: jsonEncode(penitipan.toJson()),
  //   );

  //   if (response.statusCode == 201) {
  //     final Map<String, dynamic> responseData = json.decode(response.body);
  //     if (responseData['status'] == true && responseData['data'] is Map) {
  //       return PenitipanBarang.fromJson(responseData['data']);
  //     } else {
  //       throw Exception('Gagal membuat penitipan barang: ${responseData['message']}');
  //     }
  //   } else {
  //     throw Exception('Gagal membuat penitipan barang: ${response.statusCode} - ${response.body}');
  //   }
  // }
}
