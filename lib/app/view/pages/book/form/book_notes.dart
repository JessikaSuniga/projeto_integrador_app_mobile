import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:projeto_integrador_app/app/view/components/scroll.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';
import 'package:projeto_integrador_app/app/view/services/common_service.dart';
import 'package:projeto_integrador_app/app/view/pages/book/form/book_form_back.dart';

class BookNote extends StatefulWidget {
  final BookFormBack back;

  const BookNote({Key key, this.back}) : super(key: key);

  @override
  _BookNoteState createState() => _BookNoteState();
}

class _BookNoteState extends State<BookNote> {
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
            _evaluationRating,
            _pagesReadSlider,
            const Padding(padding: EdgeInsets.only(top: 10)),
            _startDateField,
            const Padding(padding: EdgeInsets.only(top: 10)),
            _endDateField,
            // _notesField(),
          ],
        ),
      ),
    );
  }

  RatingBar get _evaluationRating {
    return RatingBar.builder(
      initialRating: widget.back.book.evaluation ?? 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (value) {
        setState(() {
          widget.back.book.evaluation = value;
        });
      },
    );
  }

  Widget get _pagesReadSlider {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 6,
          child: Slider(
            value: widget.back.book.pagesRead.toDouble(),
            min: 0,
            max: widget.back.book.pages.toDouble(),
            onChanged: (double newSliderValue) {
              setState(
                () {
                  widget.back.book.pagesRead = newSliderValue.toInt();
                },
              );
            },
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            '${widget.back.book.pagesRead.round()} pages',
          ),
        )
      ],
    );
  }

  Widget get _startDateField {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Início: ${CommonService.formattedDate(widget.back.book.startDate)}",
              style: Constants.sdFormText,
            ),
            GestureDetector(
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: widget.back.book.startDate ?? DateTime.now(),
                  firstDate: DateTime(2001),
                  lastDate: DateTime(2222),
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      widget.back.book.startDate = value;
                    });
                  }
                });
              },
              child: const Icon(
                Icons.date_range,
                color: Constants.myOrange,
              ),
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
              "Fim: ${CommonService.formattedDate(widget.back.book.endDate)}",
              style: Constants.sdFormText,
            ),
            GestureDetector(
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: widget.back.book.endDate ?? DateTime.now(),
                  firstDate: DateTime(2001),
                  lastDate: DateTime(2222),
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      widget.back.book.endDate = value;
                    });
                  }
                });
              },
              child: const Icon(
                Icons.date_range,
                color: Constants.myOrange,
              ),
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

  Widget _notesField() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: widget.back.book.notes != null &&
                        widget.back.book.notes.length != 0
                    ? widget.back.book.notes[0]
                    : "",
                // validator: (value) {
                //   return _validationIsNullOrEmpty(value);
                // },
                onSaved: (value) {
                  setState(() {
                    widget.back.book.notes.add(value);
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Notas',
                  labelStyle: Constants.sdFormTitle,
                  hintText: 'Informe uma anotação',
                  hintStyle: Constants.sdFormHint,
                  focusedBorder: Constants.sdFormFocusedDorder,
                ),
                style: Constants.sdFormText,
                cursorColor: Constants.myGrey,
                textInputAction: TextInputAction.next,
              ),
            ),
            GestureDetector(
              child: const Icon(
                Icons.add,
                color: Constants.myBlack,
              ),
              onTap: () {
                setState(() {
                  // widget.back.book.notes.add()
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
