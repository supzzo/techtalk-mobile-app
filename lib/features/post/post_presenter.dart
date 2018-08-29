import 'package:techtalk_mobile_app/di/injection.dart';
import 'package:techtalk_mobile_app/features/post/post_contract.dart';
import 'package:techtalk_mobile_app/model/post.dart';
import 'package:techtalk_mobile_app/repository/get_posts_contract.dart';

class PostPresenter {
  PostContract _view;

  GetPostsRepositoryContract _repository;

  PostPresenter(this._view) {
    _repository = Injector().postRepository;
  }

  void loadPost(int postId) async {
    assert(_view != null);

    try {
      Post _post = await _repository.fetchPost(postId);

      _view.onSuccess(_post);
    } catch (error) {
      _view.onError(error);
    }
  }
}
