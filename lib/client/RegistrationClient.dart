// lib/clients/registration_client.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

// Import semua client yang relevan untuk registrasi
import '../entity/Pembeli.dart';
import '../entity/Penitip.dart';
import '../entity/Pegawai.dart';
import '../entity/Organisasi.dart';

class RegistrationClient {
  // URL dasar API Laravel
  static const String _baseUrl = 'http://127.0.0.1:8000/api';

  /// Metode untuk menangani registrasi berdasarkan peran.
  /// Mengirimkan data registrasi ke endpoint `handle-registration` di Laravel.
  Future<Map<String, dynamic>> registerUser({
    required String role,
    required String name,
    required String email,
    required String password,
    String? phone,
    String? address,
    String? jabatanId, // Hanya untuk Pegawai
  }) async {
    final Map<String, dynamic> requestBody = {
      'role': role,
      'name': name,
      'email': email,
      'password': password,
    };

    // Tambahkan field opsional sesuai peran
    if (phone != null) requestBody['notelp'] = phone; // Untuk Pembeli, Penitip, Organisasi, Pegawai
    if (address != null) requestBody['alamat'] = address; // Untuk Pembeli, Penitip, Organisasi, Pegawai
    if (jabatanId != null && role == 'pegawai') requestBody['ID_JABATAN'] = jabatanId; // Untuk Pegawai

    final response = await http.post(
      Uri.parse('$_baseUrl/register'), // Sesuaikan dengan endpoint registrasi Anda
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == true && responseData['data'] is Map) {
        // Berdasarkan peran, parse data yang dikembalikan ke entity yang sesuai
        dynamic registeredEntity;
        switch (role) {
          case 'pembeli':
            registeredEntity = Pembeli.fromJson(responseData['data']);
            break;
          case 'penitip':
            registeredEntity = Penitip.fromJson(responseData['data']);
            break;
          case 'pegawai':
            registeredEntity = Pegawai.fromJson(responseData['data']);
            break;
          case 'organisasi':
            registeredEntity = Organisasi.fromJson(responseData['data']);
            break;
          default:
            registeredEntity = responseData['data']; // Fallback ke raw data
        }
        return {
          'status': true,
          'message': responseData['message'],
          'data': registeredEntity,
        };
      } else {
        throw Exception('Gagal registrasi: ${responseData['message']}');
      }
    } else if (response.statusCode == 422) { // Unprocessable Entity untuk error validasi
      final Map<String, dynamic> errorData = json.decode(response.body);
      throw Exception('Validasi gagal: ${errorData['errors'] ?? errorData['message']}');
    } else {
      throw Exception('Gagal registrasi: ${response.statusCode} - ${response.body}');
    }
  }
}
