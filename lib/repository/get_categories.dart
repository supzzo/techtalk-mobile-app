import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:techtalk_mobile_app/model/category.dart';
import 'package:techtalk_mobile_app/repository/get_categories_contract.dart';
import 'package:techtalk_mobile_app/util/fetch_data_exception.dart';

class GetCategoriesRepository implements GetCategoriesRepositoryContract {
  static const url = 'https://techtalk.vn/wp-json/wp/v2/categories';

  @override
  Future<List<Category>> fetchCategories() async {
    final http.Response _response = await http.get(url);

    if (_response.statusCode != 200) {
      throw FetchDataException('Không lấy được danh mục.');
    }

    return (json.decode(_response.body) as List)
        .map((raw) => Category.fromMap(raw))
        .toList();
  }
}
