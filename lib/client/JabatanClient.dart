// lib/services/jabatan_client.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../entity/Jabatan.dart'; // Import model Jabatan

class JabatanClient {
  // URL dasar API Laravel
  static const String _baseUrl = 'http://127.0.0.1:8000/api';

  /// Metode untuk mengambil daftar semua jabatan.
  Future<List<Jabatan>> fetchAllJabatan({String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/jabatan'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is List) {
        return (responseData['data'] as List)
            .map((item) => Jabatan.fromJson(item))
            .toList();
      } else {
        throw Exception('Gagal memuat jabatan: ${responseData['message']}');
      }
    } else {
      throw Exception('Gagal memuat jabatan: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk mengambil satu jabatan berdasarkan ID.
  Future<Jabatan> fetchJabatanById(String id, {String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/jabatan/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Jabatan.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal memuat jabatan: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Jabatan tidak ditemukan.');
    } else {
      throw Exception('Gagal memuat jabatan: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk membuat jabatan baru.
  Future<Jabatan> createJabatan(Jabatan jabatan, {String? authToken}) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/jabatan'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
      // Jangan sertakan ID_JABATAN karena akan di-generate di backend
      body: jsonEncode({
        'NAMA_JABATAN': jabatan.namaJabatan,
      }),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Jabatan.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal membuat jabatan: ${responseData['message']}');
      }
    } else {
      throw Exception('Gagal membuat jabatan: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk memperbarui jabatan yang sudah ada.
  Future<Jabatan> updateJabatan(String id, Jabatan jabatan, {String? authToken}) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/jabatan/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(jabatan.toJson()), // Kirim seluruh objek Jabatan untuk update
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Jabatan.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal memperbarui jabatan: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Jabatan tidak ditemukan untuk diperbarui.');
    } else {
      throw Exception('Gagal memperbarui jabatan: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk menghapus jabatan.
  Future<void> deleteJabatan(String id, {String? authToken}) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/jabatan/$id'),
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
        throw Exception('Gagal menghapus jabatan: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Jabatan tidak ditemukan untuk dihapus.');
    } else if (response.statusCode == 409) { // Conflict
      final Map<String, dynamic> responseData = json.decode(response.body);
      throw Exception('Gagal menghapus jabatan: ${responseData['message']}');
    } else {
      throw Exception('Gagal menghapus jabatan: ${response.statusCode} - ${response.body}');
    }
  }
}
