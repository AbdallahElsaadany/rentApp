import 'package:floor/floor.dart';

@Entity(tableName: 'ads')
class Ads{
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int user_id,price;
  final String link,desc,title;
  Ads({this.id,required this.user_id,required this.link, required this.desc, required this.title,required this.price});
  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}