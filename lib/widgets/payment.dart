import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Classes/adclass.dart';
import '../Classes/bookingclass.dart';
import '../main.dart';
import 'adviewer.dart';

class payment extends StatefulWidget {
  final int id,booked_number;
  final Book tmp;
  const payment(this.id,this.booked_number,this.tmp,{Key? key}) : super(key: key);

  @override
  State<payment> createState() => _paymentState();
}

class _paymentState extends State<payment> {
  TextEditingController dateInput = TextEditingController();
  String fname = '',lname = '',cardnumber = '',expiredate = '';



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
                  "Add payment method",
                  style: TextStyle(fontSize: 30, color: Color(0xFF363f93)),
                ),

                SizedBox(
                  height: height * 0.05,
                ),
                TextFormField(
                  onChanged: (value) {
                    fname = value;
                  },
                  decoration: InputDecoration(labelText: "First name"),
                ),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      lname = value;
                    });
                  },
                  decoration: InputDecoration(labelText: "Last name"),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  maxLines: null,
                  onChanged: (value) {
                    cardnumber = value;
                  },
                  decoration: InputDecoration(labelText: "Card number"),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
              TextField(
                controller: dateInput,
                //editing controller of this TextField
                decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Enter Date" //label text of field
                ),
                readOnly: true,
                //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2100));

                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                    DateFormat('yyyy-MM').format(pickedDate);
                    print(
                        formattedDate); //formatted date output using intl package =>  2021-03-16
                    setState(() {
                      dateInput.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {}
                },
              ),
                SizedBox(
                  height: height * 0.05,
                ),
              ],
            ),
          ),
        ),
      ) ,
      bottomNavigationBar: Material(
        borderRadius: BorderRadius.circular(18.0),
        color: Colors.black54,
        child: InkWell(
          onTap: () async {
            int tmp = number_rooms - widget.booked_number;
            final bookDao = database.bookDao;
            await bookDao.insertBook(widget.tmp);
            await adDao.updateAd(widget.id,photo_link,description,title,tmp,price,type,location,phone_number);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => adViewer(widget.id)),
            );
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Room booked successfully")));

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
