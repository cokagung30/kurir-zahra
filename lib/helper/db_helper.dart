part of 'helper.dart';

class DbHelper {
  static DbHelper? _dbHelper;
  static Database? _database;

  static final String _dbName = 'kurir_zahra.db';

  static final _dbVersion1 = 1;
  static final _dbVersion2 = 2;

  UserLocalTable userLocalTable = UserLocalTable();
  PesananLocalTable pesananLocalTable = PesananLocalTable();
  DetailPesananLocalTable detailPesananLocalTable = DetailPesananLocalTable();

  DbHelper._createObject();

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }

    return _dbHelper!;
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + _dbName;

    return await openDatabase(path, version: _dbVersion2,
        onCreate: (db, version) async {
      var batch = db.batch();

      userLocalTable._onCreateUserTable(batch);
      pesananLocalTable._onCreateTablePesanan(batch);
      detailPesananLocalTable._onCreateTableDetailPesanan(batch);

      await batch.commit();
    }, onUpgrade: (db, oldVersion, newVersion) async {
      var batch = db.batch();
      if (oldVersion == _dbVersion1) {
        pesananLocalTable._onCreateTablePesanan(batch);
        detailPesananLocalTable._onCreateTableDetailPesanan(batch);
      }

      await batch.commit();
    });
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database!;
  }
}
