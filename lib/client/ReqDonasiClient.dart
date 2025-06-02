// lib/clients/req_donasi_client.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../entity/ReqDonasi.dart'; // Import model ReqDonasi dari folder entity

class ReqDonasiClient {
  // URL dasar API Laravel
  static const String _baseUrl = 'http://127.0.0.1:8000/api';

  /// Metode untuk mengambil daftar semua permintaan donasi.
  Future<List<ReqDonasi>> fetchAllReqDonasi({String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/reqdonasi'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is List) {
        return (responseData['data'] as List)
            .map((item) => ReqDonasi.fromJson(item))
            .toList();
      } else {
        throw Exception('Gagal memuat permintaan donasi: ${responseData['message']}');
      }
    } else {
      throw Exception('Gagal memuat permintaan donasi: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk mengambil satu permintaan donasi berdasarkan ID.
  Future<ReqDonasi> fetchReqDonasiById(String id, {String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/reqdonasi/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return ReqDonasi.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal memuat permintaan donasi: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Permintaan donasi tidak ditemukan.');
    } else {
      throw Exception('Gagal memuat permintaan donasi: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk membuat permintaan donasi baru.
  Future<ReqDonasi> createReqDonasi(ReqDonasi reqDonasi, {String? authToken}) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/reqdonasi'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
      // Jangan sertakan ID_REQDONASI karena akan di-generate di backend
      body: jsonEncode({
        'ID_ORGANISASI': reqDonasi.idOrganisasi,
        'NAMA_BARANG_REQDONASI': reqDonasi.namaBarangReqDonasi,
        'TGL_REQ': reqDonasi.tglReq?.toIso8601String().split('T')[0],
      }),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return ReqDonasi.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal membuat permintaan donasi: ${responseData['message']}');
      }
    } else {
      throw Exception('Gagal membuat permintaan donasi: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk memperbarui permintaan donasi yang sudah ada.
  Future<ReqDonasi> updateReqDonasi(String id, ReqDonasi reqDonasi, {String? authToken}) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/reqdonasi/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(reqDonasi.toJson()), // Kirim seluruh objek ReqDonasi untuk update
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return ReqDonasi.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal memperbarui permintaan donasi: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Permintaan donasi tidak ditemukan untuk diperbarui.');
    } else {
      throw Exception('Gagal memperbarui permintaan donasi: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk menghapus permintaan donasi.
  Future<void> deleteReqDonasi(String id, {String? authToken}) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/reqdonasi/$id'),
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
        throw Exception('Gagal menghapus permintaan donasi: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Permintaan donasi tidak ditemukan untuk dihapus.');
    } else {
      throw Exception('Gagal menghapus permintaan donasi: ${response.statusCode} - ${response.body}');
    }
  }
}
