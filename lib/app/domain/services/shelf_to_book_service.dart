import 'package:projeto_integrador_app/app/domain/models/shelf_to_book.dart';
import 'package:projeto_integrador_app/app/domain/repositories/shelf_to_book_repository.dart';

class ShelfToBookService {
  final _shelfToBookRepository = ShelfToBookRepository();

  save(ShelfToBook shelf) async {
    if (shelf.id == null) {
      return await _shelfToBookRepository.insert(shelf);
    }
    await _shelfToBookRepository.update(shelf);
  }

  remove(int id) async {
    await _shelfToBookRepository.remove(id);
  }

  Future<List<ShelfToBook>> findAll() {
    return _shelfToBookRepository.findAll();
  }
}
