import 'package:techtalk_mobile_app/model/post.dart';

abstract class PostContract {
  void onSuccess(Post post);
  void onError(dynamic error);
}
