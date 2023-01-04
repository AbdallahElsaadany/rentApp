import 'package:flutter/material.dart';
import 'package:floor/floor.dart';
import '../Classes/creaditcardclass.dart';
import '../Classes/customersupportclass.dart';

@dao
abstract class CustomerSupportDao{
  @Query('SELECT * FROM customer_support')
  Future<List<CustomerSupportClass>> findAllUsers();

  @insert
  Future<void> insertUser(CustomerSupportClass user);
}