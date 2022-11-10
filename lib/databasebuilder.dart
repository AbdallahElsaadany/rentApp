import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'database.dart';

class database_builder{
   late final database;


   database_builder();

   _init() async {
     await $FloorAppDatabase.databaseBuilder('app_database.db').build();
   }
   addUser() async {
     await _init();

     // database.
   }

}