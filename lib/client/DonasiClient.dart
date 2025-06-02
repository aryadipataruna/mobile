// lib/services/donasi_client.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../entity/Donasi.dart'; // Import model Donasi

class DonasiClient {
  // URL dasar API Laravel
  static const String _baseUrl = 'http://127.0.0.1:8000/api';

  /// Metode untuk mengambil daftar semua donasi.
  Future<List<Donasi>> fetchAllDonasi({String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/donasi'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is List) {
        return (responseData['data'] as List)
            .map((item) => Donasi.fromJson(item))
            .toList();
      } else {
        throw Exception('Gagal memuat donasi: ${responseData['message']}');
      }
    } else {
      throw Exception('Gagal memuat donasi: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk mengambil satu donasi berdasarkan ID.
  Future<Donasi> fetchDonasiById(String id, {String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/donasi/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Donasi.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal memuat donasi: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Donasi tidak ditemukan.');
    } else {
      throw Exception('Gagal memuat donasi: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk membuat donasi baru.
  Future<Donasi> createDonasi(Donasi donasi, {String? authToken}) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/donasi'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
      // Jangan sertakan ID_DONASI karena akan di-generate di backend
      body: jsonEncode({
        'ID_ORGANISASI': donasi.idOrganisasi,
        'NAMA_BARANG_DONASI': donasi.namaBarangDonasi,
        'TGL_DONASI': donasi.tglDonasi.toIso8601String().split('T')[0],
        'NAMA_PENERIMA': donasi.namaPenerima,
      }),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Donasi.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal membuat donasi: ${responseData['message']}');
      }
    } else {
      throw Exception('Gagal membuat donasi: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk memperbarui donasi yang sudah ada.
  Future<Donasi> updateDonasi(String id, Donasi donasi, {String? authToken}) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/donasi/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(donasi.toJson()), // Kirim seluruh objek Donasi untuk update
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Donasi.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal memperbarui donasi: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Donasi tidak ditemukan untuk diperbarui.');
    } else {
      throw Exception('Gagal memperbarui donasi: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk menghapus donasi.
  Future<void> deleteDonasi(String id, {String? authToken}) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/donasi/$id'),
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
        throw Exception('Gagal menghapus donasi: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Donasi tidak ditemukan untuk dihapus.');
    } else {
      throw Exception('Gagal menghapus donasi: ${response.statusCode} - ${response.body}');
    }
  }
}
