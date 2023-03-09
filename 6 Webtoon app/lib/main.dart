import 'package:flutter/material.dart';
import 'package:webtoon/screens/home_screen.dart';
import 'package:webtoon/services/api_service.dart';

void main() {
  runApp(const App());
}


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }

}

