import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:techtalk_mobile_app/model/post.dart';
import 'package:techtalk_mobile_app/repository/get_posts_contract.dart';
import 'package:techtalk_mobile_app/util/fetch_data_exception.dart';

class GetPostsRepository implements GetPostsRepositoryContract {
  static const url = 'https://techtalk.vn/wp-json/wp/v2/posts';

  @override
  Future<List<Post>> fetchByCategories({List<int> categories, int page}) async {
    final http.Response _response = await http
        .get('$url?categories=${categories.join(',')}&page=$page&_embed');

    if (_response.statusCode != 200) {
      throw FetchDataException('Không lấy được danh sách bài viết.');
    }

    return (json.decode(_response.body) as List)
        .map((raw) => Post.fromMap(raw))
        .toList();
  }

  @override
  Future<Post> fetchPost(int postId) async {
    final http.Response _response = await http.get('$url/$postId?_embed');

    if (_response.statusCode != 200) {
      throw FetchDataException('Không lấy được bài viết.');
    }

    return Post.fromMap(json.decode(_response.body));
  }
}
