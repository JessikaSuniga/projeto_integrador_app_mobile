import 'package:get_it/get_it.dart';
import 'package:projeto_integrador_app/app/domain/services/book_service.dart';
import 'package:projeto_integrador_app/app/domain/services/shelf_service.dart';
import 'package:projeto_integrador_app/app/domain/services/borrowed_service.dart';
import 'package:projeto_integrador_app/app/domain/services/shelf_to_book_service.dart';

setupInjection() {
  GetIt getit = GetIt.I;

  getit.registerSingleton<BookService>(BookService());
  getit.registerSingleton<ShelfService>(ShelfService());
  getit.registerSingleton<BorrowedService>(BorrowedService());
  getit.registerSingleton<ShelfToBookService>(ShelfToBookService());
}
