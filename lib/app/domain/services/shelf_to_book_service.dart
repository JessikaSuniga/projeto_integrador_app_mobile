import 'package:projeto_integrador_app/app/domain/models/book.dart';
import 'package:projeto_integrador_app/app/domain/models/shelf_to_book.dart';
import 'package:projeto_integrador_app/app/domain/repositories/book_repository.dart';
import 'package:projeto_integrador_app/app/domain/repositories/shelf_to_book_repository.dart';

class ShelfToBookService {
  final _shelfToBookRepository = ShelfToBookRepository();
  final _bookRepository = BookRepository();

  save(int shelfId, List<Book> books) async {
    if (shelfId == null || books == null) return;

    List<ShelfToBook> dbShelfToBooks = await findAllByShelfId(shelfId);

    var dicDbShelfToBooks = {
      for (var shelfToBook in dbShelfToBooks) shelfToBook.bookId: shelfToBook
    };

    for (var book in books) {
      if (!dicDbShelfToBooks.containsKey(book.id)) {
        await _shelfToBookRepository
            .insert(ShelfToBook(shelfId: shelfId, bookId: book.id));
      }

      dicDbShelfToBooks.remove(book.id);
    }

    for (var key in dicDbShelfToBooks.keys) {
      _shelfToBookRepository.remove(dicDbShelfToBooks[key].id);
    }
  }

  Future<List<ShelfToBook>> findAllByShelfId(int shelfId) async {
    var shelfToBooks = await _shelfToBookRepository.findAllByShelfId(shelfId);
    for (var stb in shelfToBooks) {
      stb.book = await _bookRepository.findById(stb.bookId);
    }
    return shelfToBooks;
  }
}
