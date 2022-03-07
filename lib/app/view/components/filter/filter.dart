import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';
import 'package:projeto_integrador_app/app/domain/models/filter_model.dart';
import 'package:projeto_integrador_app/app/common/enums/filter/sort_filter_type.dart';
import 'package:projeto_integrador_app/app/common/enums/filter/status_filter_type.dart';
import 'package:projeto_integrador_app/app/common/enums/filter/sort_filter_avanced_type.dart';

class Filter extends StatefulWidget {
  const Filter({Key key}) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  FilterModel filterModel = FilterModel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, top: 10),
      child: Row(
        children: [
          OutlinedButton(
             onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext ctx) {
                  String title = filterModel.searchTitle;
                  String author = filterModel.searchAuthor;
                  String publishingCompany = filterModel.searchPublishingCompany;
                  return AlertDialog(
                    title: const Text('Filtro por livros'),
                    content: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return SizedBox(
                          width: 200,
                          height: 200,
                          child: Column(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  initialValue: title,
                                  onChanged: (value) => title = value,
                                  decoration: const InputDecoration(
                                    labelText: 'Título',
                                    hintText: 'Informe um título a ser filtrado',
                                  ),
                                  style: Constants.sdFormText,
                                  cursorColor: Constants.myGrey,
                                  textInputAction: TextInputAction.next,
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  initialValue: author,
                                  onChanged: (value) => author = value,
                                  decoration: const InputDecoration(
                                    labelText: 'Autor',
                                    hintText: 'Informe um autor a ser filtrado',
                                  ),
                                  style: Constants.sdFormText,
                                  cursorColor: Constants.myGrey,
                                  textInputAction: TextInputAction.next,
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  initialValue: publishingCompany,
                                  onChanged: (value) => publishingCompany = value,
                                  decoration: const InputDecoration(
                                    labelText: 'Editora',
                                    hintText: 'Informe uma editora a ser filtrado',
                                  ),
                                  style: Constants.sdFormText,
                                  cursorColor: Constants.myGrey,
                                  textInputAction: TextInputAction.next,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              child: const Text('Cancelar'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            ElevatedButton(
                              child: const Text('Aplicar'),
                              onPressed: () {
                                setState(() {
                                  filterModel.searchTitle = title;
                                  filterModel.searchAuthor = author;
                                  filterModel.searchPublishingCompany = publishingCompany;
                                });
                                Navigator.of(context).pop();
                              }
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: Row(
              children: [
                Icon(Icons.search, color: Theme.of(context).iconTheme.color),
                Text('Buscar', style: TextStyle(color: Theme.of(context).iconTheme.color)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          OutlinedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext ctx) {
                  StatusFilterType statusFilter = filterModel.status;
                  return AlertDialog(
                    title: const Text('Filtro por status'),
                    content: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return SizedBox(
                          width: 200,
                          height: 200,
                          child: Column(
                            children: StatusFilterType.values.map((type) {
                              return Row(
                                children: [
                                  Radio<StatusFilterType>(
                                    value: type,
                                    groupValue: statusFilter,
                                    onChanged: (StatusFilterType value) {
                                      setState(() {
                                        statusFilter = value;
                                      });
                                    },
                                  ),
                                  Text(type.description),
                                ],
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              child: const Text('Cancelar'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            ElevatedButton(
                              child: const Text('Aplicar'),
                              onPressed: () {
                                setState(() {
                                  filterModel.status = statusFilter;
                                });
                                Navigator.of(context).pop();
                              }
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: Row(
              children: [
                Icon(Icons.filter_alt, color: Theme.of(context).iconTheme.color),
                Text('Filtrar', style: TextStyle(color: Theme.of(context).iconTheme.color)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          OutlinedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext ctx) {
                  SortFilterAvancedType sortFilterAvanced = filterModel.sortAvanced;
                  SortFilterType sortFilter = filterModel.sort;
                  return AlertDialog(
                    title: const Text('Ordenação'),
                    content: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return SizedBox(
                          width: 200,
                          height: 280,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text("Ordenar por:"),
                              Column(
                                children: SortFilterAvancedType.values.map((type) {
                                  return Row(
                                    children: [
                                      Radio<SortFilterAvancedType>(
                                        value: type,
                                        groupValue: sortFilterAvanced,
                                        onChanged: (SortFilterAvancedType value) {
                                          setState(() {
                                            sortFilterAvanced = value;
                                          });
                                        },
                                      ),
                                      Text(type.description),
                                    ],
                                  );
                                }).toList(),
                              ),
                              const Text("Tipo de ordem:"),
                              Column(
                                children: SortFilterType.values.map((type) {
                                  return Row(
                                    children: [
                                      Radio<SortFilterType>(
                                        value: type,
                                        groupValue: sortFilter,
                                        onChanged: (SortFilterType value) {
                                          setState(() {
                                            sortFilter = value;
                                          });
                                        },
                                      ),
                                      Text(type.description),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              child: const Text('Cancelar'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            ElevatedButton(
                              child: const Text('Aplicar'),
                              onPressed: () {
                                setState(() {
                                  filterModel.sortAvanced = sortFilterAvanced;
                                  filterModel.sort = sortFilter;
                                });
                                Navigator.of(context).pop();
                              }
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: Row(
              children: [
                Icon(Icons.sort_by_alpha, color: Theme.of(context).iconTheme.color),
                Text('Ordenar', style: TextStyle(color: Theme.of(context).iconTheme.color)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}