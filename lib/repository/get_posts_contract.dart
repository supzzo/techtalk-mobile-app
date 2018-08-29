import 'dart:async';

import 'package:techtalk_mobile_app/model/post.dart';

abstract class GetPostsRepositoryContract {
  Future<List<Post>> fetchByCategories({List<int> categories, int page});
  Future<Post> fetchPost(int postId);
}
