// lib/clients/pembeli_client.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../entity/Pembeli.dart'; // Import model Pembeli dari folder entity

class PembeliClient {
  // URL dasar API Laravel
  static const String _baseUrl = 'http://127.0.0.1:8000/api';

  /// Metode untuk mengambil daftar semua pembeli.
  Future<List<Pembeli>> fetchAllPembeli({String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/pembeli'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is List) {
        return (responseData['data'] as List)
            .map((item) => Pembeli.fromJson(item))
            .toList();
      } else {
        throw Exception('Gagal memuat pembeli: ${responseData['message']}');
      }
    } else {
      throw Exception(
          'Gagal memuat pembeli: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk mengambil satu pembeli berdasarkan ID.
  Future<Pembeli> fetchPembeliById(String id, {String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/pembeli/authenticated/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Pembeli.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal memuat pembeli: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Pembeli tidak ditemukan.');
    } else {
      throw Exception(
          'Gagal memuat pembeli: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk membuat pembeli baru (registrasi).
  Future<Pembeli> createPembeli(Pembeli pembeli, String password,
      {String? authToken}) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/pembeli'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
      // Jangan sertakan ID_PEMBELI karena akan di-generate di backend
      body: jsonEncode({
        'NAMA_PEMBELI': pembeli.namaPembeli,
        'EMAIL_PEMBELI': pembeli.emailPembeli,
        'PASSWORD_PEMBELI':
            password, // Kirim password mentah untuk di-hash di backend
        'NO_PEMBELI': pembeli.noPembeli,
        'ALAMAT_PEMBELI': pembeli.alamatPembeli,
        'POIN_PEMBELI': pembeli.poinPembeli,
      }),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Pembeli.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal membuat pembeli: ${responseData['message']}');
      }
    } else {
      throw Exception(
          'Gagal membuat pembeli: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk memperbarui pembeli yang sudah ada.
  Future<Pembeli> updatePembeli(String id, Pembeli pembeli,
      {String? newPassword, String? authToken}) async {
    final Map<String, dynamic> requestBody = pembeli.toJson();
    if (newPassword != null && newPassword.isNotEmpty) {
      requestBody['PASSWORD_PEMBELI'] =
          newPassword; // Kirim password baru jika ada
    }

    final response = await http.put(
      Uri.parse('$_baseUrl/pembeli/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Pembeli.fromJson(responseData['data']);
      } else {
        throw Exception(
            'Gagal memperbarui pembeli: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Pembeli tidak ditemukan untuk diperbarui.');
    } else {
      throw Exception(
          'Gagal memperbarui pembeli: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk menghapus pembeli.
  Future<void> deletePembeli(String id, {String? authToken}) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/pembeli/$id'),
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
        throw Exception('Gagal menghapus pembeli: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Pembeli tidak ditemukan untuk dihapus.');
    } else if (response.statusCode == 409) {
      // Conflict
      final Map<String, dynamic> responseData = json.decode(response.body);
      throw Exception('Gagal menghapus pembeli: ${responseData['message']}');
    } else {
      throw Exception(
          'Gagal menghapus pembeli: ${response.statusCode} - ${response.body}');
    }
  }
}
