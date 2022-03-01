// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';
import 'package:projeto_integrador_app/app/view/pages/borrowed/manage/borrowed_form_back.dart';
import 'package:projeto_integrador_app/app/view/pages/borrowed/manage/form/borrowed_details.dart';

class BorrowedForm extends StatelessWidget {
  const BorrowedForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _back = BorrowedFormBack(context);
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      // backgroundColor: Constants.bgColorLigth,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _back.borrowed.id == null
              ? "Cadastrar empréstimo"
              : "Editar empréstimo",
          // style: TextStyle(color: Constants.myOrange),
        ),
        // backgroundColor: Constants.headerColorLigth,
      ),
      body: Form(
          key: _formKey,
          child: BorrowedDetais(
            back: _back,
          )),
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
