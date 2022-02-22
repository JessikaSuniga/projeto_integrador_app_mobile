import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:projeto_integrador_app/app/domain/models/borrowed.dart';
import 'package:projeto_integrador_app/app/domain/services/borrowed_service.dart';
import 'package:projeto_integrador_app/app/routes/routes.dart';
import 'package:projeto_integrador_app/app/view/services/common_service.dart';
part 'borrowed_list_back.g.dart';

class BorrowedListBack = _BorrowedListBack with _$BorrowedListBack;

abstract class _BorrowedListBack with Store {
  final _service = GetIt.I.get<BorrowedService>();

  @observable
  Future<List<Borrowed>> list;

  @action
  refleshList([dynamic value]) {
    list = _service.findAll();
  }

  _BorrowedListBack() {
    refleshList();
  }

  goToForm(BuildContext context, [Borrowed borrowed]) {
    Navigator.of(context)
        .pushNamed(Routes.BOOK_FORM, arguments: borrowed)
        .then(refleshList);
  }

  remove(dynamic id, BuildContext context) async {
    try {
      await _service.remove(id);
      refleshList();
      Navigator.of(context).pop();
      CommonService.messageSuccess(
          context, 'Livro emprestado removido com sucesso!');
    } catch (e) {
      CommonService.messageSuccess(
          context, 'Falha ao remover livro emprestado! $e!');
      Navigator.of(context).pop();
    }
  }
}
