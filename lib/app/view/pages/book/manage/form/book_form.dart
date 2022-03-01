// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';
import 'package:projeto_integrador_app/app/view/pages/book/manage/book_form_back.dart';
import 'package:projeto_integrador_app/app/view/pages/book/manage/form/book_details_form.dart';
import 'package:projeto_integrador_app/app/view/pages/book/manage/form/book_notes_form.dart';

class BookForm extends StatefulWidget {
  const BookForm({Key key}) : super(key: key);

  @override
  _BookFormState createState() => _BookFormState();
}

class _BookFormState extends State<BookForm>
    with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();

  int pages = 0;
  void setPages(int pages) => setState(() => this.pages = pages);

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
  void dispose() {
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final back = BookFormBack(context);

    return Scaffold(
      backgroundColor: Constants.bgColorLigth,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          back.book.id == null ? "Cadastrar livro" : "Editar livro",
          style: TextStyle(color: Constants.myOrange),
        ),
        backgroundColor: Constants.headerColorLigth,
        bottom: TabBar(
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
      body: Form(
        key: formKey,
        child: TabBarView(
          controller: _controller,
          children: <Widget>[
            BookDetaisForm(
              back: back,
              setPagesCallback: setPages,
            ),
            BookNotesFrom(
              back: back,
              pages: pages,
            ),
          ],
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
