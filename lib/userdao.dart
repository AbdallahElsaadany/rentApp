import 'package:flutter/material.dart';
import 'package:floor/floor.dart';
import 'user.dart';

@dao
abstract class UserDao{
  @Query('SELECT * FROM users')
  Future<List<User>> findAllUsers();

  @Query('SELECT * FROM users WHERE id = :id')
  Stream<User?> findUserById(int id);

  @Query('SELECT * FROM users WHERE eMail = :eMail')
  Stream<User?> findUserByEmail(String eMail);

  @insert
  Future<void> insertUser(User user);
}