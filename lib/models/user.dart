part of 'models.dart';

class User extends Equatable {
  final int? id;
  final String namaKurir;
  final String emailKurir;
  final String noTelp;
  final String noWa;
  final String? alamat;
  final String? token;
  final String? fotoKurir;

  User({
    this.id,
    required this.namaKurir,
    required this.emailKurir,
    required this.noTelp,
    required this.noWa,
    this.alamat,
    this.token,
    this.fotoKurir,
  });

  @override
  List<Object?> get props =>
      [id, namaKurir, emailKurir, noTelp, noWa, token, alamat];

  factory User.fromServer(Map<String, dynamic> data) => User(
        id: data['id'],
        namaKurir: data['nama_kurir'],
        emailKurir: data['email_kurir'],
        noTelp: data['no_telp'],
        noWa: data['no_wa'],
        alamat: data['alamat'],
        fotoKurir: data['foto_kurir'],
      );

  factory User.parsing(Map<String, dynamic> data) => User(
        id: data['id'],
        namaKurir: data['nama_kurir'],
        emailKurir: data['email_kurir'],
        noTelp: data['no_telp'],
        noWa: data['no_wa'],
        alamat: data['alamat'],
        token: data['token'],
        fotoKurir: data['foto_kurir'],
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this.id;
    map['nama_kurir'] = this.namaKurir;
    map['email_kurir'] = this.emailKurir;
    map['no_telp'] = this.noTelp;
    map['no_wa'] = this.noWa;
    map['alamat'] = this.alamat;
    map['token'] = this.token;
    map['foto_kurir'] = this.fotoKurir;
    return map;
  }
}
