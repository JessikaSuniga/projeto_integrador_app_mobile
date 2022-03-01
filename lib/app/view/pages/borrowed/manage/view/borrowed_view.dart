import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/common/assets.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';
import 'package:projeto_integrador_app/app/common/utility/utility.dart';
import 'package:projeto_integrador_app/app/view/components/scroll.dart';
import 'package:projeto_integrador_app/app/view/pages/borrowed/manage/borrowed_form_back.dart';
import 'package:projeto_integrador_app/app/view/services/common_service.dart';

class BorrowedView extends StatelessWidget {
  const BorrowedView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _back = BorrowedFormBack(context);
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      // backgroundColor: Constants.bgColorLigth,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Visualizar empréstimo",
          // style: TextStyle(color: Constants.myOrange),
        ),
        // backgroundColor: Constants.headerColorLigth,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            // color: Constants.myOrange,
            onPressed: () => _back.goToForm(context, _back.borrowed),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Scroll(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.shade400, width: 2),
                        ),
                        child: _back.borrowed.book.image != null
                            ? Utility.imageFromBase64String(
                                _back.borrowed.book.image)
                            : Image.asset(ConstantAssets.imgDefault),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              _back.borrowed.book.title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(_back.borrowed.book.author),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    "ISBN",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(_back.borrowed.book.isbn),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Nome",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(_back.borrowed.name),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Data de início:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(CommonService.formattedDate(
                              _back.borrowed.startDate)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Data de fim:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(CommonService.formattedDate(
                              _back.borrowed.endDate)),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
