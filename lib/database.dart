import 'dart:async';
import 'package:floor/floor.dart';
import 'package:rent_app/Classes/bookingclass.dart';
import 'package:rent_app/Classes/favoriteads.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'Classes/adclass.dart';
import 'DAO/addao.dart';
import 'DAO/bookdao.dart';
import 'DAO/favoritedao.dart';
import 'DAO/userdao.dart';
import 'Classes/user.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [User,Ads,Book,Favorite])
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;
  AdDao get adDao;
  BookDao get bookDao;
  FavoriteDao get favoritDao;
}