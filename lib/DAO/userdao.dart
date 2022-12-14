import 'package:flutter/material.dart';
import 'package:floor/floor.dart';
import '../Classes/user.dart';

@dao
abstract class UserDao{
  @Query('SELECT * FROM HouseOwner')
  Future<List<User>> findAllUsers();

  @Query('SELECT * FROM HouseOwner WHERE eMail = :eMail')
  Stream<User?> findUserByEmail(String eMail);

  @insert
  Future<void> insertUser(User user);
}