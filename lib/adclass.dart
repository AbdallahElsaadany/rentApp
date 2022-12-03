import 'package:floor/floor.dart';

@Entity(tableName: 'ads')
class Ads{
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String link,desc,type,title;
  Ads( {this.id,required this.link, required this.desc, required this.type,required this.title});
}