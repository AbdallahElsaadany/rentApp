import 'package:floor/floor.dart';
import 'package:rent_app/Classes/user.dart';

@Entity(
  tableName: 'customer_support',
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
class CustomerSupportClass{
  @PrimaryKey(autoGenerate: true)
  final int? id;
  @ColumnInfo(name: 'customer_id')
  final int user_id;
  final String Question_title,Description;
  CustomerSupportClass({this.id,required this.Question_title,required this.Description, required this.user_id});
  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}