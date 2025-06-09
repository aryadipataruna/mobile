// lib/services/login_client.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:p3l/entity/Kurir.dart';

// Impor model yang mungkin dikembalikan setelah login
import '../entity/Pegawai.dart';
import '../entity/Pembeli.dart';
import '../entity/Penitip.dart';
import '../entity/Organisasi.dart';

/// Kelas client untuk menangani operasi login dan otentikasi.
class LoginClient {
  // URL dasar API Laravel
  static const String _baseUrl = 'http://127.0.0.1:8000/api';

  /// Metode untuk melakukan login pengguna.
  /// Mengembalikan Map yang berisi token, data pengguna, dan peran.
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'), // Sesuaikan dengan endpoint login Anda
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['success'] == true && responseData['data'] is Map) {
        final userData = responseData['data']['user'];
        final String role = responseData['data']['role'];
        dynamic userModel;

        // Parse data pengguna ke model yang sesuai berdasarkan peran
        switch (role) {
          case 'owner':
          case 'admin':
          case 'kepala gudang':
          case 'customer service':
          case 'hunter':
          case 'kurir':
          case 'pegawai':
            userModel = Pegawai.fromJson(userData);
            break;
          case 'penitip':
            userModel = Penitip.fromJson(userData);
            break;
          case 'pembeli':
            userModel = Pembeli.fromJson(userData);
            break;
          case 'organisasi':
            userModel = Organisasi.fromJson(userData);
            break;
          case 'kurir':
            userModel = Kurir.fromJson(userData);
            break;

          // case 'hunter':
          //   userModel = Hunter.fromJson(userData);
          //   break;

          default:
            // Handle unknown role or no specific model
            userModel = userData; // Return raw data if no specific model
            break;
        }

        return {
          'token': responseData['data']['token'],
          'user': userModel,
          'role': role,
          'message': responseData['message'],
        };
      } else {
        throw Exception('Gagal login: ${responseData['message']}');
      }
    } else if (response.statusCode == 401) {
      final Map<String, dynamic> errorData = json.decode(response.body);
      throw Exception('Otentikasi gagal: ${errorData['message']}');
    } else {
      throw Exception('Gagal login: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk mendapatkan informasi pengguna yang sedang login.
  /// Membutuhkan token otentikasi.
  Future<Map<String, dynamic>> getUser({required String authToken}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/user'), // Sesuaikan dengan endpoint get user Anda
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['success'] == true && responseData['data'] is Map) {
        final userData = responseData['data']['user'];
        final String role = responseData['data']['role'];
        dynamic userModel;

        // Parse data pengguna ke model yang sesuai berdasarkan peran
        switch (role) {
          case 'owner':
          case 'admin':
          case 'kepala gudang':
          case 'customer service':
          case 'hunter':
          case 'kurir':
          case 'pegawai':
            userModel = Pegawai.fromJson(userData);
            break;
          case 'penitip':
            userModel = Penitip.fromJson(userData);
            break;
          case 'pembeli':
            userModel = Pembeli.fromJson(userData);
            break;
          case 'organisasi':
            userModel = Organisasi.fromJson(userData);
            break;
          case 'kurir':
            userModel = Kurir.fromJson(userData);
            break;

          default:
            userModel = userData;
            break;
        }

        return {
          'user': userModel,
          'role': role,
          'message': responseData['message'],
        };
      } else {
        throw Exception(
            'Gagal mendapatkan data user: ${responseData['message']}');
      }
    } else if (response.statusCode == 401) {
      throw Exception('Tidak terotentikasi: Token tidak valid atau tidak ada.');
    } else {
      throw Exception(
          'Gagal mendapatkan data user: ${response.statusCode} - ${response.body}');
    }
  }

  /// Metode untuk melakukan logout pengguna.
  /// Membutuhkan token otentikasi.
  Future<void> logout({required String authToken}) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/logout'), // Sesuaikan dengan endpoint logout Anda
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['success'] == true) {
        return; // Logout berhasil
      } else {
        throw Exception('Gagal logout: ${responseData['message']}');
      }
    } else if (response.statusCode == 401) {
      throw Exception('Tidak terotentikasi: Token tidak valid atau tidak ada.');
    } else {
      throw Exception(
          'Gagal logout: ${response.statusCode} - ${response.body}');
    }
  }
}
