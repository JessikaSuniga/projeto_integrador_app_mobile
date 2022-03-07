import 'package:projeto_integrador_app/app/common/enums/filter/sort_filter_avanced_type.dart';
import 'package:projeto_integrador_app/app/common/enums/filter/sort_filter_type.dart';
import 'package:projeto_integrador_app/app/common/enums/filter/status_filter_type.dart';

class FilterModel {
  SortFilterAvancedType sortAvanced;
  SortFilterType sort;
  StatusFilterType status;
  String searchTitle;
  String searchAuthor;
  String searchPublishingCompany;

  FilterModel({
    this.sortAvanced = SortFilterAvancedType.title,
    this.sort = SortFilterType.ascending,
    this.status = StatusFilterType.all,
    this.searchTitle,
    this.searchAuthor,
    this.searchPublishingCompany,
  });
}
