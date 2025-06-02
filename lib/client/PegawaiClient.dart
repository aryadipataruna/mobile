// lib/clients/pegawai_client.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../entity/Pegawai.dart'; // Import model Pegawai dari folder entity

class PegawaiClient {
  // URL dasar API Laravel
  static const String _baseUrl = 'http://127.0.0.1:8000/api';

  /// Metode untuk mengambil daftar semua pegawai.
  Future<List<Pegawai>> fetchAllPegawai({String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/pegawai'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is List) {
        return (responseData['data'] as List)
            .map((item) => Pegawai.fromJson(item))
            .toList();
      } else {
        throw Exception('Gagal memuat pegawai: ${responseData['message']}');
      }
    } else {
      throw Exception('Gagal memuat pegawai: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk mengambil satu pegawai berdasarkan ID.
  Future<Pegawai> fetchPegawaiById(String id, {String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/pegawai/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Pegawai.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal memuat pegawai: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Pegawai tidak ditemukan.');
    } else {
      throw Exception('Gagal memuat pegawai: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk membuat pegawai baru (registrasi).
  Future<Pegawai> createPegawai(Pegawai pegawai, String password, {String? authToken}) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/pegawai'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
      // Jangan sertakan ID_PEGAWAI karena akan di-generate di backend
      body: jsonEncode({
        'ID_JABATAN': pegawai.idJabatan,
        'NAMA_PEGAWAI': pegawai.namaPegawai,
        'TGL_LAHIR_PEGAWAI': pegawai.tglLahirPegawai,
        'NOTELP_PEGAWAI': pegawai.notelpPegawai,
        'EMAIL_PEGAWAI': pegawai.emailPegawai,
        'ALAMAT_PEGAWAI': pegawai.alamatPegawai,
        'PASSWORD_PEGAWAI': password, // Kirim password mentah untuk di-hash di backend
      }),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Pegawai.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal membuat pegawai: ${responseData['message']}');
      }
    } else {
      throw Exception('Gagal membuat pegawai: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk memperbarui pegawai yang sudah ada.
  Future<Pegawai> updatePegawai(String id, Pegawai pegawai, {String? newPassword, String? authToken}) async {
    final Map<String, dynamic> requestBody = pegawai.toJson();
    if (newPassword != null && newPassword.isNotEmpty) {
      requestBody['PASSWORD_PEGAWAI'] = newPassword; // Kirim password baru jika ada
    }

    final response = await http.put(
      Uri.parse('$_baseUrl/pegawai/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Pegawai.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal memperbarui pegawai: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Pegawai tidak ditemukan untuk diperbarui.');
    } else {
      throw Exception('Gagal memperbarui pegawai: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk menghapus pegawai.
  Future<void> deletePegawai(String id, {String? authToken}) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/pegawai/$id'),
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
        throw Exception('Gagal menghapus pegawai: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Pegawai tidak ditemukan untuk dihapus.');
    } else if (response.statusCode == 409) { // Conflict
      final Map<String, dynamic> responseData = json.decode(response.body);
      throw Exception('Gagal menghapus pegawai: ${responseData['message']}');
    } else {
      throw Exception('Gagal menghapus pegawai: ${response.statusCode} - ${response.body}');
    }
  }
}
