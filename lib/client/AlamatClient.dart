// lib/services/alamat_client.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../entity/Alamat.dart'; // Import model Alamat

class AlamatClient {
  // URL dasar API Laravel
  static const String _baseUrl = 'http://127.0.0.1:8000/api';

  /// Metode untuk mengambil daftar semua alamat.
  Future<List<Alamat>> fetchAllAlamat({String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/alamat'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is List) {
        return (responseData['data'] as List)
            .map((item) => Alamat.fromJson(item))
            .toList();
      } else {
        throw Exception('Gagal memuat alamat: ${responseData['message']}');
      }
    } else {
      throw Exception('Gagal memuat alamat: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk mengambil satu alamat berdasarkan ID.
  Future<Alamat> fetchAlamatById(String id, {String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/alamat/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Alamat.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal memuat alamat: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Alamat tidak ditemukan.');
    } else {
      throw Exception('Gagal memuat alamat: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk membuat alamat baru.
  Future<Alamat> createAlamat(Alamat alamat, {String? authToken}) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/alamat'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
      // Jangan sertakan ID_ALAMAT karena akan di-generate di backend
      body: jsonEncode({
        'ID_PEMBELI': alamat.idPembeli,
        'ID_ORGANISASI': alamat.idOrganisasi,
        'DESKRIPSI_ALAMAT': alamat.deskripsiAlamat,
      }),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Alamat.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal membuat alamat: ${responseData['message']}');
      }
    } else {
      throw Exception('Gagal membuat alamat: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk memperbarui alamat yang sudah ada.
  Future<Alamat> updateAlamat(String id, Alamat alamat, {String? authToken}) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/alamat/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(alamat.toJson()), // Kirim seluruh objek Alamat untuk update
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Alamat.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal memperbarui alamat: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Alamat tidak ditemukan untuk diperbarui.');
    } else {
      throw Exception('Gagal memperbarui alamat: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk menghapus alamat.
  Future<void> deleteAlamat(String id, {String? authToken}) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/alamat/$id'),
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
        throw Exception('Gagal menghapus alamat: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Alamat tidak ditemukan untuk dihapus.');
    } else {
      throw Exception('Gagal menghapus alamat: ${response.statusCode} - ${response.body}');
    }
  }
}
