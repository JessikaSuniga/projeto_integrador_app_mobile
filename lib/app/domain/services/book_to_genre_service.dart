import 'package:projeto_integrador_app/app/domain/models/book_to_genre.dart';
import 'package:projeto_integrador_app/app/domain/repositories/book_to_genre_repository.dart';

class BookToGenreService {
  final _bookToGenreRepository = BookToGenreRepository();

  save(BookToGenre shelf) async {
    if (shelf.id == null) {
      return await _bookToGenreRepository.insert(shelf);
    }
    await _bookToGenreRepository.update(shelf);
  }

  remove(int id) async {
    await _bookToGenreRepository.remove(id);
  }

  Future<List<BookToGenre>> findAll() {
    return _bookToGenreRepository.findAll();
  }
}
