// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';
import 'package:projeto_integrador_app/app/view/pages/desire/manage/desire_form_back.dart';
import 'package:projeto_integrador_app/app/view/pages/desire/manage/form/desire_details.dart';

class DesireForm extends StatelessWidget {
  const DesireForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _back = DesireFormBack(context);
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Constants.bgColorLigth,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _back.book.id == null ? "Cadastrar desejo" : "Editar desejo",
          style: TextStyle(color: Constants.myOrange),
        ),
        backgroundColor: Constants.headerColorLigth,
      ),
      body: Form(
        key: _formKey,
        child: DesireDetais(
          back: _back,
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Constants.btnSaveColorLigth,
            padding: const EdgeInsets.all(10),
            primary: Colors.white,
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: () {
            _formKey.currentState.validate();
            _formKey.currentState.save();
            _back.save(context);
          },
          child: const Text('Salvar'),
        ),
      ),
    );
  }
}
