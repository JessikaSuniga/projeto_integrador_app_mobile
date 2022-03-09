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
    this.searchTitle = "",
    this.searchAuthor = "",
    this.searchPublishingCompany = "",
  });

  String get filter {
    var string = "";

    if (searchTitle != null && searchTitle != "") {
      string += "AND title like '%$searchTitle%' ";
    }
    if (searchAuthor != null && searchAuthor != "") {
      string += "AND author like '%$searchAuthor%' ";
    }
    if (searchPublishingCompany != null && searchPublishingCompany != "") {
      string += "AND publishing_company like '%$searchPublishingCompany%' ";
    }

    if (status != StatusFilterType.all) {
      string += "AND status = '${status.cod}' ";
    }

    string += "ORDER BY ${sortAvanced.cod} ";

    if (sort == SortFilterType.descending) {
      string += "DESC";
    }

    return string;
  }
}
