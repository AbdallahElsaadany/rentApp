import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'adclass.dart';
import 'addao.dart';
import 'userdao.dart';
import 'user.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [User,Ads])
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;
  AdDao get adDao;
}