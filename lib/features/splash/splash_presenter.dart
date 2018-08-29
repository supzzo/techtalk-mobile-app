import 'package:techtalk_mobile_app/di/injection.dart';
import 'package:techtalk_mobile_app/features/splash/splash_contract.dart';
import 'package:techtalk_mobile_app/model/category.dart';
import 'package:techtalk_mobile_app/repository/get_categories_contract.dart';

class SplashPresenter {
  SplashContract _view;

  GetCategoriesRepositoryContract _repository;

  SplashPresenter(this._view) {
    _repository = Injector().categoryRepository;
  }

  void loadCategories() async {
    assert(_view != null);

    try {
      List<Category> _categories = await _repository.fetchCategories();

      _categories = _categories
          .where((Category category) =>
              category.slug != 'featured' && category.parent == 0)
          .toList();

      _categories.sort((a, b) => a.id.compareTo(b.id));

      _view.onSuccess(_categories);
    } catch (error) {
      _view.onError(error);
    }
  }
}
