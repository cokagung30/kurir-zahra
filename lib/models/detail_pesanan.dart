part of 'models.dart';

class DetailPesanan {
  final int id;
  final int pesananId;
  final int produkId;
  final int quantity;
  final String namaProduk;
  final String fotoProduk;
  final String deskripsi;
  final int hargaJual;

  DetailPesanan({
    required this.id,
    required this.pesananId,
    required this.produkId,
    required this.quantity,
    required this.namaProduk,
    required this.fotoProduk,
    required this.deskripsi,
    required this.hargaJual,
  });

  factory DetailPesanan.parsing(Map<String, dynamic> data) => DetailPesanan(
      id: data['id'],
      pesananId: data['pesanan_id'],
      produkId: data['produk_id'],
      quantity: data['quantity'],
      namaProduk: data['nama_produk'],
      fotoProduk: data['foto_produk'],
      deskripsi: data['deskripsi'],
      hargaJual: data['harga_jual']);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this.id;
    map['pesanan_id'] = this.pesananId;
    map['produk_id'] = this.produkId;
    map['quantity'] = this.quantity;
    map['nama_produk'] = this.namaProduk;
    map['foto_produk'] = this.fotoProduk;
    map['deskripsi'] = this.deskripsi;
    map['harga_jual'] = this.hargaJual;

    return map;
  }
}
