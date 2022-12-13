import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:rent_app/Classes/adclass.dart';
import 'package:rent_app/user_data.dart';
import 'package:rent_app/widgets/add_ad.dart';
import 'package:rent_app/DAO/addao.dart';
import 'package:rent_app/database.dart';
import 'package:rent_app/main.dart';
class adsHomePage extends StatefulWidget {
  const adsHomePage({Key? key}) : super(key: key);

  @override
  State<adsHomePage> createState() => _adsHomePageState();
}

class _adsHomePageState extends State<adsHomePage> {
  int selectedTap = 0;
  String search = '';
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
                    icon: Icons.search,
                    text: 'Search',
                  ),
                  GButton(
                    icon: Icons.chat,
                    text: 'Profile',
                  )
                ]
            ),
          ),
        ),
      appBar: AppBar(
        title: Text('Ads'),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Icon(Icons.delete_forever),
                        ),

                        key: ValueKey<int>(snapshot.data![index].id!),
                        onDismissed: (DismissDirection direction) async {
                          setState(() {
                            snapshot.data!.remove(snapshot.data![index]);
                          });
                        },
                        child: Card(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(snapshot.data![index].title),
                                      Text(snapshot.data![index].desc)
                                    ],
                                  ),
                                  Image.network(snapshot.data![index].link,width: 200,height: 100,
                                    loadingBuilder: (context,child,progress){
                                      return progress == null ? child : LinearProgressIndicator();
                                    },)
                                ],
                              ),
                            )),
                      );
                    },
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
                      return Dismissible(
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Icon(Icons.delete_forever),
                        ),

                        key: ValueKey<int>(snapshot.data![index]!.id!),
                        onDismissed: (DismissDirection direction) async {
                          setState(() {
                            snapshot.data!.remove(snapshot.data![index]);
                          });
                        },
                        child: Card(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(snapshot.data![index]!.title),
                                      Text(snapshot.data![index]!.desc)
                                    ],
                                  ),
                                  Image.network(snapshot.data![index]!.link,width: 200,height: 100,
                                    loadingBuilder: (context,child,progress){
                                      return progress == null ? child : LinearProgressIndicator();
                                    },)
                                ],
                              ),
                            )),
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          )
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
