import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PageProfileKurir extends StatelessWidget {
  const PageProfileKurir({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mengambil informasi pengguna yang saat ini login dari Firebase Auth
    final user = FirebaseAuth.instance.currentUser;

    // Jika tidak ada pengguna yang login, tampilkan pesan untuk login
    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Profil Kurir'),
          backgroundColor: Colors.white,
          elevation: 2,
        ),
        body: const Center(
          child: Text('Silakan login terlebih dahulu'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil Kurir',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      // Menggunakan StreamBuilder untuk mendapatkan data profil kurir secara real-time
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('couriers') // Mengambil dari koleksi 'couriers'
            .doc(user.uid) // dengan dokumen ID yang sesuai dengan UID pengguna
            .snapshots(),
        builder: (context, snapshot) {
          // Tampilkan indikator loading saat data sedang diambil
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Tampilkan pesan jika data profil tidak ditemukan
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Profil tidak ditemukan'));
          }

          // Ambil data dari snapshot dan ubah menjadi Map
          final data = snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 32,
                          backgroundImage: NetworkImage(
                              'https://via.placeholder.com/64'), // Gambar placeholder
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['name'] ?? 'Nama Tidak Diketahui',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'ID: ${data['courierId'] ?? 'N/A'}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Menampilkan detail profil kurir
                    Text(
                      'Telepon: ${data['phone'] ?? 'N/A'}',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
