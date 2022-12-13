import 'package:floor/floor.dart';

@Entity(tableName: 'Booking')
class Ads{
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final DateTime start_date, end_date;
  final int user_id,ad_id;
  Ads({this.id,required this.start_date,required this.end_date, required this.user_id, required this.ad_id});
}