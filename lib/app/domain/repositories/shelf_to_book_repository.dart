import 'package:projeto_integrador_app/app/database/connection.dart';
import 'package:projeto_integrador_app/app/domain/models/shelf_to_book.dart';
import 'package:sqflite/sqlite_api.dart';

class ShelfToBookRepository {
  final Connection _connection = Connection.instance;

  Future<Database> _getDatabase() async {
    return await _connection.database;
  }

  final _table = 'shelf_to_book';

  Future<List<ShelfToBook>> findAll() async {
    final _db = await _getDatabase();
    List<Map<String, dynamic>> allRows = await _db.query(_table);
    List<ShelfToBook> shelfToBooks =
        allRows.map((shelfToBook) => ShelfToBook.fromMap(shelfToBook)).toList();
    return shelfToBooks;
  }

  Future<List<ShelfToBook>> findAllByShelfId(int shelfId) async {
    final _db = await _getDatabase();

    List<Map<String, dynamic>> allRows =
        await _db.query(_table, where: 'shelf_Id=?', whereArgs: [shelfId]);

    List<ShelfToBook> shelfToBooks =
        allRows.map((shelfToBook) => ShelfToBook.fromMap(shelfToBook)).toList();

    return shelfToBooks;
  }

  remove(int id) async {
    final _db = await _getDatabase();
    _db.delete(_table, where: "id=?", whereArgs: [id]);
  }

  removeByShelfId(int shelfId) async {
    final _db = await _getDatabase();
    _db.delete(_table, where: "shelf_id=?", whereArgs: [shelfId]);
  }

  removeByBookId(int bookId) async {
    final _db = await _getDatabase();
    _db.delete(_table, where: "book_id=?", whereArgs: [bookId]);
  }

  insert(ShelfToBook shelfToBook) async {
    final _db = await _getDatabase();
    _db.insert(_table, shelfToBook.toMap());
  }

  update(ShelfToBook shelfToBook) async {
    final _db = await _getDatabase();
    _db.update(_table, shelfToBook.toMap(),
        where: "id=?", whereArgs: [shelfToBook.id]);
  }
}
