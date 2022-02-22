import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:projeto_integrador_app/app/common/enums/book_item_type.dart';
import 'package:projeto_integrador_app/app/domain/models/book.dart';
import 'package:projeto_integrador_app/app/domain/models/genre.dart';
import 'package:projeto_integrador_app/app/domain/services/book_service.dart';
import 'package:projeto_integrador_app/app/domain/services/genre_service.dart';
import 'package:projeto_integrador_app/app/view/services/common_service.dart';

// flutter pub run build_runner build
class DesireFormBack {
  Book book;
  final _service = GetIt.I.get<BookService>();
  final _serviceGenre = GenreService();
  Future<List<Genre>> listGenre;

  DesireFormBack(BuildContext context) {
    var parameter = ModalRoute.of(context).settings.arguments;
    book = (parameter == null) ? Book() : parameter;
    findAllGenre();
  }

  findAllGenre() {
    listGenre = _serviceGenre.findAll();
  }

  save(BuildContext context) async {
    try {
      book.itemType ??= BookItemType.desire;
      await _service.save(book);
      CommonService.messageSuccess(context, 'Livro salvo com sucesso!');
      Navigator.of(context).pop();
    } catch (e) {
      CommonService.messageSuccess(context, 'Falha ao salvar livro! $e');
      Navigator.of(context).pop();
    }
  }
}
