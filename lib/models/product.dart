import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  static const String BRAND = 'brand';
  static const String CATEGORY = 'category';
  static const String COLORS = 'colors';
  static const String FEATURED = 'featured';
  static const String ID = 'id';
  static const String NAME = 'name';
  static const String PICTURE = 'picture';
  static const String PRICE = 'price';
  static const String QUANTITY = 'quantity';
  static const String SALE = 'sale';
  static const String SIZE = 'size';

  //Private variables
  String _name;
  String _brand;
  String _category;
  String _picture;
  String _id;
  double _price;
  int _quantity;
  List<String> _colors;
  List<String> _sizes;
  bool _sale;
  bool _featured;

  //getters
  String get brand => _brand;
  String get category => _category;
  String get name => _name;
  String get id => _id;
  String get picture => _picture;
  double get price => _price;
  int get quantity => _quantity;
  List<String> get colors => _colors;
  List<String> get sizes => _sizes;
  bool get featured => _featured;
  bool get sale => _sale;

  Product.fromSnapshot(DocumentSnapshot snapshot) {
    _featured = snapshot.data[FEATURED];
    _sale = snapshot.data[SALE];
    _sizes = snapshot.data[SIZE];
    _name = snapshot.data[NAME];
    _id = snapshot.data[ID];
    _brand = snapshot.data[BRAND];
    _category = snapshot.data[CATEGORY];
    _price = snapshot.data[PRICE];
    _picture = snapshot.data[PICTURE];
    _quantity = snapshot.data[QUANTITY];
    _colors = snapshot.data[COLORS];
  }
}
