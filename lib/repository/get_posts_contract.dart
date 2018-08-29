import 'dart:async';

import 'package:techtalk_mobile_app/model/post.dart';

abstract class GetPostsRepositoryContract {
  Future<List<Post>> fetchPosts(int categoryId);
  Future<Post> fetchPost(int postId);
}
