import 'package:techtalk_mobile_app/model/category.dart';

abstract class SplashContract {
  void onSuccess(List<Category> categories);
  void onError(dynamic error);
}
