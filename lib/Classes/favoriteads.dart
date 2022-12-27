import 'package:floor/floor.dart';
import 'package:rent_app/Classes/user.dart';
import 'adclass.dart';

@Entity(
  tableName: 'favorites',
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
class Favorite{
  @PrimaryKey(autoGenerate: true)
  final int? id;
  @ColumnInfo(name: 'customer_id')
  final int user_id;
  @ColumnInfo(name: 'Ad_id')
  final int ad_id;
  Favorite({this.id,required this.user_id,required this.ad_id});
}