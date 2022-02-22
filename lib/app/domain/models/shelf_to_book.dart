import 'package:projeto_integrador_app/app/domain/models/book.dart';

class ShelfToBook {
  int id;
  int shelfId;
  int bookId;
  Book book;

  ShelfToBook({
    this.id,
    this.shelfId,
    this.bookId,
    this.book,
  });

  ShelfToBook.fromMap(dynamic obj) {
    id = obj['id'];
    shelfId = obj['shelf_id'];
    bookId = obj['book_id'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'shelf_id': shelfId,
      'book_id': bookId,
    };

    return map;
  }
}
