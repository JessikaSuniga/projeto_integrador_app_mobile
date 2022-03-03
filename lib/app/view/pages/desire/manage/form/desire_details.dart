import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:projeto_integrador_app/app/common/assets.dart';
import 'package:projeto_integrador_app/app/common/enums/book_format_type.dart';
import 'package:projeto_integrador_app/app/common/enums/book_language_type.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';
import 'package:projeto_integrador_app/app/common/utility/utility.dart';
import 'package:projeto_integrador_app/app/domain/models/genre.dart';
import 'package:projeto_integrador_app/app/view/components/scroll.dart';
import 'package:projeto_integrador_app/app/view/pages/desire/manage/desire_form_back.dart';

class DesireDetais extends StatefulWidget {
  final DesireFormBack back;

  const DesireDetais({Key key, this.back}) : super(key: key);

  @override
  _DesireDetaisState createState() => _DesireDetaisState();
}

class _DesireDetaisState extends State<DesireDetais> {
  final _picker = ImagePicker();

  // String _validationIsNullOrEmpty(value) {
  //   if (value == null || value.trim().isEmpty) {
  //     return 'Informe um valor válido';
  //   }
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    if (widget.back.book.notes == null) {
      setState(() {
        widget.back.book.notes = [''];
      });
    }
    return Scroll(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            _titleField,
            _authorField,
            _sourceBookSection(),
            _genreField,
            const Padding(padding: EdgeInsets.only(top: 20, bottom: 0)),
            // _publicationDateField,
            _pagesField,
            _languageSelect,
            // _serieField,
            // _volumeField,
            // _descriptionField,
            //teste
          ],
        ),
      ),
    );
  }

  TextFormField get _titleField {
    return TextFormField(
      initialValue: widget.back.book.title,
      // validator: (value) {
      //   return _validationIsNullOrEmpty(value);
      // },
      onSaved: (value) => widget.back.book.title = value,
      decoration: const InputDecoration(
        labelText: 'Título',
        labelStyle: Constants.sdFormTitle,
        hintText: 'Titulo do livro',
        hintStyle: Constants.sdFormHint,
        focusedBorder: Constants.sdFormFocusedDorder,
      ),
      style: Constants.sdFormText,
      cursorColor: Constants.myGrey,
      textInputAction: TextInputAction.next,
    );
  }

  TextFormField get _authorField {
    return TextFormField(
      initialValue: widget.back.book.author,
      // validator: (value) {
      //   return _validationIsNullOrEmpty(value);
      // },
      onSaved: (value) => widget.back.book.author = value,
      decoration: const InputDecoration(
        labelText: 'Autor(a)',
        labelStyle: Constants.sdFormTitle,
        hintText: 'Nome do autor(a)',
        hintStyle: Constants.sdFormHint,
        focusedBorder: Constants.sdFormFocusedDorder,
      ),
      style: Constants.sdFormText,
      cursorColor: Constants.myGrey,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _sourceBookSection() {
    return Row(
      children: [
        _imagePicker(),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _publishingCompanyField,
                _isbnField,
                _formatoSelect(),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _imagePicker() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.grey.shade400, width: 2),
      // ),
      child: GestureDetector(
        onTap: _showDialog,
        child: widget.back.book.image != null
            ? Utility.imageFromBase64String(widget.back.book.image)
            : Image.asset(ConstantAssets.imgDefault),
      ),
    );
  }

  void _showDialog() {
    showDialog<String>(
      context: context,
      useSafeArea: false,
      builder: (BuildContext context) => SimpleDialog(
        title: const Text('Alterar foto'),
        alignment: Alignment.center,
        // backgroundColor: Constants.bgColorLigth,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.photo_camera),
                onPressed: () async => _pickImageFromCamera(),
                tooltip: 'Shoot picture',
              ),
              IconButton(
                icon: const Icon(Icons.photo),
                onPressed: () async => _pickImageFromGallery(),
                tooltip: 'Pick from gallery',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() => widget.back.book.image =
          Utility.base64String(File(pickedFile.path).readAsBytesSync()));
    }
    Navigator.pop(context);
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => widget.back.book.image =
          Utility.base64String(File(pickedFile.path).readAsBytesSync()));
    }

    Navigator.pop(context);
  }

  TextFormField get _publishingCompanyField {
    return TextFormField(
      initialValue: widget.back.book.publishingCompany,
      // validator: (value) {
      //   return _validationIsNullOrEmpty(value);
      // },
      onSaved: (value) => widget.back.book.publishingCompany = value,
      decoration: const InputDecoration(
        labelText: 'Editora',
        labelStyle: Constants.sdFormTitle,
        hintText: 'Nome da editora',
        hintStyle: Constants.sdFormHint,
        focusedBorder: Constants.sdFormFocusedDorder,
      ),
      style: Constants.sdFormText,
      cursorColor: Constants.myGrey,
      textInputAction: TextInputAction.next,
    );
  }

  TextFormField get _isbnField {
    return TextFormField(
      initialValue: widget.back.book.isbn,
      // validator: (value) {
      //   return _validationIsNullOrEmpty(value);
      // },
      onSaved: (value) => widget.back.book.isbn = value,
      decoration: const InputDecoration(
        labelText: 'ISBN',
        labelStyle: Constants.sdFormTitle,
        hintText: 'Informe o valor do ISBN',
        hintStyle: Constants.sdFormHint,
        focusedBorder: Constants.sdFormFocusedDorder,
      ),
      style: Constants.sdFormText,
      cursorColor: Constants.myGrey,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _formatoSelect() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Formato:"),
            DropdownButtonHideUnderline(
              child: DropdownButton(
                hint: Text(BookFormatType.pocketBook.description),
                value: widget.back.book.format,
                items: BookFormatType.values
                    .map((format) => DropdownMenuItem(
                          child: Text(
                            format.description,
                            style: Constants.sdFormText,
                          ),
                          value: format,
                        ))
                    .toList(),
                onChanged: (value) =>
                    setState(() => widget.back.book.format = value),
                dropdownColor: Constants.bgColorDialogsLigth,
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

  Widget get _genreField {
    return FutureBuilder(
      future: widget.back.findAllGenre(),
      builder: (context, result) {
        if (!result.hasData) {
          return const CircularProgressIndicator();
        }
        List<Genre> resultData = result.data;

        return MultiSelectDialogField(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 0.8,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          initialValue: widget.back.book.genres,
          // validator: (value) {
          //   return _validationIsNullOrEmpty(value);
          // },
          buttonIcon: Icon(
            Icons.arrow_drop_down,
            color: Colors.grey.shade700,
          ),
          searchable: true,
          searchHint: 'Pesquisar',
          buttonText: const Text('Gênero:', textAlign: TextAlign.left),
          cancelText: const Text('Cancelar'),
          confirmText: const Text(
            'Aplicar',
            style: TextStyle(color: Constants.myOrange),
          ),
          title: const Text('Gênero'),
          closeSearchIcon: const Icon(Icons.search_off),
          onSaved: (value) => widget.back.book.genres = value,
          items: resultData
              .map((genre) => MultiSelectItem(genre.id, genre.name))
              .toList(),
          listType: MultiSelectListType.CHIP,
          onConfirm: (value) {
            setState(() => widget.back.book.genres = value);
          },
        );
      },
    );
  }

  // Widget get _publicationDateField {
  //   return Column(
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(
  //             "Publicação: ${CommonService.formattedDate(widget.back.book.publicationDate)}",
  //             style: Constants.sdFormText,
  //           ),
  //           GestureDetector(
  //             onTap: () {
  //               showDatePicker(
  //                 context: context,
  //                 initialDate:
  //                     widget.back.book.publicationDate ?? DateTime.now(),
  //                 firstDate: DateTime(1950),
  //                 lastDate: DateTime(2222),
  //               ).then((value) {
  //                 if (value != null) {
  //                   setState(() {
  //                     widget.back.book.publicationDate = value;
  //                   });
  //                 }
  //               });
  //             },
  //             child: Icon(
  //               Icons.date_range,
  //               // color: Constants.myOrange,
  //             ),
  //           ),
  //         ],
  //       ),
  //       Divider(
  //         thickness: 1,
  //         color: Colors.grey.shade700,
  //       ),
  //     ],
  //   );
  // }

  TextFormField get _pagesField {
    return TextFormField(
      initialValue: widget.back.book.pages.toString(),
      // validator: (value) {
      //   return _validationIsNullOrEmpty(value);
      // },
      onSaved: (value) => widget.back.book.pages = int.parse(value),
      decoration: const InputDecoration(
        labelText: 'Páginas',
        labelStyle: Constants.sdFormTitle,
        hintText: 'Informe a quantidade de páginas',
        hintStyle: Constants.sdFormHint,
        focusedBorder: Constants.sdFormFocusedDorder,
      ),
      style: Constants.sdFormText,
      cursorColor: Constants.myGrey,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
    );
  }

  Widget get _languageSelect {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Idioma:"),
            DropdownButtonHideUnderline(
              child: DropdownButton(
                  hint: Text(BookLanguageType.portuguese.description),
                  value: widget.back.book.language,
                  items: BookLanguageType.values
                      .map((language) => DropdownMenuItem(
                            child: Text(
                              language.description,
                              style: Constants.sdFormText,
                            ),
                            value: language,
                          ))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => widget.back.book.language = value),
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
  }

  TextFormField get _serieField {
    return TextFormField(
      initialValue: widget.back.book.serie,
      // validator: (value) {
      //   return _validationIsNullOrEmpty(value);
      // },
      onSaved: (value) => widget.back.book.serie = value,
      decoration: const InputDecoration(
        labelText: 'Série:',
        labelStyle: Constants.sdFormTitle,
        hintText: 'Informe a série',
        hintStyle: Constants.sdFormHint,
        focusedBorder: Constants.sdFormFocusedDorder,
      ),
      style: Constants.sdFormText,
      cursorColor: Constants.myGrey,
      textInputAction: TextInputAction.next,
    );
  }

  TextFormField get _volumeField {
    return TextFormField(
      initialValue: widget.back.book.volume.toString(),
      // validator: (value) {
      //   return _validationIsNullOrEmpty(value);
      // },
      onSaved: (value) => widget.back.book.volume = int.parse(value),
      decoration: const InputDecoration(
        labelText: 'Volume:',
        labelStyle: Constants.sdFormTitle,
        hintText: 'Informe o Volume do livro',
        hintStyle: Constants.sdFormHint,
        focusedBorder: Constants.sdFormFocusedDorder,
      ),
      style: Constants.sdFormText,
      cursorColor: Constants.myGrey,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
    );
  }

  TextFormField get _descriptionField {
    return TextFormField(
      initialValue: widget.back.book.description,
      // validator: (value) {
      //   return _validationIsNullOrEmpty(value);
      // },
      onSaved: (value) => widget.back.book.description = value,
      decoration: const InputDecoration(
        labelText: "Descrição:",
        // border: OutlineInputBorder(),
        labelStyle: Constants.sdFormTitle,
        hintText: 'Escreva a descrição do livro aqui',
        hintStyle: Constants.sdFormHint,
        focusedBorder: Constants.sdFormFocusedDorder,
      ),
      style: Constants.sdFormText,
      cursorColor: Constants.myGrey,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.multiline,
      minLines: 4,
      maxLines: 4,
    );
  }
}
