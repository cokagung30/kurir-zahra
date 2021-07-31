part of 'models.dart';

class Pesanan extends Equatable {
  final int id;
  final String noPesanan;
  final int pelangganId;
  final String namaPelanggan;
  final String noTelpPelanggan;
  final String? fotoPelanggan;
  final String tglPemesanan;
  final String? tglPengiriman;
  final String alamatPengiriman;
  final int status;
  final int qty;
  final int totalBayar;
  final int biayaAntar;

  Pesanan({
    required this.id,
    required this.noPesanan,
    required this.pelangganId,
    required this.namaPelanggan,
    required this.noTelpPelanggan,
    this.fotoPelanggan,
    required this.tglPemesanan,
    this.tglPengiriman,
    required this.alamatPengiriman,
    required this.status,
    required this.qty,
    required this.totalBayar,
    required this.biayaAntar,
  });

  @override
  List<Object?> get props => [
        id,
        noPesanan,
        pelangganId,
        namaPelanggan,
        noTelpPelanggan,
        fotoPelanggan,
        tglPemesanan,
        tglPengiriman,
        alamatPengiriman,
        status,
        qty,
        totalBayar,
        biayaAntar
      ];

  factory Pesanan.parsing(Map<String, dynamic> data) => Pesanan(
      id: data['id'],
      noPesanan: data['no_pesanan'],
      pelangganId: data['pelanggan_id'],
      namaPelanggan: data['nama_pelanggan'],
      noTelpPelanggan: data['no_telp_pelanggan'],
      fotoPelanggan: data['foto_pelanggan'],
      tglPemesanan: data['tgl_pemesanan'],
      tglPengiriman: data['tgl_pengiriman'],
      alamatPengiriman: data['alamat_pengiriman'],
      status: data['status'],
      qty: data['qty'],
      totalBayar: data['total_bayar'],
      biayaAntar: data['biaya_antar']);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();

    map['id'] = this.id;
    map['no_pesanan'] = this.noPesanan;
    map['pelanggan_id'] = this.pelangganId;
    map['nama_pelanggan'] = this.namaPelanggan;
    map['no_telp_pelanggan'] = this.noTelpPelanggan;
    map['foto_pelanggan'] = this.fotoPelanggan;
    map['tgl_pemesanan'] = this.tglPemesanan;
    map['tgl_pengiriman'] = this.tglPengiriman;
    map['alamat_pengiriman'] = this.alamatPengiriman;
    map['status'] = this.status;
    map['qty'] = this.qty;
    map['total_bayar'] = this.totalBayar;
    map['biaya_antar'] = this.biayaAntar;

    return map;
  }
}

List<Pesanan> mocksPesanan = [
  Pesanan(
      id: 1,
      noPesanan: 'ZOS001',
      pelangganId: 1,
      namaPelanggan: 'Agus Gita Pramudya',
      noTelpPelanggan: '087853367213',
      tglPemesanan: '2021-07-23',
      alamatPengiriman: 'Jl. Dimana mana bisa',
      status: 4,
      qty: 6,
      totalBayar: 200000,
      biayaAntar: 20000),
  Pesanan(
      id: 1,
      noPesanan: 'ZOS002',
      pelangganId: 1,
      namaPelanggan: 'Agus Gita Pramudya',
      noTelpPelanggan: '087853367213',
      tglPemesanan: '2021-07-23',
      alamatPengiriman: 'Jl. Dimana mana bisa',
      status: 5,
      qty: 5,
      totalBayar: 200000,
      biayaAntar: 20000),
];
