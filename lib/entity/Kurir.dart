// import 'package:cloud_firestore/cloud_firestore.dart';

// class Kurir {
//   final String idKurir;
//   final String namaKurir;
//   final String emailKurir;
//   final String? notelpKurir;
//   final String? platNomor; // Nomor plat kendaraan kurir
//   final String status; // Contoh: 'tersedia', 'mengantar', 'offline'
//   final GeoPoint? lokasi; // Lokasi terkini kurir

//   Kurir({
//     required this.idKurir,
//     required this.namaKurir,
//     required this.emailKurir,
//     this.notelpKurir,
//     this.platNomor,
//     this.status = 'offline', // Status default saat objek dibuat
//     this.lokasi,
//   });

//   /// Factory constructor untuk membuat instance Kurir dari dokumen Firestore.
//   /// Ini adalah praktik yang baik saat mengambil data dari Firestore.
//   factory Kurir.fromFirestore(DocumentSnapshot doc) {
//     // Mengambil data dari dokumen sebagai Map
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

//     return Kurir(
//       idKurir: doc.id, // ID kurir diambil dari ID dokumen
//       namaKurir: data['NAMA_KURIR'] ?? '',
//       emailKurir: data['EMAIL_KURIR'] ?? '',
//       notelpKurir: data['NOTELP_KURIR'] as String?,
//       platNomor: data['PLAT_NOMOR'] as String?,
//       status: data['STATUS'] ?? 'offline',
//       lokasi: data['LOKASI'] as GeoPoint?,
//     );
//   }

//   /// Method untuk mengubah objek Kurir menjadi format Map<String, dynamic>.
//   /// Berguna saat Anda ingin menulis atau memperbarui data ke Firestore.
//   Map<String, dynamic> toJson() {
//     return {
//       // idKurir tidak dimasukkan karena biasanya itu adalah ID dokumen
//       'NAMA_KURIR': namaKurir,
//       'EMAIL_KURIR': emailKurir,
//       'NOTELP_KURIR': notelpKurir,
//       'PLAT_NOMOR': platNomor,
//       'STATUS': status,
//       'LOKASI': lokasi,
//     };
//   }

//   /// Method untuk membuat salinan objek Kurir dengan beberapa nilai yang diperbarui.
//   /// Sangat berguna untuk manajemen state (misalnya dengan Provider atau BLoC).
//   Kurir copyWith({
//     String? idKurir,
//     String? namaKurir,
//     String? emailKurir,
//     String? notelpKurir,
//     String? platNomor,
//     String? status,
//     GeoPoint? lokasi,
//   }) {
//     return Kurir(
//       idKurir: idKurir ?? this.idKurir,
//       namaKurir: namaKurir ?? this.namaKurir,
//       emailKurir: emailKurir ?? this.emailKurir,
//       notelpKurir: notelpKurir ?? this.notelpKurir,
//       platNomor: platNomor ?? this.platNomor,
//       status: status ?? this.status,
//       lokasi: lokasi ?? this.lokasi,
//     );
//   }
// }
