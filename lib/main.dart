import 'package:clocky_custom_app/views/clockview.dart';
import 'package:clocky_custom_app/views/homepage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ProviderScope(
          child: HomePage()),
    );
  }
}