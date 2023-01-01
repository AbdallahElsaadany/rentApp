import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:rent_app/Classes/adclass.dart';
import 'package:rent_app/Classes/favoriteads.dart';
import 'package:rent_app/user_data.dart';
import 'package:rent_app/widgets/add_ad.dart';
import 'package:rent_app/DAO/addao.dart';
import 'package:rent_app/database.dart';
import 'package:rent_app/main.dart';
import 'package:rent_app/widgets/adviewer.dart';
import 'package:favorite_button/favorite_button.dart';

import 'editad.dart';
import 'myadviewer.dart';
class adsHomePage extends StatefulWidget {
  const adsHomePage({Key? key}) : super(key: key);
  @override
  State<adsHomePage> createState() => _adsHomePageState();
}

class _adsHomePageState extends State<adsHomePage> {
  int selectedTap = 0;
  String search = '';
  String? fname = loggedUser?.fName;
  String? lname = loggedUser?.lName;
  late String username = fname!+lname!;
  var userID = loggedUser?.id?.toInt() ?? 0;
  Future<List<Ads>> retrieveAds() async {
    return await database.adDao.findAllAds();
  }
  Future<List<Ads>> retrieveSearchAds(String search_word) async {
    return await database.adDao.findAdByTitle(search_word);
  }
  Future<List<Ads?>> retrieveMyAds(int id) async {
    return await database.adDao.findAdByUserId(id);
  }
  Future<List<Ads?>> retrieveMyFavAds(int id) async {
    return await await database.favoritDao.findFavAdByUserID(id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 1),
            child: GNav(
                backgroundColor: Colors.black,
                color: Colors.white,
                activeColor: Colors.white,
                tabBackgroundColor: Colors.grey.shade800,
                gap: 8, // the tab button gap between icon and text
                onTabChange: (index){
                  setState(() {
                    selectedTap = index;
                  });
                },
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.my_library_books,
                    text: 'My Ads',

                  ),
                  GButton(
                    icon: Icons.favorite,
                    text: 'Search',
                  ),
                  GButton(
                    icon: Icons.person,
                    text: 'Profile',
                  )
                ]
            ),
          ),
        ),
      backgroundColor: Color(0xffdfe6e9),
      body: Stack(
        children: [
          Offstage(
            offstage: selectedTap != 0,
            child: FutureBuilder(
              future: retrieveAds(),
              builder: (BuildContext context, AsyncSnapshot<List<Ads>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    padding: const EdgeInsets.only(left: 10,right: 10,top: 60),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => adViewer(snapshot.data![index]!.id!)),
                          ),
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white10,
                                  blurRadius: 4,
                                  offset: Offset(4, 8), // Shadow position
                                ),
                              ],
                            ),
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Colors.transparent,
                                elevation: 10,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text("\n" +snapshot.data![index].title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                                          FavoriteButton(
                                            valueChanged: (_isFavorite) async {
                                              if(_isFavorite){
                                                var userID = loggedUser?.id?.toInt() ?? 0;
                                                Favorite fav = Favorite(user_id: userID,ad_id: snapshot.data![index]!.id!);
                                                await database.favoritDao.insertAd(fav);
                                              }else{
                                                var result = await database.favoritDao.findAdById(snapshot.data![index]!.id!).first;
                                                await database.favoritDao.deleteFavAd(result);
                                              }
                                            },
                                          )
                                        ],
                                      ),
                                      Image.network(snapshot.data![index].link,width: 200,height: 100,
                                        loadingBuilder: (context,child,progress){
                                          return progress == null ? child : LinearProgressIndicator();
                                        },
                                      )
                                    ],
                                  ),
                                )
                            ),
                          ),
                        );
                    }, separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  )

                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Offstage(offstage: selectedTap != 1,
            child: FutureBuilder(
              future: retrieveMyAds(userID),
              builder: (BuildContext context, AsyncSnapshot<List<Ads?>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => myAdViewer(snapshot.data![index]!.id!)),
                          ),
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.grey,
                              elevation: 10,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text("      " +snapshot.data![index]!.title, style: TextStyle(fontSize: 22)),
                                      ],
                                    ),
                                    Image.network(snapshot.data![index]!.link,width: 200,height: 100,
                                      loadingBuilder: (context,child,progress){
                                        return progress == null ? child : LinearProgressIndicator();
                                      },
                                    )
                                  ],
                                ),
                              )
                          ),
                        );

                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Offstage(offstage: selectedTap != 2,
            child: FutureBuilder(
              future: retrieveMyFavAds(userID),
              builder: (BuildContext context, AsyncSnapshot<List<Ads?>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => myAdViewer(snapshot.data![index]!.id!)),
                        ),
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Colors.grey,
                            elevation: 10,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text("      " +snapshot.data![index]!.title, style: TextStyle(fontSize: 22)),
                                    ],
                                  ),
                                  Image.network(snapshot.data![index]!.link,width: 200,height: 100,
                                    loadingBuilder: (context,child,progress){
                                      return progress == null ? child : LinearProgressIndicator();
                                    },
                                  )
                                ],
                              ),
                            )
                        ),
                      );

                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Offstage(offstage: selectedTap != 3,
            child: Scaffold(
              body: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 450,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            textfield(
                              hintText: username,
                            ),
                            textfield(
                              hintText: loggedUser?.eMail,
                            ),
                            Material(
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
                                      'History',
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
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "Profile",
                          style: TextStyle(
                            fontSize: 35,
                            letterSpacing: 1.5,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),

                        child: Icon(
                          Icons.person,
                          size: 150,
                        ),

                      ),

                    ],
                  ),

                ],
              ),
            )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => addAds()),
          );
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }
}

Widget textfield({@required hintText}) {
  return Material(
    elevation: 4,
    shadowColor: Colors.grey,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextField(
      decoration: InputDecoration(
          hintText: hintText,
          enabled: false,
          hintStyle: TextStyle(
            letterSpacing: 2,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
          fillColor: Colors.white30,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none)),
    ),
  );
}
