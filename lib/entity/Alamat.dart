import 'dart:convert';

class Alamat {
  final String idAlamat;
  final String? idPembeli;
  final String? idOrganisasi;
  final String deskripsiAlamat;

  Alamat({
    required this.idAlamat,
    this.idPembeli,
    this.idOrganisasi,
    required this.deskripsiAlamat,
  });

  factory Alamat.fromJson(Map<String, dynamic> json) {
    return Alamat(
      idAlamat: json['ID_ALAMAT'] as String,
      idPembeli: json['ID_PEMBELI'] as String?,
      idOrganisasi: json['ID_ORGANISASI'] as String?,
      deskripsiAlamat: json['DESKRIPSI_ALAMAT'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID_ALAMAT': idAlamat,
      'ID_PEMBELI': idPembeli,
      'ID_ORGANISASI': idOrganisasi,
      'DESKRIPSI_ALAMAT': deskripsiAlamat,
    };
  }

  Alamat copyWith({
    String? idAlamat,
    String? idPembeli,
    String? idOrganisasi,
    String? deskripsiAlamat,
  }) {
    return Alamat(
      idAlamat: idAlamat ?? this.idAlamat,
      idPembeli: idPembeli ?? this.idPembeli,
      idOrganisasi: idOrganisasi ?? this.idOrganisasi,
      deskripsiAlamat: deskripsiAlamat ?? this.deskripsiAlamat,
    );
  }
}
