import 'package:flutter/material.dart';
import 'package:floor/floor.dart';
import '../Classes/user.dart';

@dao
abstract class CustomerDao{
  @Query('SELECT * FROM Customer')
  Future<List<User>> findAllUsers();

  @Query('SELECT * FROM Customer WHERE eMail = :eMail')
  Stream<User?> findUserByEmail(String eMail);

  @insert
  Future<void> insertUser(User user);
}