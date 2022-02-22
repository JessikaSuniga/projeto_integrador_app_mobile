// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';
import 'package:projeto_integrador_app/app/view/pages/desire/form/desire_details.dart';
import 'package:projeto_integrador_app/app/view/pages/desire/form/desire_form_back.dart';

class DesireForm extends StatelessWidget {
  const DesireForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _back = DesireFormBack(context);
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Constants.bgColorLigth,
      appBar: AppBar(
        title: const Text(
          "Cadastro do livro",
          style: TextStyle(color: Constants.myOrange),
        ),
        backgroundColor: Constants.headerColorLigth,
      ),
      body: DesireDetais(
        back: _back,
        formKey: _formKey,
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
