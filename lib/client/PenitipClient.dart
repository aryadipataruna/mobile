// lib/clients/penitip_client.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../entity/Penitip.dart'; // Import model Penitip dari folder entity

class PenitipClient {
  // URL dasar API Laravel
  static const String _baseUrl = 'http://127.0.0.1:8000/api';

  /// Metode untuk mengambil daftar semua penitip.
  Future<List<Penitip>> fetchAllPenitip({String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/penitip'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is List) {
        return (responseData['data'] as List)
            .map((item) => Penitip.fromJson(item))
            .toList();
      } else {
        throw Exception('Gagal memuat penitip: ${responseData['message']}');
      }
    } else {
      throw Exception('Gagal memuat penitip: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk mengambil satu penitip berdasarkan ID.
  Future<Penitip> fetchPenitipById(String id, {String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/penitip/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Penitip.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal memuat penitip: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Penitip tidak ditemukan.');
    } else {
      throw Exception('Gagal memuat penitip: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk membuat penitip baru (registrasi).
  Future<Penitip> createPenitip(Penitip penitip, String password, {String? authToken}) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/penitip'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
      // Jangan sertakan ID_PENITIP karena akan di-generate di backend
      body: jsonEncode({
        'NAMA_PENITIP': penitip.namaPenitip,
        'ALAMAT_PENITIP': penitip.alamatPenitip,
        'EMAIL_PENITIP': penitip.emailPenitip,
        'PASSWORD_PENITIP': password, // Kirim password mentah untuk di-hash di backend
        'SALDO_PENITIP': penitip.saldoPenitip,
        'POIN_PENITIP': penitip.poinPenitip,
      }),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Penitip.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal membuat penitip: ${responseData['message']}');
      }
    } else {
      throw Exception('Gagal membuat penitip: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk memperbarui penitip yang sudah ada.
  Future<Penitip> updatePenitip(String id, Penitip penitip, {String? newPassword, String? authToken}) async {
    final Map<String, dynamic> requestBody = penitip.toJson();
    if (newPassword != null && newPassword.isNotEmpty) {
      requestBody['PASSWORD_PENITIP'] = newPassword; // Kirim password baru jika ada
    }

    final response = await http.put(
      Uri.parse('$_baseUrl/penitip/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Penitip.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal memperbarui penitip: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Penitip tidak ditemukan untuk diperbarui.');
    } else {
      throw Exception('Gagal memperbarui penitip: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk menghapus penitip.
  Future<void> deletePenitip(String id, {String? authToken}) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/penitip/$id'),
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
        throw Exception('Gagal menghapus penitip: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Penitip tidak ditemukan untuk dihapus.');
    } else if (response.statusCode == 409) { // Conflict
      final Map<String, dynamic> responseData = json.decode(response.body);
      throw Exception('Gagal menghapus penitip: ${responseData['message']}');
    } else {
      throw Exception('Gagal menghapus penitip: ${response.statusCode} - ${response.body}');
    }
  }
}
