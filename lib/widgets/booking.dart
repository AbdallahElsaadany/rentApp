import 'package:flutter/material.dart';
import 'package:rent_app/Classes/bookingclass.dart';
import 'package:rent_app/user_data.dart';
import 'package:rent_app/widgets/payment.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

import '../main.dart';
class booking_page extends StatefulWidget {
  final int id;
  final List<int> numbers;
  const booking_page(this.id,this.numbers,{Key? key}) : super(key: key);
  @override
  State<booking_page> createState() => _booking_pageState();
}

class _booking_pageState extends State<booking_page> {
  int dropdownvalue = 1;
  String description = '', photo_link = '',title = '',location = '',type = 'Single';
  int price = 0 , number_rooms = 0,phone_number = 0;
  List<String> room_types = [
    'Single',
    'Double'
  ];
  final now = new DateTime.now();
  late DateTime date;
  late DateTimeRange dateRange ;
  late final adDao;
  @override
  void initState() {
    adDao = database.adDao;
    date = DateTime(now.year, now.month, now.day);
    dateRange = DateTimeRange(start: date, end: DateTime(now.year, now.month+1, now.day));


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
              SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Room type",style: TextStyle(fontSize: 32,color: Color(0xFF363f93)),),
                    DropdownButton(

                      // Initial Value
                      value: dropdownvalue,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: widget.numbers.map((int items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items.toString()),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (int? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Text("pick the date range",style: TextStyle(fontSize: 32),),
              SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: ElevatedButton(
                      child: Text('${dateRange.start.year}/${dateRange.start.month}/${dateRange.start.day}'),
                      onPressed: pickDateRange,
                    )
                    ),
                    SizedBox(width: 12),
                    Expanded(child: ElevatedButton(
                      child: Text('${dateRange.end.year}/${dateRange.end.month}/${dateRange.end.day}'),
                      onPressed: pickDateRange,
                    )
                    )
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text("Days: ${dateRange.duration.inDays}",style: TextStyle(fontSize: 32),)
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 110,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Cost per day:",style: TextStyle(fontSize: 20),),
                  Text("${(price/30)}",style: TextStyle(fontSize: 18),)
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total:",style: TextStyle(fontSize: 30),),
                  Text("${(price/30) * dateRange.duration.inDays * dropdownvalue}",style: TextStyle(fontSize: 25),)
                ],
              ),
            ),
            Material(
              borderRadius: BorderRadius.circular(18.0),
              color: Colors.black54,
              child: InkWell(
                onTap: () {
                  var userID = loggedUser?.id?.toInt() ?? 0;
                  Book tmp = Book(start_date: dateRange.start.toString(),
                      end_date: dateRange.end.toString(),
                      user_id: userID,
                      ad_id: widget.id,
                      price: (price/30) * dateRange.duration.inDays * dropdownvalue);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => payment(widget.id,dropdownvalue,tmp)),
                  );
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
          ],
        ),
      )
    );
  }
  Future pickDateRange() async{
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        initialDateRange: dateRange,
        firstDate: date,
        lastDate: DateTime(2100)
    );
    if (DateTimeRange == null) return;
    setState(() => dateRange = newDateRange!);
  }
}


