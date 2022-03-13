import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/view/pages/book/manage/book_form_back.dart';
import 'package:projeto_integrador_app/app/view/pages/book/manage/form/book_notes_form.dart';
import 'package:projeto_integrador_app/app/view/pages/book/manage/form/book_details_form.dart';

class BookForm extends StatefulWidget {
  const BookForm({Key? key}) : super(key: key);

  @override
  _BookFormState createState() => _BookFormState();
}

class _BookFormState extends State<BookForm>
    with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();

  TabController? _controller;

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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          back.book!.id == null ? "Cadastrar livro" : "Editar livro",
        ),
        bottom: TabBar(
          controller: _controller,
          tabs: const <Widget>[
            Tab(text: "Detalhes"),
            Tab(text: "Notas"),
          ],
        ),
      ),
      body: Form(
        key: formKey,
        child: TabBarView(
          controller: _controller,
          children: <Widget>[
            BookDetaisForm(
              back,
            ),
            BookNotesFrom(back),
          ],
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            const EdgeInsets.all(16),
          ),
        ),
        onPressed: () {
          var res = formKey.currentState!.validate();
          formKey.currentState!.save();
          if (res) {
            back.save(context);
          }
        },
        child: const Text(
          'Salvar',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
