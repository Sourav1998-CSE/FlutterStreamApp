import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Repository repository = Repository(); // Create a single instance

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(repository: repository), // Pass repository to home screen
    );
  }
}
