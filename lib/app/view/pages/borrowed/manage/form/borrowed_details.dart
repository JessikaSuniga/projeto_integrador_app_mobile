import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';
import 'package:projeto_integrador_app/app/domain/models/book.dart';
import 'package:projeto_integrador_app/app/view/components/scroll.dart';
import 'package:projeto_integrador_app/app/view/pages/borrowed/manage/borrowed_form_back.dart';
import 'package:projeto_integrador_app/app/view/services/common_service.dart';

class BorrowedDetais extends StatefulWidget {
  final BorrowedFormBack back;

  const BorrowedDetais({Key key, this.back}) : super(key: key);

  @override
  _BorrowedDetaisState createState() => _BorrowedDetaisState();
}

class _BorrowedDetaisState extends State<BorrowedDetais> {
  // String _validationIsNullOrEmpty(value) {
  //   if (value == null || value.trim().isEmpty) {
  //     return 'Informe um valor válido';
  //   }
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    return Scroll(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            _bookSelect,
            _nameField,
            const Padding(padding: EdgeInsets.only(top: 20, bottom: 0)),
            _startDateField,
            const Padding(padding: EdgeInsets.only(top: 20, bottom: 0)),
            widget.back.borrowed.id != null
                ? _endDateField
                : const Padding(padding: EdgeInsets.only(top: 20, bottom: 0)),
          ],
        ),
      ),
    );
  }

  TextFormField get _nameField {
    return TextFormField(
      initialValue: widget.back.borrowed.name,
      // validator: (value) {
      //   return _validationIsNullOrEmpty(value);
      // },
      onSaved: (value) => widget.back.borrowed.name = value,
      decoration: const InputDecoration(
        labelText: 'Nome',
        labelStyle: Constants.sdFormTitle,
        hintText: 'Nome de quem foi emprestado',
        hintStyle: Constants.sdFormHint,
        focusedBorder: Constants.sdFormFocusedDorder,
      ),
      style: Constants.sdFormText,
      cursorColor: Constants.myGrey,
      textInputAction: TextInputAction.next,
    );
  }

  Widget get _startDateField {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Data de início: ${CommonService.formattedDate(widget.back.borrowed.startDate)}",
              style: Constants.sdFormText,
            ),
            GestureDetector(
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: widget.back.borrowed.startDate ?? DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2222),
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      widget.back.borrowed.startDate = value;
                    });
                  }
                });
              },
              child: const Icon(Icons.date_range),
            ),
          ],
        ),
        Divider(
          thickness: 1,
          color: Colors.grey.shade700,
        ),
      ],
    );
  }

  Widget get _endDateField {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Data de fim: ${CommonService.formattedDate(widget.back.borrowed.endDate)}",
              style: Constants.sdFormText,
            ),
            GestureDetector(
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: widget.back.borrowed.endDate ?? DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2222),
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      widget.back.borrowed.endDate = value;
                    });
                  }
                });
              },
              child: const Icon(Icons.date_range),
            ),
          ],
        ),
        Divider(
          thickness: 1,
          color: Colors.grey.shade700,
        ),
      ],
    );
  }

  Widget get _bookSelect {
    return FutureBuilder(
      future: widget.back.findAllBookAvailable(widget.back.borrowed.id),
      builder: (context, result) {
        if (!result.hasData) {
          return const CircularProgressIndicator();
        }
        List<Book> resultData = result.data;
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Livro:", style: Constants.sdFormText),
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                      hint: const Text("Selecione uma das opções"),
                      value: widget.back.borrowed.bookId,
                      items: resultData
                          .map((book) => DropdownMenuItem(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    book.title,
                                    style: Constants.sdFormText,
                                  ),
                                ),
                                value: book.id,
                              ))
                          .toList(),
                      onChanged: (value) =>
                          setState(() => widget.back.borrowed.bookId = value),
                      dropdownColor: Constants.bgColorDialogsLigth),
                )
              ],
            ),
            Divider(
              thickness: 1,
              color: Colors.grey.shade700,
            ),
          ],
        );
      },
    );
  }
}
