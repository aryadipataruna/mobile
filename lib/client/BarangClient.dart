// lib/services/barang_client.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../entity/Barang.dart'; // Import model Barang
import '../entity/Rating.dart'; // Import model Rating

class BarangClient {
  // URL dasar API Laravel
  static const String _baseUrl = 'http://127.0.0.1:8000/api';

  /// Metode untuk mengambil daftar semua barang.
  Future<List<Barang>> fetchAllBarang({String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/barang'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is List) {
        return (responseData['data'] as List)
            .map((item) => Barang.fromJson(item))
            .toList();
      } else {
        throw Exception('Gagal memuat barang: ${responseData['message']}');
      }
    } else {
      throw Exception('Gagal memuat barang: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk mengambil daftar barang dengan status 'terjual'.
  Future<List<Barang>> fetchProdukTerjual({String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/barang/terjual'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is List) {
        return (responseData['data'] as List)
            .map((item) => Barang.fromJson(item))
            .toList();
      } else {
        throw Exception('Gagal memuat produk terjual: ${responseData['message']}');
      }
    } else {
      throw Exception('Gagal memuat produk terjual: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk mengambil daftar barang dengan status 'tersedia'.
  Future<List<Barang>> fetchProdukTersedia({String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/barang/tersedia'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is List) {
        return (responseData['data'] as List)
            .map((item) => Barang.fromJson(item))
            .toList();
      } else {
        throw Exception('Gagal memuat produk tersedia: ${responseData['message']}');
      }
    } else {
      throw Exception('Gagal memuat produk tersedia: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk mengambil satu barang berdasarkan ID.
  Future<Barang> fetchBarangById(String id, {String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/barang/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Barang.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal memuat barang: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Barang tidak ditemukan.');
    } else {
      throw Exception('Gagal memuat barang: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk membuat barang baru.
  Future<Barang> createBarang(Barang barang, {String? authToken}) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/barang'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
      // Jangan sertakan id_barang karena akan di-generate di backend
      body: jsonEncode({
        'id_penitip': barang.idPenitip,
        'id_diskusi': barang.idDiskusi,
        'id_pegawai': barang.idPegawai,
        'nama_barang': barang.namaBarang,
        'deskripsi_barang': barang.deskripsiBarang,
        'kategori': barang.kategori,
        'harga_barang': barang.hargaBarang,
        'tgl_titip': barang.tglTitip?.toIso8601String().split('T')[0],
        'tgl_laku': barang.tglLaku?.toIso8601String().split('T')[0],
        'tgl_akhir': barang.tglAkhir?.toIso8601String().split('T')[0],
        'garansi': barang.garansi ? 1 : 0, // Convert bool to int
        'perpanjangan': barang.perpanjangan ? 1 : 0, // Convert bool to int
        'count_perpanjangan': barang.countPerpanjangan,
        'status': barang.status,
        'gambar_barang': barang.gambarBarang,
        'bukti_pembayaran': barang.buktiPembayaran,
        'rating': barang.rating,
      }),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Barang.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal membuat barang: ${responseData['message']}');
      }
    } else {
      throw Exception('Gagal membuat barang: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk memperbarui barang yang sudah ada.
  Future<Barang> updateBarang(String id, Barang barang, {String? authToken}) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/barang/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(barang.toJson()), // Kirim seluruh objek Barang untuk update
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Barang.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal memperbarui barang: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Barang tidak ditemukan untuk diperbarui.');
    } else {
      throw Exception('Gagal memperbarui barang: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk menghapus barang.
  Future<void> deleteBarang(String id, {String? authToken}) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/barang/$id'),
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
        throw Exception('Gagal menghapus barang: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Barang tidak ditemukan untuk dihapus.');
    } else {
      throw Exception('Gagal menghapus barang: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk memperpanjang masa titip barang.
  Future<Barang> extendBarang(String id, {String? authToken}) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/barang/extend/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        return Barang.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal memperpanjang masa titip: ${responseData['message']}');
      }
    } else if (response.statusCode == 400) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      throw Exception('Kesalahan perpanjangan: ${responseData['message']}');
    } else {
      throw Exception('Gagal memperpanjang masa titip: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk mendapatkan rating barang.
  Future<Rating?> fetchBarangRating(String id, {String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/barang/rating/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['success'] == true) {
        if (responseData['rating'] != null) {
          return Rating.fromJson(responseData['rating']);
        } else {
          return null; // Barang belum memiliki rating
        }
      } else {
        throw Exception('Gagal memuat rating barang: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Barang tidak ditemukan.');
    } else {
      throw Exception('Gagal memuat rating barang: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk menginput atau memperbarui rating barang.
  Future<Rating> inputBarangRating(String idBarang, int ratingValue, {String? authToken}) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/barang/rating'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode({
        'id': idBarang,
        'rating': ratingValue,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['success'] == true && responseData['data'] is Map) {
        return Rating.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal menginput rating barang: ${responseData['message']}');
      }
    } else if (response.statusCode == 400 || response.statusCode == 404) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      throw Exception('Kesalahan input rating: ${responseData['message']}');
    } else {
      throw Exception('Gagal menginput rating barang: ${response.statusCode} - ${response.body}');
    }
  }
}
