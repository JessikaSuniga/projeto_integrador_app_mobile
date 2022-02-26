import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:projeto_integrador_app/app/domain/models/book.dart';
import 'package:projeto_integrador_app/app/domain/models/shelf.dart';
import 'package:projeto_integrador_app/app/domain/models/shelf_to_book.dart';
import 'package:projeto_integrador_app/app/domain/services/shelf_to_book_service.dart';
import 'package:projeto_integrador_app/app/view/services/common_service.dart';
part 'shelf_form_back.g.dart';

class ShelfFormBack = _ShelfFormBack with _$ShelfFormBack;

// flutter pub run build_runner build
abstract class _ShelfFormBack with Store {
  final _shelfToBookService = ShelfToBookService();

  Shelf shelf;

  @observable
  Future<List<ShelfToBook>> list;

  @action
  refleshList() {
    list = _shelfToBookService.findAllByShelfId(shelf.id);
  }

  _ShelfFormBack(BuildContext context) {
    var parameter = ModalRoute.of(context).settings.arguments;
    shelf = (parameter == null) ? Shelf() : parameter;
    refleshList();
  }

  save(BuildContext context, List<Book> books) async {
    try {
      await _shelfToBookService.save(shelf.id, books);
      CommonService.messageSuccess(context, 'Estante salvo com sucesso!');
      Navigator.of(context).pop();
    } catch (e) {
      CommonService.messageError(context, 'Falha ao salvar estante! $e');
      Navigator.of(context).pop();
    }
  }
}
