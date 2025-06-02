// lib/clients/penukaran_client.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../entity/Penukaran.dart'; // Import model Penukaran dari folder entity

class PenukaranClient {
  // URL dasar API Laravel
  static const String _baseUrl = 'http://127.0.0.1:8000/api';

  /// Metode untuk mengambil daftar semua penukaran.
  Future<List<Penukaran>> fetchAllPenukaran({String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/penukaran'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is List) {
        return (responseData['data'] as List)
            .map((item) => Penukaran.fromJson(item))
            .toList();
      } else {
        throw Exception('Gagal memuat penukaran: ${responseData['message']}');
      }
    } else {
      throw Exception('Gagal memuat penukaran: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk mengambil satu penukaran berdasarkan ID.
  Future<Penukaran> fetchPenukaranById(String id, {String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/penukaran/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Penukaran.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal memuat penukaran: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Penukaran tidak ditemukan.');
    } else {
      throw Exception('Gagal memuat penukaran: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk membuat penukaran baru.
  Future<Penukaran> createPenukaran(Penukaran penukaran, {String? authToken}) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/penukaran'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
      // Jangan sertakan ID_PENUKARAN karena akan di-generate di backend
      body: jsonEncode({
        'ID_PEMBELI': penukaran.idPembeli,
        'NAMA_PENUKAR': penukaran.namaPenukar,
        'TANGGAL_TUKAR': penukaran.tanggalTukar?.toIso8601String().split('T')[0],
      }),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Penukaran.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal membuat penukaran: ${responseData['message']}');
      }
    } else {
      throw Exception('Gagal membuat penukaran: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk memperbarui penukaran yang sudah ada.
  Future<Penukaran> updatePenukaran(String id, Penukaran penukaran, {String? authToken}) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/penukaran/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(penukaran.toJson()), // Kirim seluruh objek Penukaran untuk update
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Penukaran.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal memperbarui penukaran: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Penukaran tidak ditemukan untuk diperbarui.');
    } else {
      throw Exception('Gagal memperbarui penukaran: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk menghapus penukaran.
  Future<void> deletePenukaran(String id, {String? authToken}) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/penukaran/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true) {
        return; // Berhasil dihapus
      } else {
        throw Exception('Gagal menghapus penukaran: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Penukaran tidak ditemukan untuk dihapus.');
    } else {
      throw Exception('Gagal menghapus penukaran: ${response.statusCode} - ${response.body}');
    }
  }
}
