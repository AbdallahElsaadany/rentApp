import 'package:floor/floor.dart';
import 'package:rent_app/Classes/user.dart';

@Entity(
  tableName: 'ads',
  foreignKeys: [
    ForeignKey(
      childColumns: ['owner_id'],
      parentColumns: ['id'],
      entity: User,
      onUpdate: ForeignKeyAction.cascade,
      onDelete: ForeignKeyAction.cascade,
    )
  ],
)
class Ads{
  @PrimaryKey(autoGenerate: true)
  final int? id;
  @ColumnInfo(name: 'owner_id')
  final int user_id;
  final int price,number_of_rooms,phone_number;
  final String link,desc,title,type,location;
  Ads({this.id,required this.user_id,required this.link, required this.desc, required this.title,required this.price,
  required this.number_of_rooms,required this.type,required this.location,required this.phone_number});
  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}