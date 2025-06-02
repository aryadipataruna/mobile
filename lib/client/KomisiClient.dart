// lib/services/komisi_client.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../entity/Komisi.dart'; // Import model Komisi

class KomisiClient {
  // URL dasar API Laravel
  static const String _baseUrl = 'http://127.0.0.1:8000/api';

  /// Metode untuk mengambil daftar semua komisi.
  Future<List<Komisi>> fetchAllKomisi({String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/komisi'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is List) {
        return (responseData['data'] as List)
            .map((item) => Komisi.fromJson(item))
            .toList();
      } else {
        throw Exception('Gagal memuat komisi: ${responseData['message']}');
      }
    } else {
      throw Exception('Gagal memuat komisi: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk mengambil satu komisi berdasarkan ID.
  Future<Komisi> fetchKomisiById(String id, {String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/komisi/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Komisi.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal memuat komisi: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Komisi tidak ditemukan.');
    } else {
      throw Exception('Gagal memuat komisi: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk membuat komisi baru.
  Future<Komisi> createKomisi(Komisi komisi, {String? authToken}) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/komisi'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
      // Jangan sertakan id_komisi karena akan di-generate di backend
      body: jsonEncode({
        'id_penjualan': komisi.idPenjualan,
        'id_pegawai': komisi.idPegawai,
        'komisi_perusahaan': komisi.komisiPerusahaan,
        'komisi_hunter': komisi.komisiHunter,
        'bonus': komisi.bonus,
      }),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Komisi.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal membuat komisi: ${responseData['message']}');
      }
    } else {
      throw Exception('Gagal membuat komisi: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk memperbarui komisi yang sudah ada.
  Future<Komisi> updateKomisi(String id, Komisi komisi, {String? authToken}) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/komisi/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(komisi.toJson()), // Kirim seluruh objek Komisi untuk update
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Komisi.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal memperbarui komisi: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Komisi tidak ditemukan untuk diperbarui.');
    } else {
      throw Exception('Gagal memperbarui komisi: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk menghapus komisi.
  Future<void> deleteKomisi(String id, {String? authToken}) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/komisi/$id'),
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
        throw Exception('Gagal menghapus komisi: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Komisi tidak ditemukan untuk dihapus.');
    } else {
      throw Exception('Gagal menghapus komisi: ${response.statusCode} - ${response.body}');
    }
  }
}
