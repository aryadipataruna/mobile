// lib/services/organisasi_client.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../entity/Organisasi.dart'; // Import model Organisasi

class OrganisasiClient {
  // URL dasar API Laravel
  static const String _baseUrl = 'http://127.0.0.1:8000/api';

  /// Metode untuk mengambil daftar semua organisasi.
  Future<List<Organisasi>> fetchAllOrganisasi({String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/organisasi'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is List) {
        return (responseData['data'] as List)
            .map((item) => Organisasi.fromJson(item))
            .toList();
      } else {
        throw Exception('Gagal memuat organisasi: ${responseData['message']}');
      }
    } else {
      throw Exception('Gagal memuat organisasi: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk mengambil satu organisasi berdasarkan ID.
  Future<Organisasi> fetchOrganisasiById(String id, {String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/organisasi/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Organisasi.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal memuat organisasi: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Organisasi tidak ditemukan.');
    } else {
      throw Exception('Gagal memuat organisasi: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk membuat organisasi baru (registrasi).
  Future<Organisasi> createOrganisasi(Organisasi organisasi, String password, {String? authToken}) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/organisasi'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
      // Jangan sertakan ID_ORGANISASI karena akan di-generate di backend
      body: jsonEncode({
        'NAMA_ORGANISASI': organisasi.namaOrganisasi,
        'PASSWORD_ORGANISASI': password, // Kirim password mentah untuk di-hash di backend
        'NOTELP_ORGANISASI': organisasi.notelpOrganisasi,
        'ALAMAT_ORGANISASI': organisasi.alamatOrganisasi,
        'EMAIL_ORGANISASI': organisasi.emailOrganisasi,
      }),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Organisasi.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal membuat organisasi: ${responseData['message']}');
      }
    } else {
      throw Exception('Gagal membuat organisasi: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk memperbarui organisasi yang sudah ada.
  Future<Organisasi> updateOrganisasi(String id, Organisasi organisasi, {String? newPassword, String? authToken}) async {
    final Map<String, dynamic> requestBody = organisasi.toJson();
    if (newPassword != null && newPassword.isNotEmpty) {
      requestBody['PASSWORD_ORGANISASI'] = newPassword; // Kirim password baru jika ada
    }

    final response = await http.put(
      Uri.parse('$_baseUrl/organisasi/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Organisasi.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal memperbarui organisasi: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Organisasi tidak ditemukan untuk diperbarui.');
    } else {
      throw Exception('Gagal memperbarui organisasi: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk menghapus organisasi.
  Future<void> deleteOrganisasi(String id, {String? authToken}) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/organisasi/$id'),
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
        throw Exception('Gagal menghapus organisasi: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Organisasi tidak ditemukan untuk dihapus.');
    } else if (response.statusCode == 409) { // Conflict
      final Map<String, dynamic> responseData = json.decode(response.body);
      throw Exception('Gagal menghapus organisasi: ${responseData['message']}');
    } else {
      throw Exception('Gagal menghapus organisasi: ${response.statusCode} - ${response.body}');
    }
  }
}
