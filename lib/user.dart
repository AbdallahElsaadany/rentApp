import 'package:flutter/material.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'users')
class User{
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String fName,lName,eMail,password;
  User( {this.id,required this.fName, required this.lName, required this.eMail, required this.password});
}