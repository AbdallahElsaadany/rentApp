import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:rent_app/sign_in.dart';
import 'package:rent_app/user.dart';
import 'package:rent_app/userdao.dart';
import 'databasebuilder.dart';

import 'database.dart';

late final database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget{
  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  Future<void> addUsers(AppDatabase db) async {
    User firstUser = User(fName: "fName", lName: "lName", eMail: "eMail@ww.co", password: "1111aaaa");
    return await db.userDao.insertUser(firstUser);
  }

  late AppDatabase database;
  @override
  void initState() {
    super.initState();
    $FloorAppDatabase.databaseBuilder('app_database.db').build().then((value) async {
      this.database = value;
      setState(() {});
    });
}
  Future<List<User>> retrieveUsers() async {
    return await this.database.userDao.findAllUsers();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: FutureBuilder(
        future: this.retrieveUsers(),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(Icons.delete_forever),
                  ),

                  key: ValueKey<int>(snapshot.data![index].id!),
                  onDismissed: (DismissDirection direction) async {
                    setState(() {
                      snapshot.data!.remove(snapshot.data![index]);
                    });
                  },
                  child: Card(
                      child: ListTile(
                        contentPadding: EdgeInsets.all(8.0),
                        title: Text(snapshot.data![index].fName),
                        subtitle: Text(snapshot.data![index].eMail.toString()),
                      )),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignIn()),
          );
        },
        backgroundColor: Color(0xFF363f93),
        child: const Icon(Icons.add),
      ),
    );
  }
}

