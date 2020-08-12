import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopadmin/providers/app_states.dart';
import 'package:shopadmin/providers/products_provider.dart';
import 'package:shopadmin/screens/dashboard.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: AppState()),
      ChangeNotifierProvider.value(value: ProductProvider()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Dashboard(),
    ),
  ));
}
