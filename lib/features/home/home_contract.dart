import 'package:techtalk_mobile_app/model/post.dart';

abstract class HomeContract {
  void onSuccess(List<Post> posts);
  void onError(dynamic error);
}
