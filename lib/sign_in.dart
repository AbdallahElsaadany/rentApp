import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:rent_app/sign_up.dart';
class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  final formKey = GlobalKey<FormState>(); //key for form
  String eMail='',password='';
  Widget build(BuildContext context) {
    final double height= MediaQuery.of(context).size.height;
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign In",
                      style: TextStyle(fontSize: 30, color: Color(0xFF363f93)),
                    ),
                    SizedBox(height: height*0.05,),
                    TextFormField(
                      onChanged: (value) {
                        eMail = value;
                      },
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
                      onChanged: (value) {
                        password = value;
                      },
                      obscureText: true,
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUp()),
                            );
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
              )
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUp()),
          );
        },
        backgroundColor: Color(0xFF363f93),
        child: const Icon(Icons.add),
      ),
    );
  }
}
