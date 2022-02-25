import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';
import 'package:projeto_integrador_app/app/domain/models/shelf.dart';
import 'package:projeto_integrador_app/app/domain/services/shelf_service.dart';
import 'package:projeto_integrador_app/app/routes/routes.dart';
import 'package:projeto_integrador_app/app/view/services/common_service.dart';

// flutter pub run build_runner build
class ShelfFormBack {
  Shelf shelf;
  final _service = GetIt.I.get<ShelfService>();

  ShelfFormBack(BuildContext context) {
    var parameter = ModalRoute.of(context).settings.arguments;
    shelf = (parameter == null) ? Shelf() : parameter;
  }

  goToForm(BuildContext context, [Shelf shelf]) {
    Navigator.of(context)
        .pushReplacementNamed(Routes.SHELF_FORM, arguments: shelf);
  }

  dispacheDialogSave(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Nova estante'),
        content: Form(
          key: _formKey,
          child: TextFormField(
            initialValue: shelf.name,
            // validator: (value) {
            //   return _validationIsNullOrEmpty(value);
            // },
            onSaved: (value) => shelf.name = value,
            decoration: const InputDecoration(
              labelText: 'Nome',
              labelStyle: Constants.sdFormTitle,
              hintText: 'Informe um nome para sua estante',
              hintStyle: Constants.sdFormHint,
              focusedBorder: Constants.sdFormFocusedDorder,
            ),
            style: Constants.sdFormText,
            cursorColor: Constants.myGrey,
            textInputAction: TextInputAction.next,
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Não'),
            onPressed: () => Navigator.of(_).pop(),
          ),
          TextButton(
            child: const Text('Sim'),
            onPressed: () {
              _formKey.currentState.validate();
              _formKey.currentState.save();
              save(_);
            },
          ),
        ],
      ),
    );
  }

  save(BuildContext context) async {
    try {
      await _service.save(shelf);
      CommonService.messageSuccess(context, 'Livro salvo com sucesso!');
      Navigator.of(context).pop();
    } catch (e) {
      CommonService.messageError(context, 'Falha ao salvar livro! $e');
      Navigator.of(context).pop();
    }
  }
}
