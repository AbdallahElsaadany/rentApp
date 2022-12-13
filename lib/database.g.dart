// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UserDao? _userDaoInstance;

  AdDao? _adDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `users` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `fName` TEXT NOT NULL, `lName` TEXT NOT NULL, `eMail` TEXT NOT NULL, `password` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ads` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `user_id` INTEGER NOT NULL, `price` INTEGER NOT NULL, `quantity` INTEGER NOT NULL, `link` TEXT NOT NULL, `desc` TEXT NOT NULL, `title` TEXT NOT NULL, `type` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }

  @override
  AdDao get adDao {
    return _adDaoInstance ??= _$AdDao(database, changeListener);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _userInsertionAdapter = InsertionAdapter(
            database,
            'users',
            (User item) => <String, Object?>{
                  'id': item.id,
                  'fName': item.fName,
                  'lName': item.lName,
                  'eMail': item.eMail,
                  'password': item.password
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<User> _userInsertionAdapter;

  @override
  Future<List<User>> findAllUsers() async {
    return _queryAdapter.queryList('SELECT * FROM users',
        mapper: (Map<String, Object?> row) => User(
            id: row['id'] as int?,
            fName: row['fName'] as String,
            lName: row['lName'] as String,
            eMail: row['eMail'] as String,
            password: row['password'] as String));
  }

  @override
  Stream<User?> findUserByEmail(String eMail) {
    return _queryAdapter.queryStream('SELECT * FROM users WHERE eMail = ?1',
        mapper: (Map<String, Object?> row) => User(
            id: row['id'] as int?,
            fName: row['fName'] as String,
            lName: row['lName'] as String,
            eMail: row['eMail'] as String,
            password: row['password'] as String),
        arguments: [eMail],
        queryableName: 'users',
        isView: false);
  }

  @override
  Future<void> insertUser(User user) async {
    await _userInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }
}

class _$AdDao extends AdDao {
  _$AdDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _adsInsertionAdapter = InsertionAdapter(
            database,
            'ads',
            (Ads item) => <String, Object?>{
                  'id': item.id,
                  'user_id': item.user_id,
                  'price': item.price,
                  'quantity': item.quantity,
                  'link': item.link,
                  'desc': item.desc,
                  'title': item.title,
                  'type': item.type
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Ads> _adsInsertionAdapter;

  @override
  Future<List<Ads>> findAllAds() async {
    return _queryAdapter.queryList('SELECT * FROM ads',
        mapper: (Map<String, Object?> row) => Ads(
            id: row['id'] as int?,
            user_id: row['user_id'] as int,
            link: row['link'] as String,
            desc: row['desc'] as String,
            title: row['title'] as String,
            price: row['price'] as int,
            quantity: row['quantity'] as int,
            type: row['type'] as String));
  }

  @override
  Future<List<Ads>> findAdByTitle(String title) async {
    return _queryAdapter.queryList('SELECT * FROM ads WHERE title = ?1',
        mapper: (Map<String, Object?> row) => Ads(
            id: row['id'] as int?,
            user_id: row['user_id'] as int,
            link: row['link'] as String,
            desc: row['desc'] as String,
            title: row['title'] as String,
            price: row['price'] as int,
            quantity: row['quantity'] as int,
            type: row['type'] as String),
        arguments: [title]);
  }

  @override
  Future<List<Ads?>> findAdByUserId(int id) async {
    return _queryAdapter.queryList('SELECT * FROM ads WHERE user_id = ?1',
        mapper: (Map<String, Object?> row) => Ads(
            id: row['id'] as int?,
            user_id: row['user_id'] as int,
            link: row['link'] as String,
            desc: row['desc'] as String,
            title: row['title'] as String,
            price: row['price'] as int,
            quantity: row['quantity'] as int,
            type: row['type'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertAd(Ads ad) async {
    await _adsInsertionAdapter.insert(ad, OnConflictStrategy.abort);
  }
}
