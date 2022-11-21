// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:rent_app/sign_up.dart';
// import 'package:floor/floor.dart';
// import 'package:rent_app/user.dart';
// import 'package:rent_app/userdao.dart';
//
// import 'database.dart';
// class DisplayDatabase extends StatefulWidget {
//   @override
//   State<DisplayDatabase> createState() => _DisplayDatabaseState();
// }
//
// class _DisplayDatabaseState extends State<DisplayDatabase> {
//   late AppDatabase database;
//   Future<Future<List<User>> Function()?> retrieveUsers() async {
//     UserDao? userDao;
//     return await userDao?.findAllUsers;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('data'),
//       ),
//       body: FutureBuilder(
//         future: this.retrieveUsers(), builder: (BuildContext context, AsyncSnapshot<Future<List<User>> Function()?> snapshot) {
//
//         },
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//
//     super.initState();
//     $FloorAppDatabase.databaseBuilder('app_database.db').build().then((value) async {
//       this.database = value;
//       setState(() {});
//     });
//   }
// }
//
