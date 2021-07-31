part of 'helper.dart';

class DetailPesananLocalTable {
  static final _tableName = 'detail_pesanan';

  static final _columnId = 'id';
  static final _columnPesananId = 'pesanan_id';
  static final _columnProdukId = 'produk_id';
  static final _columnQuantity = 'quantity';
  static final _columnNamaProduk = 'nama_produk';
  static final _columnFotoProduk = 'foto_produk';
  static final _columnDeskripsi = 'deskripsi';
  static final _columnHargaJual = 'harga_jual';

  void _onCreateTableDetailPesanan(Batch batch) async {
    batch.execute('''
      Create Table $_tableName (
        $_columnId Integer Primary Key,
        $_columnPesananId Integer,
        $_columnProdukId Integer,
        $_columnQuantity Integer,
        $_columnNamaProduk Text,
        $_columnFotoProduk Text,
        $_columnDeskripsi Text,
        $_columnHargaJual Integer
      )
    ''');
  }

  Future<int> insert(DetailPesanan detailPesanan) async {
    DbHelper helper = DbHelper();
    Database db = await helper.database;
    int count = await db.insert(_tableName, detailPesanan.toMap());

    return count;
  }

  Future<List<DetailPesanan>> select(int pesananId) async {
    DbHelper helper = DbHelper();
    Database db = await helper.database;

    var mapList = await db.query(_tableName,
        where: '$_columnPesananId = ?', whereArgs: [pesananId]);

    List<DetailPesanan> detailList = <DetailPesanan>[];
    mapList.forEach((element) {
      detailList.add(DetailPesanan.parsing(element));
    });

    return detailList;
  }

  Future<int> delete() async {
    DbHelper helper = DbHelper();
    Database db = await helper.database;
    int count = await db.delete(_tableName);

    return count;
  }
}
