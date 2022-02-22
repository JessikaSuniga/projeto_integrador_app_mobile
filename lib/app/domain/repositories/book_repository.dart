import 'package:projeto_integrador_app/app/common/enums/book_item_type.dart';
import 'package:projeto_integrador_app/app/database/connection.dart';
import 'package:projeto_integrador_app/app/domain/models/book.dart';
import 'package:sqflite/sqlite_api.dart';

class BookRepository {
  final Connection _connection = Connection.instance;

  Future<Database> _getDatabase() async {
    return await _connection.database;
  }

  final _table = 'book';

  Future<List<Book>> findAll(BookItemType itemType) async {
    Database _db = await _getDatabase();
    List<Map<String, dynamic>> allRows = await _db
        .query(_table, where: "item_type=?", whereArgs: [itemType.cod]);
    return allRows.map((book) => Book.fromMap(book)).toList();
  }

  Future<Book> findById(int id) async {
    Database _db = await _getDatabase();
    List<Map<String, dynamic>> allRows =
        await _db.query(_table, where: 'id=?', whereArgs: [id]);
    return allRows.map((book) => Book.fromMap(book)).first;
  }

  remove(int id) async {
    Database _db = await _getDatabase();
    _db.delete(_table, where: "id=?", whereArgs: [id]);
  }

  insert(Book book) async {
    Database _db = await _getDatabase();
    _db.insert(_table, book.toMap());
  }

  update(Book book) async {
    Database _db = await _getDatabase();
    _db.update(_table, book.toMap(), where: "id=?", whereArgs: [book.id]);
  }
}
