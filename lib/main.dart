import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final formKey = GlobalKey<FormState>(); //key for form
  String name="";
  @override
  Widget build(BuildContext context) {
    final double height= MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return  Scaffold(
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
            child :SingleChildScrollView(
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Registration", style: TextStyle(fontSize: 30, color:Color(0xFF363f93)),),
                  SizedBox(height: height*0.05,),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "First name"
                    ),
                    validator: (value){
                      if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)){
                        return "Enter correct name!";
                      }else{
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: height*0.05,),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Last name"
                    ),
                    validator: (value){
                      if (value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)){
                        return "Enter correct name!";
                      }else{
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: height*0.05,),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "E-Mail"
                    ),
                    validator: (value){
                      if (value!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)){
                        return "Enter correct E-Mail";
                      }else{
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: height*0.05,),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "password"
                    ),
                    validator: (value){
                      if (value!.isEmpty || !RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$').hasMatch(value!)){
                        return "A password eight characters, at least one letter and one number";
                      }else{
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: height*0.05,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Sign up",style: TextStyle(fontSize: 22,color: Color(0xFF363f93)),),
                      NeumorphicButton(
                        margin: const EdgeInsets.only(top: 12),
                        onPressed: (){
                          if(formKey.currentState !.validate()){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sign up success")));
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sign up failed")));
                          }
                        },
                        style: NeumorphicStyle(
                            shape: NeumorphicShape.convex,
                            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(200)),
                            depth: 8,
                            intensity: 1,
                            lightSource: LightSource.topLeft,
                            color: Color(0xFF363f93)
                        ),

                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}