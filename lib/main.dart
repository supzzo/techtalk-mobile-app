import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:techtalk_mobile_app/features/splash/splash_view.dart';

void main() => runApp(TechTalk());

class TechTalk extends StatelessWidget {
  TechTalk() {
    initializeDateFormatting('vi');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TechTalk',
      theme: ThemeData(
        primaryColor: Colors.black,
        fontFamily: 'Roboto Slab',
      ),
      home: SplashView(),
    );
  }
}
