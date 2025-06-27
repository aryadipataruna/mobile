// lib/profilePage.dart (atau lokasi file ProfilePage Anda)

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p3l/entity/Pembeli.dart';
import 'package:p3l/client/PembeliClient.dart';
import 'package:p3l/auth_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  // userID akan diambil dari SharedPreferences, jadi kita bisa membuatnya nullable atau hapus dari constructor jika tidak diperlukan secara langsung dari rute
  // Namun, jika Anda mengirimnya dari rute (misal dari halaman beranda), biarkan saja.
  final String?
      userId; // Ubah menjadi nullable jika Anda tidak selalu mengirimnya dari rute

  const ProfilePage({super.key, this.userId}); // Ubah constructor

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Pembeli? _pembeli;
  bool _isLoading = true;
  String? _errorMessage;
  final PembeliClient _pembeliClient = PembeliClient();

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? authToken = prefs.getString('authToken');
      // Gunakan userId dari SharedPreferences jika widget.userId null
      final String? currentUserId =
          widget.userId ?? prefs.getString('currentUserId');

      if (authToken == null || authToken.isEmpty) {
        throw Exception(
            'Token autentikasi tidak ditemukan. Silakan login kembali.');
      }
      if (currentUserId == null || currentUserId.isEmpty) {
        throw Exception('ID pengguna tidak ditemukan. Silakan login kembali.');
      }

      // Menggunakan PembeliClient untuk mengambil data pembeli berdasarkan ID
      // Teruskan token autentikasi
      final Pembeli fetchedPembeli = await _pembeliClient.fetchPembeliById(
        currentUserId, // Menggunakan ID pengguna yang ditemukan
        authToken: authToken, // Meneruskan token autentikasi
      );

      setState(() {
        _pembeli = fetchedPembeli;
        _isLoading = false;
      });
    } on Exception catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
        _isLoading = false;
      });
      print('Error fetching profile data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryDark = Color(0xFF0A0A0A);
    const Color secondaryDark = Color(0xFF1A1A1A);
    const Color cardDark = Color(0xFF2A2A2A);
    const Color accentGreen = Color(0xFF00FF88);
    const Color accentBlue = Color(0xFF00AAFF);
    const Color textLight = Color(0xFFF8F9FA);
    const Color textMuted = Color(0xFFADB5BD);

    return Scaffold(
      backgroundColor: primaryDark,
      appBar: AppBar(
        title: const Text(
          'Profil Saya',
          style: TextStyle(color: textLight, fontWeight: FontWeight.bold),
        ),
        backgroundColor: secondaryDark,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: textLight),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.white.withOpacity(0.1),
            height: 1.0,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: accentGreen))
          : _errorMessage != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, color: Colors.red, size: 60),
                        const SizedBox(height: 20),
                        Text(
                          _errorMessage!,
                          textAlign: TextAlign.center,
                          style:
                              const TextStyle(color: textLight, fontSize: 18),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton.icon(
                          onPressed: _fetchProfileData,
                          icon: const Icon(Icons.refresh, color: Colors.white),
                          label: const Text('Coba Lagi',
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accentBlue,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : _pembeli == null
                  ? Center(
                      child: Text(
                        'Data profil tidak tersedia.',
                        style: TextStyle(color: textMuted, fontSize: 16),
                      ),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildProfileHeader(cardDark, textLight, textMuted,
                              accentGreen, accentBlue),
                          const SizedBox(height: 30),
                          _buildProfileInfo(cardDark, textLight, textMuted),
                          const SizedBox(height: 30),
                          _buildActionButtons(accentGreen, accentBlue),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
    );
  }

  Widget _buildProfileHeader(Color cardDark, Color textLight, Color textMuted,
      Color accentGreen, Color accentBlue) {
    final String defaultProfilePic =
        'https://via.placeholder.com/150/2A2A2A/F8F9FA?text=User';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: textMuted,
            child: Icon(Icons.person,
                size: 70, color: Colors.white.withOpacity(0.6)),
          ),
          const SizedBox(height: 15),
          Text(
            _pembeli!.namaPembeli,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: textLight,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            _pembeli!.emailPembeli ?? 'Tidak Tersedia',
            style: TextStyle(fontSize: 16, color: textMuted),
          ),
          const SizedBox(height: 15),
          if (_pembeli!.poinPembeli != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [accentGreen, accentBlue],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Poin: ${NumberFormat.decimalPattern('id').format(_pembeli!.poinPembeli!)}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo(Color cardDark, Color textLight, Color textMuted) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(Icons.phone, 'Nomor Telepon',
              _pembeli!.noPembeli ?? 'Tidak Tersedia', textLight, textMuted),
          const Divider(color: Colors.white12),
          _buildInfoRow(
              Icons.location_on,
              'Alamat',
              _pembeli!.alamatPembeli ?? 'Tidak Tersedia',
              textLight,
              textMuted),
          const Divider(color: Colors.white12),
          _buildInfoRow(Icons.fingerprint, 'ID Pembeli', _pembeli!.idPembeli,
              textLight, textMuted),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value,
      Color textLight, Color textMuted) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: textMuted, size: 24),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(color: textMuted, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                      color: textLight,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(Color accentGreen, Color accentBlue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              print('Edit Profil clicked!');
            },
            icon: const Icon(Icons.edit, color: Colors.white),
            label: const Text('Edit Profil',
                style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: accentGreen,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () async {
              // --- BARIS YANG DITAMBAHKAN/DIUBAH ---
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              await prefs.remove('authToken'); // Hapus token
              await prefs.remove('currentUserId'); // Hapus ID pengguna

              // Navigasi kembali ke halaman autentikasi
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const AuthPage()),
                (Route<dynamic> route) => false, // Hapus semua rute sebelumnya
              );
              print('Logout clicked!');
              // --- AKHIR BARIS YANG DITAMBAHKAN/DIUBAH ---
            },
            icon: const Icon(Icons.logout, color: Colors.white),
            label: const Text('Logout', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
