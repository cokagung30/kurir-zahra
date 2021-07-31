part of 'helper.dart';

class UserLocalTable {
  static final _tableName = "user";

  static final _columnId = 'id';
  static final _columnNamaKurir = 'nama_kurir';
  static final _columnEmailKurir = 'email_kurir';
  static final _columnNoTelp = 'no_telp';
  static final _columnNoWa = 'no_wa';
  static final _columnAlamat = 'alamat';
  static final _columnToken = 'token';
  static final _columnFotoKurir = 'foto_kurir';

  void _onCreateUserTable(Batch batch) async {
    batch.execute(''' 
      Create Table $_tableName(
        $_columnId Integer Primary Key,
        $_columnNamaKurir Text,
        $_columnEmailKurir Text,
        $_columnNoTelp Text,
        $_columnNoWa Text,
        $_columnAlamat Text,
        $_columnToken Text,
        $_columnFotoKurir Text
      )
    ''');
  }

  Future<int> insert(User user) async {
    DbHelper helper = DbHelper();
    Database db = await helper.database;
    int count = await db.insert(_tableName, user.toMap());
    return count;
  }

  Future<int> update(User user) async {
    DbHelper helper = DbHelper();
    Database db = await helper.database;
    int count = await db.update(_tableName, user.toMap(),
        where: '$_columnId=?', whereArgs: [user.id]);

    return count;
  }

  Future<User?> getUser() async {
    DbHelper helper = DbHelper();
    Database db = await helper.database;
    var res = await db.rawQuery('Select * from $_tableName limit 1');

    if (res.length > 0) {
      return new User.parsing(res.first);
    }

    return null;
  }

  Future<int> delete() async {
    DbHelper helper = DbHelper();
    Database db = await helper.database;
    int count = await db.delete(_tableName);

    return count;
  }
}
