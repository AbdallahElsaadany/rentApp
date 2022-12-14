import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rent_app/widgets/payment.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../Classes/adclass.dart';
import '../main.dart';
import '../user_data.dart';
import 'add_ad.dart';
import 'ads_homepage.dart';
import 'booking.dart';
class adViewer extends StatefulWidget {
  final int id;
  const adViewer(this.id,{Key? key}) : super(key: key);
  @override
  State<adViewer> createState() => _adViewerState();
}

class _adViewerState extends State<adViewer> {
  String description = '', photo_link = '',title = '',location = '',type = 'Single';
  int price = 0 , number_rooms = 0,phone_number = 0;
  List<String> room_types = [
    'Single',
    'Double'
  ];
  List<int> numbers = [];
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
    for (var i = 1; i <= number_rooms; i++) {
      numbers.add(i);
    }
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
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => addAds()),
                    );
                  },
                  // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                  style: ElevatedButton.styleFrom(
                      elevation: 12.0,
                      textStyle: const TextStyle(color: Colors.white)),
                  child: const Text('Book'),
                ),

              ],
            ),
          ),
        ),
      ) ,
      bottomNavigationBar: Material(

        borderRadius: BorderRadius.circular(18.0),
        color: Colors.black,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => booking_page(widget.id,numbers)),
            );
          },
          child: const SizedBox(
            height: kToolbarHeight,
            width: double.infinity,
            child: Center(
              child: Text(
                'Book',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton:
          FloatingActionButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text:'+20'+ phone_number.toString()));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Phone number has been copied")));
            },
            backgroundColor: Color(0xFF363f93),
            child: const Icon(Icons.phone),
          ),
    );
  }
}

