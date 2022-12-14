import 'package:floor/floor.dart';
import 'package:rent_app/Classes/user.dart';
import 'adclass.dart';

@Entity(
  tableName: 'book',
  foreignKeys: [
    ForeignKey(
      childColumns: ['Ad_id'],
      parentColumns: ['id'],
      entity: Ads,
    ),
    ForeignKey(
      childColumns: ['customer_id'],
      parentColumns: ['id'],
      entity: User,
    )
  ],
)
class Book{
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String start_date, end_date;
  final double price;
  @ColumnInfo(name: 'customer_id')
  final int user_id;
  @ColumnInfo(name: 'Ad_id')
  final int ad_id;
  Book({this.id,required this.start_date,required this.end_date, required this.user_id, required this.ad_id,required this.price});
}