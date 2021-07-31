part of 'helper.dart';

class PesananLocalTable {
  static final _tableName = 'pesanan';

  static final _columnId = 'id';
  static final _columnNoPesanan = 'no_pesanan';
  static final _columnPelangganId = 'pelanggan_id';
  static final _columnNamaPelanggan = 'nama_pelanggan';
  static final _columnNoTelpPelanggan = 'no_telp_pelanggan';
  static final _columnFotoPelanggan = 'foto_pelanggan';
  static final _columnTglPemesanan = 'tgl_pemesanan';
  static final _columnTglPengiriman = 'tgl_pengiriman';
  static final _columnAlamatPengiriman = 'alamat_pengiriman';
  static final _columnStatus = 'status';
  static final _columnQty = 'qty';
  static final _columnTotalBayar = 'total_bayar';
  static final _columnBiayaAntar = 'biaya_antar';

  void _onCreateTablePesanan(Batch batch) async {
    batch.execute('''
      Create Table $_tableName (
        $_columnId Integer Primary Key,
        $_columnNoPesanan Text,
        $_columnPelangganId Integer,
        $_columnNamaPelanggan Text,
        $_columnNoTelpPelanggan Text,
        $_columnFotoPelanggan Text,
        $_columnTglPemesanan Text,
        $_columnTglPengiriman Text,
        $_columnAlamatPengiriman Text,
        $_columnStatus Integer,
        $_columnQty Integer,
        $_columnTotalBayar Integer,
        $_columnBiayaAntar Integer
      )
    ''');
  }

  Future<List<Pesanan>> select() async {
    DbHelper helper = DbHelper();
    Database db = await helper.database;

    var mapList = await db.query(_tableName);
    List<Pesanan> listPesanan = <Pesanan>[];
    mapList.forEach((element) {
      listPesanan.add(Pesanan.parsing(element));
    });

    return listPesanan;
  }

  Future<int> insert(Pesanan pesanan) async {
    DbHelper helper = DbHelper();
    Database db = await helper.database;
    int count = await db.insert(_tableName, pesanan.toMap());

    return count;
  }

  Future<int> delete() async {
    DbHelper helper = DbHelper();
    Database db = await helper.database;
    int count = await db.delete(_tableName);

    return count;
  }
}
