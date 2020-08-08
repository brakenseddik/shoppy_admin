import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

class ProductService {
  Firestore _firestore = Firestore.instance;
  String ref = 'products';

  // ignore: non_constant_identifier_names
  void UploadProduct(Map details) {
    var id = Uuid();
    String productId = id.v1();

    _firestore.collection(ref).document(productId).setData(details);
  }
}
