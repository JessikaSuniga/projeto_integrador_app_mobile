import 'package:projeto_integrador_app/app/domain/models/borrowed.dart';
import 'package:projeto_integrador_app/app/domain/repositories/book_repository.dart';
import 'package:projeto_integrador_app/app/domain/repositories/borrowed_repository.dart';

class BorrowedService {
  final _borrowedRepository = BorrowedRepository();
  final _bookRepository = BookRepository();

  save(Borrowed borrowed) async {
    if (borrowed.id == null) {
      return await _borrowedRepository.insert(borrowed);
    }
    await _borrowedRepository.update(borrowed);
  }

  remove(int id) async {
    await _borrowedRepository.remove(id);
  }

  Future<List<Borrowed>> findAll() async {
    List<Borrowed> borroweds = await _borrowedRepository.findAll();

    for (var borrowed in borroweds) {
      borrowed.book = await _bookRepository.findById(borrowed.bookId);
    }
    return borroweds;
  }
}
