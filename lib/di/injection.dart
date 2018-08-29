import 'package:techtalk_mobile_app/repository/get_categories.dart';
import 'package:techtalk_mobile_app/repository/get_categories_contract.dart';
import 'package:techtalk_mobile_app/repository/get_posts.dart';
import 'package:techtalk_mobile_app/repository/get_posts_contract.dart';

class Injector {
  static final Injector _singleton = Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  GetCategoriesRepositoryContract get categoryRepository {
    return GetCategoriesRepository();
  }

  GetPostsRepositoryContract get postRepository {
    return GetPostsRepository();
  }
}
