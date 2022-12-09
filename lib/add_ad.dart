import 'package:flutter/material.dart';
import 'package:rent_app/sign_up.dart';
import 'adclass.dart';
import 'ads_homepage.dart';
import 'main.dart';
import 'user_data.dart';
class addAds extends StatefulWidget {
  const addAds({Key? key}) : super(key: key);

  @override
  State<addAds> createState() => _addAdsState();
}

class _addAdsState extends State<addAds> {

  String description = '', photo_link = '',title = '';
  int price = 0;

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
                TextFormField(
                  keyboardType: TextInputType.number,
                  maxLines: null,
                  onChanged: (value) {
                    var tmp = value;
                    price = int.parse(tmp);
                  },
                  decoration: InputDecoration(labelText: "Price"),
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
        onPressed: () async {
          // Add your onPressed code here!
          var userID = loggedUser?.id?.toInt() ?? 0;
          Ads tmp = Ads(title: title,link:photo_link,desc: description,user_id: userID,price: price);
          print(tmp.link);
          final adDao = database.adDao;
          await adDao.insertAd(tmp);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("added successfully")));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => adsHomePage()),
          );
        },
        backgroundColor: Color(0xFF363f93),
        child: const Icon(Icons.add),
      ),
    );
  }
}
