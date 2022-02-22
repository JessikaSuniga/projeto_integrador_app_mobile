import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:projeto_integrador_app/app/view/components/scroll.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';
import 'package:projeto_integrador_app/app/view/services/common_service.dart';
import 'package:projeto_integrador_app/app/view/pages/book/form/book_form_back.dart';

class BookNote extends StatefulWidget {
  final BookFormBack back;
  final GlobalKey<FormState> formKey;

  const BookNote({Key key, this.back, this.formKey}) : super(key: key);

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
        child: Form(
          key: widget.formKey,
          child: Column(
            children: [
              _livroRating,
              _pagesReadSlider,
              const Padding(padding: EdgeInsets.only(top: 10)),
              _startDateField,
              const Padding(padding: EdgeInsets.only(top: 10)),
              _endDateField,
            ],
          ),
        ),
      ),
    );
  }

  RatingBar get _livroRating {
    return RatingBar.builder(
      initialRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        setState(() {});
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
            '${widget.back.book.pagesRead.round()} pagesReads',
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
}
