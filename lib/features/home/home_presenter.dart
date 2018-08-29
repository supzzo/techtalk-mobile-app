import 'package:techtalk_mobile_app/di/injection.dart';
import 'package:techtalk_mobile_app/features/home/home_contract.dart';
import 'package:techtalk_mobile_app/model/post.dart';
import 'package:techtalk_mobile_app/repository/get_posts_contract.dart';

class HomePresenter {
  HomeContract _view;

  GetPostsRepositoryContract _repository;

  HomePresenter(this._view) {
    _repository = Injector().postRepository;
  }

  void loadPosts(int categoryId, int page) async {
    assert(_view != null);

    try {
      List<Post> _posts = await _repository
          .fetchByCategories(categories: [categoryId], page: page);

      _view.onSuccess(_posts);
    } catch (error) {
      _view.onError(error);
    }
  }
}
