import 'dart:async';
import 'package:floor/floor.dart';
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