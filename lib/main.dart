import 'package:flutter/material.dart';
import 'package:viva_2/screen/homepage.dart';


void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
      },
    ),
  );
}