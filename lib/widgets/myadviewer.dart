import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Classes/adclass.dart';
import '../main.dart';
import '../user_data.dart';
import 'ads_homepage.dart';
import 'editad.dart';
class myAdViewer extends StatefulWidget {
  final int id;
  const myAdViewer(this.id,{Key? key}) : super(key: key);
  @override
  State<myAdViewer> createState() => _myAdViewerState();
}

class _myAdViewerState extends State<myAdViewer> {
  String description = '', photo_link = '',title = '',location = '',type = 'Single';
  int price = 0 , number_rooms = 0,phone_number = 0;
  List<String> room_types = [
    'Single',
    'Double'
  ];

  late final adDao;
  @override
  void initState() {
    adDao = database.adDao;
    getAd();
    super.initState();
  }

  getAd() async{
    var result = await adDao.findAdById(widget.id).first;
    description = result?.desc;
    photo_link = result?.link;
    title = result?.title;
    location =result?.location;
    type = result?.type;
    price = result?.price;
    number_rooms = result?.number_of_rooms;
    phone_number = result?.phone_number;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Ads"),
        elevation: 1,
      ),
      backgroundColor: Color(0xffdfe6e9),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20,top: 10),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(title,style: TextStyle(fontSize: 30, color: Color(0xFF363f93))),
                ),
                if (photo_link != '')
                  Image.network(photo_link,width: MediaQuery.of(context).size.width,height: 300,
                    loadingBuilder: (context,child,progress){
                      return progress == null ? child : LinearProgressIndicator();
                    },
                  ),
                Text(price.toString()+' EGP',style: TextStyle(fontSize: 30, color: Color(0xFF363f93))),
                SizedBox(
                  height: height * 0.03,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text("Location:",style: TextStyle(fontSize: 22, color: Color(0xFF363f93))),
                      Text(location,style: TextStyle(fontSize: 22))
                    ]
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text("Type:",style: TextStyle(fontSize: 22, color: Color(0xFF363f93))),
                      Text(type,style: TextStyle(fontSize: 22))
                    ]
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text("Rooms:",style: TextStyle(fontSize: 22, color: Color(0xFF363f93))),
                      Text(number_rooms.toString(),style: TextStyle(fontSize: 22))
                    ]
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Text("Description : ",style: TextStyle(fontSize: 22, color: Color(0xFF363f93))),
                ListTile(
                  title: Text(description,style: TextStyle(fontSize: 18, color:Colors.black)),
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditPage(widget.id)),
          );
        },
        backgroundColor: Color(0xFF363f93),
        child: const Icon(Icons.edit),
      ),
    );
  }
}
