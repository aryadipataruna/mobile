// lib/services/merchandise_client.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../entity/Merchandise.dart'; // Import model Merchandise

class MerchandiseClient {
  // URL dasar API Laravel
  static const String _baseUrl = 'http://127.0.0.1:8000/api';

  /// Metode untuk mengambil daftar semua merchandise.
  Future<List<Merchandise>> fetchAllMerchandise({String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/merchandise'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is List) {
        return (responseData['data'] as List)
            .map((item) => Merchandise.fromJson(item))
            .toList();
      } else {
        throw Exception('Gagal memuat merchandise: ${responseData['message']}');
      }
    } else {
      throw Exception('Gagal memuat merchandise: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk mengambil satu merchandise berdasarkan ID.
  Future<Merchandise> fetchMerchandiseById(String id, {String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/merchandise/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Merchandise.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal memuat merchandise: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Merchandise tidak ditemukan.');
    } else {
      throw Exception('Gagal memuat merchandise: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk membuat merchandise baru.
  Future<Merchandise> createMerchandise(Merchandise merchandise, {String? authToken}) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/merchandise'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
      // Jangan sertakan ID_MERCHANDISE karena akan di-generate di backend
      body: jsonEncode({
        'NAMA_MERCHANDISE': merchandise.namaMerchandise,
        'ID_PENUKARAN': merchandise.idPenukaran,
      }),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Merchandise.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal membuat merchandise: ${responseData['message']}');
      }
    } else {
      throw Exception('Gagal membuat merchandise: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk memperbarui merchandise yang sudah ada.
  Future<Merchandise> updateMerchandise(String id, Merchandise merchandise, {String? authToken}) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/merchandise/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(merchandise.toJson()), // Kirim seluruh objek Merchandise untuk update
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Merchandise.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal memperbarui merchandise: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Merchandise tidak ditemukan untuk diperbarui.');
    } else {
      throw Exception('Gagal memperbarui merchandise: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk menghapus merchandise.
  Future<void> deleteMerchandise(String id, {String? authToken}) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/merchandise/$id'),
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
        throw Exception('Gagal menghapus merchandise: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Merchandise tidak ditemukan untuk dihapus.');
    } else {
      throw Exception('Gagal menghapus merchandise: ${response.statusCode} - ${response.body}');
    }
  }
}
