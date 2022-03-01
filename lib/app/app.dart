import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/common/assets.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';
import 'package:projeto_integrador_app/app/view/home.dart';
import 'package:projeto_integrador_app/app/routes/routes.dart';
import 'package:projeto_integrador_app/app/view/pages/book/manage/form/book_form.dart';
import 'package:projeto_integrador_app/app/view/pages/book/manage/view/book_view.dart';
import 'package:projeto_integrador_app/app/view/pages/borrowed/manage/form/borrowed_form.dart';
import 'package:projeto_integrador_app/app/view/pages/borrowed/manage/view/borrowed_view.dart';
import 'package:projeto_integrador_app/app/view/pages/desire/manage/form/desire_form.dart';
import 'package:projeto_integrador_app/app/view/pages/desire/manage/view/desire_view.dart';
import 'package:projeto_integrador_app/app/view/pages/shelf/book_list/shelf_to_book_list.dart';

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

var darkTheme = ThemeData(
  brightness: Brightness.dark,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

var lightTheme = ThemeData(
  brightness: Brightness.light,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

var bookTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: Constants.myOrange,
    ),
    backgroundColor: Constants.myBrown,
    titleTextStyle: TextStyle(
      color: Constants.myOrange,
      fontSize: 18,
    ),
  ),
  tabBarTheme: const TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    labelColor: Constants.myOrange,
    unselectedLabelColor: Constants.myBlack,
    labelStyle: TextStyle(
      fontSize: 18,
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 18,
    ),
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(
        color: Constants.myOrange,
      ),
    ),
  ),
  scaffoldBackgroundColor: const Color.fromRGBO(249, 241, 230, 1),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color.fromRGBO(249, 241, 230, 1),
  ),
  primaryColor: Constants.myBrown,
  iconTheme: const IconThemeData(color: Constants.myOrange),
  brightness: Brightness.light,
  // textTheme: TextTheme(bodyText1: TextStyle(color: Colors.pink)),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Constants.myOrange,
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all(
        const EdgeInsets.all(10),
      ),
      backgroundColor: MaterialStateProperty.all(Constants.myOrange),
    ),
  ),
);

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Folha Amarela',
      theme: bookTheme,
      routes: {
        Routes.HOME: (context) => const Home(),
        Routes.BOOK_FORM: (context) => const BookForm(),
        Routes.BOOK_VIEW: (context) => const BookView(),
        Routes.SHELF_TO_BOOK_LIST: (context) => const ShelfToBookList(),
        Routes.BORROWED_FORM: (context) => const BorrowedForm(),
        Routes.BORROWED_VIEW: (context) => const BorrowedView(),
        Routes.DESIRE_FORM: (context) => const DesireForm(),
        Routes.DESIRE_VIEW: (context) => const DesireView(),
      },
    );
  }
}
