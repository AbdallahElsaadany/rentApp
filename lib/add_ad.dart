import 'package:flutter/material.dart';
import 'package:rent_app/sign_up.dart';
class addAds extends StatefulWidget {
  const addAds({Key? key}) : super(key: key);

  @override
  State<addAds> createState() => _addAdsState();
}

class _addAdsState extends State<addAds> {

  String description = '', photo_link = '', type = '',title = '';


  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
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
                  "Add Ads",
                  style: TextStyle(fontSize: 30, color: Color(0xFF363f93)),
                ),

                SizedBox(
                  height: height * 0.05,
                ),
                TextFormField(
                  onChanged: (value) {
                    title = value;
                  },
                  decoration: InputDecoration(labelText: "Title"),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      photo_link = value;
                    });
                  },
                  decoration: InputDecoration(labelText: "Photo link "),
                ),
                if (photo_link != '')
                Image.network(photo_link,width: 200,height: 100,
                loadingBuilder: (context,child,progress){
                  return progress == null ? child : LinearProgressIndicator();
                },),
                SizedBox(
                  height: height * 0.05,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  onChanged: (value) {
                    description = value;
                  },
                  decoration: InputDecoration(labelText: "Description"),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                SizedBox(
                  height: height * 0.05,
                ),
              ],
            ),
          ),
        ),
      ) ,
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
