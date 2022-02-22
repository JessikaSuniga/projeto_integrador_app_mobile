import 'package:projeto_integrador_app/app/domain/models/shelf.dart';
import 'package:projeto_integrador_app/app/domain/repositories/book_repository.dart';
import 'package:projeto_integrador_app/app/domain/repositories/shelf_repository.dart';
import 'package:projeto_integrador_app/app/domain/repositories/shelf_to_book_repository.dart';

class ShelfService {
  final _shelfRepository = ShelfRepository();
  final _bookRepository = BookRepository();
  final _shelfToBookRepository = ShelfToBookRepository();

  save(Shelf shelf) async {
    //insert
    if (shelf.id == null) {
      await _shelfRepository.insert(shelf);

      for (var book in shelf.books) {
        await _shelfToBookRepository.insert(book);
      }
      return;
    }

    // update
    Shelf dbShelf = await findById(shelf.id);

    var listDbBooks = {for (var book in dbShelf.books) book.bookId: book};

    for (var book in shelf.books) {
      if (!listDbBooks.containsKey(book.bookId)) {
        await _shelfToBookRepository.insert(book);
      }
      listDbBooks.remove(book.bookId);
    }

    for (var key in listDbBooks.keys) {
      _shelfToBookRepository.remove(listDbBooks[key].id);
    }

    await _shelfRepository.update(shelf);
  }

  remove(int id) async {
    await _shelfRepository.remove(id);
    await _shelfToBookRepository.removeByShelfId(id);
  }

  Future<List<Shelf>> findAll() async {
    List<Shelf> shelfs = await _shelfRepository.findAll();

    for (var shelf in shelfs) {
      shelf.books = await _shelfToBookRepository.findAllByShelfId(shelf.id);
      for (var e in shelf.books) {
        e.book = await _bookRepository.findById(e.bookId);
      }
    }
    return shelfs;
  }

  Future<Shelf> findById(int id) async {
    Shelf shelf = await _shelfRepository.findById(id);
    shelf.books = await _shelfToBookRepository.findAllByShelfId(shelf.id);
    for (var e in shelf.books) {
      e.book = await _bookRepository.findById(e.bookId);
    }
    return shelf;
  }
}
