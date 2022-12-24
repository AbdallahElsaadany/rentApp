import 'package:flutter/material.dart';

import '../Classes/adclass.dart';
import '../main.dart';
import '../user_data.dart';
import 'ads_homepage.dart';
import 'adviewer.dart';
import 'myadviewer.dart';
class EditPage extends StatefulWidget {
  final int id;
  const EditPage(this.id,{Key? key}) : super(key: key);
  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  String description = '', photo_link = '',title = '',location = '',type = 'Single';
  int price = 0 , number_rooms = 0,phone_number = 0;
  List<String> room_types = [
    'Single',
    'Double'
  ];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController photo_linkController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController number_roomsController = TextEditingController();
  TextEditingController phone_numberController = TextEditingController();

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
    descriptionController.text = description;
    photo_link = result?.link;
    photo_linkController.text = photo_link;
    title = result?.title;
    titleController.text = title;
    location =result?.location;
    locationController.text = location;
    type = result?.type;
    typeController.text = type;
    price = result?.price;
    priceController.text = price.toString();
    number_rooms = result?.number_of_rooms;
    number_roomsController.text = number_rooms.toString();
    phone_number = result?.phone_number;
    phone_numberController.text = phone_number.toString();
    setState(() {});
  }

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
                  controller: titleController,
                  onChanged: (value) {
                    title = value;
                  },
                  decoration: InputDecoration(labelText: "Title"),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                TextFormField(
                  controller: locationController,
                  onChanged: (value) {
                    setState(() {
                      location = value;
                    });
                  },
                  decoration: InputDecoration(labelText: "location"),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                TextFormField(
                  controller: photo_linkController,
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
                  controller: descriptionController,
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
                  controller: priceController,
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
                  controller: phone_numberController,
                  keyboardType: TextInputType.number,
                  maxLines: null,
                  onChanged: (value) {
                    phone_number = int.parse(value);
                  },
                  decoration: InputDecoration(labelText: "Phone number"),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                TextFormField(
                  controller: number_roomsController,
                  keyboardType: TextInputType.number,
                  maxLines: null,
                  onChanged: (value) {
                    number_rooms = int.parse(value);
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
                      value: type,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: room_types.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          type = newValue!;
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
          await adDao.updateAd(widget.id,photo_link,description,title,number_rooms,price,type,location,phone_number);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("edit successfully")));
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => myAdViewer(widget.id)),
          );
        },
        backgroundColor: Color(0xFF363f93),
        child: const Icon(Icons.add),
      ),
    );
  }
}
