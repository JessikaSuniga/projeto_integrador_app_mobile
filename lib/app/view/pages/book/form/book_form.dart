// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';
import 'package:projeto_integrador_app/app/view/pages/book/form/book_details.dart';
import 'package:projeto_integrador_app/app/view/pages/book/form/book_form_back.dart';
import 'package:projeto_integrador_app/app/view/pages/book/form/book_notes.dart';

class BookForm extends StatefulWidget {
  const BookForm({Key key}) : super(key: key);

  @override
  _BookFormState createState() => _BookFormState();
}

class _BookFormState extends State<BookForm>
    with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();

  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final back = BookFormBack(context);

    return Scaffold(
      backgroundColor: Constants.bgColorLigth,
      appBar: AppBar(
        title: const Text(
          "Cadastro do livro",
          style: TextStyle(color: Constants.myOrange),
        ),
        backgroundColor: Constants.headerColorLigth,
        bottom: TabBar(
          isScrollable: true,
          controller: _controller,
          tabs: const <Widget>[
            Tab(text: "Detalhes"),
            Tab(text: "Notas"),
          ],
          labelColor: Constants.myOrange,
          unselectedLabelColor: Constants.myBlack,
          labelStyle: const TextStyle(fontSize: 18),
          unselectedLabelStyle: const TextStyle(fontSize: 18),
          indicatorColor: Constants.myOrange,
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          BookDetais(
            back: back,
            formKey: formKey,
          ),
          BookNote(
            back: back,
            formKey: formKey,
          ),
        ],
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
            formKey.currentState.validate();
            formKey.currentState.save();
            back.save(context);
          },
          child: const Text('Salvar'),
        ),
      ),
    );
  }
}
