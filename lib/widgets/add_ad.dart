import 'package:flutter/material.dart';
import 'package:rent_app/widgets/sign_up.dart';
import '../Classes/adclass.dart';
import '../widgets/ads_homepage.dart';
import '../main.dart';
import '../user_data.dart';
class addAds extends StatefulWidget {
  const addAds({Key? key}) : super(key: key);

  @override
  State<addAds> createState() => _addAdsState();
}

class _addAdsState extends State<addAds> {

  String description = '', photo_link = '',title = '',location = '';
  int price = 0;
  List<String> room_types = [
    'Single',
    'Double'
  ];
  String dropdownvalue = 'Single';
  int number_rooms = 0;

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
                TextFormField(
                  keyboardType: TextInputType.number,
                  maxLines: null,
                  onChanged: (value) {
                    var tmp = value;
                    number_rooms = int.parse(tmp);
                  },
                  decoration: InputDecoration(labelText: "Number of rooms"),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Room type",style: TextStyle(fontSize: 22,color: Color(0xFF363f93)),),
                    DropdownButton(

                      // Initial Value
                      value: dropdownvalue,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: room_types.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ],
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
          Ads tmp = Ads(title: title,link:photo_link,desc: description,user_id: userID ,price: price,type: dropdownvalue,quantity: number_rooms);
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
