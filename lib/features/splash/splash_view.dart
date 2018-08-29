import 'package:flutter/material.dart';

import 'package:techtalk_mobile_app/features/splash/splash_contract.dart';
import 'package:techtalk_mobile_app/features/splash/splash_presenter.dart';
import 'package:techtalk_mobile_app/features/home/home_view.dart';
import 'package:techtalk_mobile_app/model/category.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> implements SplashContract {
  SplashPresenter _presenter;

  _SplashViewState() {
    _presenter = SplashPresenter(this);
  }

  @override
  void initState() {
    super.initState();

    _presenter.loadCategories();
  }

  @override
  void onSuccess(List<Category> categories) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomeView(categories)),
    );
  }

  @override
  void onError(error) {
    print(error);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Image.asset(
            'images/logo.png',
            width: 250.0,
          ),
        ),
      ),
    );
  }
}
