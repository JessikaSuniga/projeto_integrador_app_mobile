import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/view/home.dart';
import 'package:projeto_integrador_app/app/routes/routes.dart';
import 'package:projeto_integrador_app/app/view/pages/book/form/book_form.dart';
import 'package:projeto_integrador_app/app/view/pages/borrowed/manage/form/borrowed_form.dart';
import 'package:projeto_integrador_app/app/view/pages/desire/manage/form/desire_form.dart';
import 'package:projeto_integrador_app/app/view/pages/desire/manage/view/desire_view.dart';
import 'package:projeto_integrador_app/app/view/pages/shelf/form/shelf_form.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Folha Amarela',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        routes: {
          Routes.HOME: (context) => const Home(),
          Routes.BOOK_FORM: (context) => const BookForm(),
          Routes.SHELF_FORM: (context) => const ShelfForm(),
          Routes.BORROWED_FORM: (context) => const BorrowedForm(),
          Routes.DESIRE_FORM: (context) => const DesireForm(),
          Routes.DESIRE_VIEW: (context) => const DesireView(),
        });
  }
}
