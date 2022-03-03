import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/view/pages/desire/manage/desire_form_back.dart';
import 'package:projeto_integrador_app/app/view/pages/desire/manage/form/desire_details.dart';

class DesireForm extends StatelessWidget {
  const DesireForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _back = DesireFormBack(context);
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _back.book.id == null ? "Cadastrar desejo" : "Editar desejo",
        ),
      ),
      body: Form(
        key: _formKey,
        child: DesireDetais(
          back: _back,
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          _formKey.currentState.validate();
          _formKey.currentState.save();
          _back.save(context);
        },
        child: const Text('Salvar'),
      ),
    );
  }
}
