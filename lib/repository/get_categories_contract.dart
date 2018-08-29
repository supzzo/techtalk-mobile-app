import 'dart:async';

import 'package:techtalk_mobile_app/model/category.dart';

abstract class GetCategoriesRepositoryContract {
  Future<List<Category>> fetchCategories();
}
