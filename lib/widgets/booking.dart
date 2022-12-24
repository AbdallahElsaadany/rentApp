import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart'as DateRangePicker;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../main.dart';
class booking_page extends StatefulWidget {
  final int id;
  const booking_page(this.id,{Key? key}) : super(key: key);
  @override
  State<booking_page> createState() => _booking_pageState();
}

class _booking_pageState extends State<booking_page> {
  List<int> numbers = [];
  int dropdownvalue = 0;
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
    for (var i = 1; i <= number_rooms; i++) {
      numbers.add(i);
    }
    phone_number = result?.phone_number;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Booking"),
        elevation: 1,
      ),

      backgroundColor: Color(0xffdfe6e9),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20,top: 10),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MaterialButton(
                  color: Colors.deepOrangeAccent,
                  onPressed: () async {

                  },
                  child: new Text("Pick date range")
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Material(
        borderRadius: BorderRadius.circular(18.0),
        color: Colors.black54,
        child: InkWell(
          onTap: () {

          },
          child: const SizedBox(
            height: kToolbarHeight,
            width: double.infinity,
            child: Center(
              child: Text(
                'Pay',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
  // TODO: implement your code here
}