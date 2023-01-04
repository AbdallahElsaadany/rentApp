import 'dart:async';
import 'package:floor/floor.dart';
import 'package:rent_app/Classes/bookingclass.dart';
import 'package:rent_app/Classes/favoriteads.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'Classes/customer.dart';
import 'Classes/adclass.dart';
import 'Classes/creaditcardclass.dart';
import 'Classes/customersupportclass.dart';
import 'DAO/addao.dart';
import 'DAO/bookdao.dart';
import 'DAO/creaditcarddao.dart';
import 'DAO/customerdao.dart';
import 'DAO/customersupportdao.dart';
import 'DAO/favoritedao.dart';
import 'DAO/userdao.dart';
import 'Classes/user.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [User,Ads,Book,Favorite,Customer,CreaditCard,CustomerSupportClass])
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;
  AdDao get adDao;
  BookDao get bookDao;
  FavoriteDao get favoritDao;
  CreaditCardDao get creaditCardDao;
  CustomerDao get customerDao;
  CustomerSupportDao get customerSupportDao;
}