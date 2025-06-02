// lib/services/diskusi_client.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../entity/Diskusi.dart'; // Import model Diskusi

class DiskusiClient {
  // URL dasar API Laravel
  static const String _baseUrl = 'http://127.0.0.1:8000/api';

  /// Metode untuk mengambil daftar semua diskusi.
  Future<List<Diskusi>> fetchAllDiskusi({String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/diskusi'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is List) {
        return (responseData['data'] as List)
            .map((item) => Diskusi.fromJson(item))
            .toList();
      } else {
        throw Exception('Gagal memuat diskusi: ${responseData['message']}');
      }
    } else {
      throw Exception('Gagal memuat diskusi: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk mengambil satu diskusi berdasarkan ID.
  Future<Diskusi> fetchDiskusiById(String id, {String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/diskusi/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Diskusi.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal memuat diskusi: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Diskusi tidak ditemukan.');
    } else {
      throw Exception('Gagal memuat diskusi: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk membuat diskusi baru.
  Future<Diskusi> createDiskusi(Diskusi diskusi, {String? authToken}) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/diskusi'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
      // Jangan sertakan ID_DISKUSI karena akan di-generate di backend
      body: jsonEncode({
        'ID_PENITIP': diskusi.idPenitip,
        'ID_PEMBELI': diskusi.idPembeli,
        'ID_BARANG': diskusi.idBarang,
      }),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Diskusi.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal membuat diskusi: ${responseData['message']}');
      }
    } else {
      throw Exception('Gagal membuat diskusi: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk memperbarui diskusi yang sudah ada.
  Future<Diskusi> updateDiskusi(String id, Diskusi diskusi, {String? authToken}) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/diskusi/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(diskusi.toJson()), // Kirim seluruh objek Diskusi untuk update
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Diskusi.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal memperbarui diskusi: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Diskusi tidak ditemukan untuk diperbarui.');
    } else {
      throw Exception('Gagal memperbarui diskusi: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk menghapus diskusi.
  Future<void> deleteDiskusi(String id, {String? authToken}) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/diskusi/$id'),
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
        throw Exception('Gagal menghapus diskusi: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Diskusi tidak ditemukan untuk dihapus.');
    } else {
      throw Exception('Gagal menghapus diskusi: ${response.statusCode} - ${response.body}');
    }
  }
}
