import 'package:floor/floor.dart';
import '../Classes/bookingclass.dart';

@dao
abstract class BookDao{
  @Query('SELECT * FROM book')
  Future<List<Book>> findAllBooks();

  @Query('SELECT * FROM book WHERE customer_id = :id')
  Future<List<Book?>> findAdByCustomerId(int id);

  @Query('SELECT * FROM book WHERE Ad_id = :id')
  Future<List<Book?>> findAdByAdId(int id);

  @Query('SELECT * FROM book WHERE id = :id')
  Stream<Book?> findBookbyId(int id);

  @insert
  Future<void> insertBook(Book trans);
}