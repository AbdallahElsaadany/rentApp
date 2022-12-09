import 'package:flutter/material.dart';

import 'package:rent_app/Classes/adclass.dart';
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
  Future<List<Ads>> retrieveAds() async {
    return await database.adDao.findAllAds();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ads'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color(0xffdfe6e9),
      body: FutureBuilder(
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
                      child: ListTile(
                        contentPadding: EdgeInsets.all(8.0),
                        title: Text(snapshot.data![index].title),
                        subtitle: Text(snapshot.data![index].desc),
                        trailing: Image.network(snapshot.data![index].link,width: 200,height: 100,
                          loadingBuilder: (context,child,progress){
                            return progress == null ? child : LinearProgressIndicator();
                          },),
                      )),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => addAds()),
          );
        },
        backgroundColor: Color(0xFF363f93),
        child: const Icon(Icons.add),
      ),
    );
  }
}
