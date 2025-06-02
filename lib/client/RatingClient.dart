// lib/clients/rating_client.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../entity/Rating.dart'; // Import model Rating dari folder entity
import '../entity/Penitip.dart'; // Import model Penitip dari folder entity

class RatingClient {
  // URL dasar API Laravel
  static const String _baseUrl = 'http://127.0.0.1:8000/api';

  /// Metode untuk menginput atau memperbarui rating.
  /// Ini akan memanggil endpoint `inputBarangRating` di `BarangController` Anda.
  Future<Rating> storeOrUpdateRating(String idBarang, int ratingValue, {String? authToken}) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/barang/rating'), // Endpoint ini ada di BarangController
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode({
        'id': idBarang, // Nama parameter di Laravel controller adalah 'id'
        'rating': ratingValue,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['success'] == true && responseData['data'] is Map) {
        return Rating.fromJson(responseData['data']);
      } else {
        throw Exception('Gagal menginput/memperbarui rating: ${responseData['message']}');
      }
    } else if (response.statusCode == 400 || response.statusCode == 404 || response.statusCode == 422) {
      // 422 Unprocessable Entity untuk error validasi
      final Map<String, dynamic> errorData = json.decode(response.body);
      throw Exception('Kesalahan input rating: ${errorData['message'] ?? errorData['errors']}');
    } else {
      throw Exception('Gagal menginput/memperbarui rating: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk mendapatkan rating rata-rata penitip.
  Future<Map<String, dynamic>> getPenitipRating(String idPenitip, {String? authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/rating/penitip/$idPenitip'), // Endpoint ini ada di RatingController
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['success'] == true) {
        return {
          'average_rating': (responseData['average_rating'] as num?)?.toDouble(),
          'ratings_count': responseData['ratings_count'] as int,
          'message': responseData['message'],
        };
      } else {
        throw Exception('Gagal memuat rating penitip: ${responseData['message']}');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Penitip tidak ditemukan.');
    } else {
      throw Exception('Gagal memuat rating penitip: ${response.statusCode} - ${response.body}');
    }
  }
}
