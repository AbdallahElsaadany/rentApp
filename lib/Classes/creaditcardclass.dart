import 'package:floor/floor.dart';
import 'package:rent_app/Classes/user.dart';

@Entity(
  tableName: 'creaditCard',
  foreignKeys: [
    ForeignKey(
      childColumns: ['customer_id'],
      parentColumns: ['id'],
      entity: User,
      onUpdate: ForeignKeyAction.cascade,
      onDelete: ForeignKeyAction.cascade,
    )
  ],
)
class CreaditCard{
  @PrimaryKey(autoGenerate: true)
  final int? id;
  @ColumnInfo(name: 'customer_id')
  final int user_id;
  final String description,questiontitle;
  CreaditCard({this.id,required this.user_id,required this.description, required this.questiontitle});
  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}