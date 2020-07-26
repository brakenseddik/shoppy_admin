import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController ProductNameController;
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  GlobalKey<FormState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.1,
        leading: Icon(
          Icons.close,
          color: black,
        ),
        title: Text(
          'Add Product',
          style: TextStyle(color: black),
        ),
      ),
      body: Form(
        key: _globalKey,
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlineButton(
                      onPressed: () {},
                      borderSide:
                          BorderSide(color: grey.withOpacity(0.8), width: 2),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 30, 8, 30),
                        child: Icon(
                          Icons.add,
                          color: grey,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlineButton(
                      onPressed: () {},
                      borderSide:
                          BorderSide(color: grey.withOpacity(0.8), width: 2),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 30, 8, 30),
                        child: Icon(
                          Icons.add,
                          color: grey,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlineButton(
                      onPressed: () {},
                      borderSide:
                          BorderSide(color: grey.withOpacity(0.8), width: 2),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 30, 8, 30),
                        child: Icon(
                          Icons.add,
                          color: grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Enter a product name',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: ProductNameController,
                decoration: InputDecoration(
                  hintText: 'Product name',
                  border: OutlineInputBorder(
                      borderSide: new BorderSide(color: grey)),
                ),
                validator: (value) {
                  if (value.isEmpty)
                    return 'you must enter a product name';
                  else if (value.length > 10) return 'product name too long';
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
