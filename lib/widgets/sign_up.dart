import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:rent_app/Classes/user.dart';
import 'package:rent_app/DAO/userdao.dart';

import 'package:rent_app/database.dart';
import 'package:rent_app/main.dart';
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>(); //key for form
  String fName = '', lName = '', eMail = '', password = '';
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color(0xffdfe6e9),
      body: Container(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Form(
          key: formKey, //key for form
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 30, color: Color(0xFF363f93)),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                TextFormField(
                  onChanged: (value) {
                    fName = value;
                  },
                  decoration: InputDecoration(labelText: "First name"),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
                      return "Enter correct name!";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                TextFormField(
                  onChanged: (value) {
                    lName = value;
                  },
                  decoration: InputDecoration(labelText: "Last name"),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
                      return "Enter correct name!";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                TextFormField(
                  onChanged: (value) {
                    eMail = value;
                  },
                  decoration: InputDecoration(labelText: "E-Mail"),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value!)) {
                      return "Enter correct E-Mail";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                TextFormField(
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(labelText: "password"),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$')
                            .hasMatch(value!)) {
                      return "A password eight characters, at least one letter and one number";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: height * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Add your onPressed code here!
          final userDao = database.userDao;
          User tmp = User(fName: fName, lName: lName, eMail: eMail, password: password);
          final result = await userDao.findUserByEmail(eMail).first;
          if(formKey.currentState !.validate() && result?.eMail==null){
            await userDao.insertUser(tmp);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sign up success")));
            Navigator.pop(context);
          }else{
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sign up failed")));
          }
        },
        backgroundColor: Color(0xFF363f93),
        child: const Icon(Icons.arrow_circle_right_rounded),
      ),
    );
  }
}
