// lib/clients/penjualan_client.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../entity/Penjualan.dart'; // Import model Penjualan dari folder entity

class PenjualanClient {
  // URL dasar API Laravel
  static const String _baseUrl = 'http://127.0.0.1:8000/api';

  /// Metode untuk mengambil daftar semua penjualan.
  Future<List<Penjualan>> fetchAllPenjualan({String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/penjualan'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is List) {
        return (responseData['data'] as List)
            .map((item) => Penjualan.fromJson(item))
            .toList();
      } else {
        throw Exception('Gagal memuat penjualan: ${responseData['message']}');
      }
    } else {
      throw Exception(
          'Gagal memuat penjualan: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk mengambil satu penjualan berdasarkan ID.
  Future<Penjualan> fetchPenjualanById(String id, {String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/penjualan/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Penjualan.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal memuat penjualan: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Penjualan tidak ditemukan.');
    } else {
      throw Exception(
          'Gagal memuat penjualan: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk membuat penjualan baru.
  Future<Penjualan> createPenjualan(Penjualan penjualan,
      {String? authToken}) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/penjualan'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
      // Jangan sertakan id_penjualan karena akan di-generate di backend
      body: jsonEncode({
        'id_pembeli': penjualan.idPembeli,
        'id_barang': penjualan.idBarang,
        'id_komisi': penjualan.idKomisi,
        'id_pegawai': penjualan.idPegawai,
        'tgl_pesan': penjualan.tglPesan?.toIso8601String().split('T')[0],
        'tgl_kirim': penjualan.tglKirim?.toIso8601String().split('T')[0],
        'tgl_ambil': penjualan.tglAmbil?.toIso8601String().split('T')[0],
        'status': penjualan.status,
        'jenis_pengantaran': penjualan.jenisPengantaran,
        'tgl_pembayaran':
            penjualan.tglPembayaran?.toIso8601String().split('T')[0],
        'total_ongkir': penjualan.totalOngkir,
        'harga_setelah_ongkir': penjualan.hargaSetelahOngkir,
        'potongan_harga': penjualan.potonganHarga,
        'total_harga': penjualan.totalHarga,
      }),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Penjualan.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal membuat penjualan: ${responseData['message']}');
      }
    } else {
      throw Exception(
          'Gagal membuat penjualan: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk memperbarui penjualan yang sudah ada.
  Future<Penjualan> updatePenjualan(String id, Penjualan penjualan,
      {String? authToken}) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/penjualan/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(
          penjualan.toJson()), // Kirim seluruh objek Penjualan untuk update
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Penjualan.fromJson(responseData['data']);
      } else {
        throw Exception(
            'Gagal memperbarui penjualan: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Penjualan tidak ditemukan untuk diperbarui.');
    } else {
      throw Exception(
          'Gagal memperbarui penjualan: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk menghapus penjualan.
  Future<void> deletePenjualan(String id, {String? authToken}) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/penjualan/$id'),
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
        throw Exception(
            'Gagal menghapus penjualan: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Penjualan tidak ditemukan untuk dihapus.');
    } else {
      throw Exception(
          'Gagal menghapus penjualan: ${response.statusCode} - ${response.body}');
    }
  }
}
