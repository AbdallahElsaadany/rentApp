import 'package:flutter/material.dart';
import 'package:floor/floor.dart';
import '../Classes/creaditcardclass.dart';

@dao
abstract class CreaditCardDao{
  @Query('SELECT * FROM Customer')
  Future<List<CreaditCard>> findAllUsers();

  @insert
  Future<void> insertUser(CreaditCard user);
}