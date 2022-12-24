import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:rent_app/widgets/sign_in.dart';
import 'package:rent_app/Classes/user.dart';
import 'package:rent_app/DAO/userdao.dart';
import 'databasebuilder.dart';

import 'database.dart';

late final database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  runApp(
    MaterialApp(
      home: SignIn(),
    ),
  );
}
