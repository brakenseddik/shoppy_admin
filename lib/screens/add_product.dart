import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../db/category.dart';
import '../db/brand.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];
  String _currentCategory;
  String _currentBrand;

  List<String> availableSizes = <String>[];

  File _fileImage1;
  File _fileImage2;
  File _fileImage3;

  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;

  @override
  void initState() {
    _getCategories();
    _getBrands();
  }

  getCategoriesDropdown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < categories.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
                child: Text(categories[i]['category']),
                value: categories[i].data['category']));
      });
    }
    return items;
  }

  getBrandsDropdown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < brands.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
                child: Text(brands[i]['brand']),
                value: brands[i].data['brand']));
      });
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: white,
        leading: Icon(
          Icons.close,
          color: black,
        ),
        title: Text(
          "add product",
          style: TextStyle(color: black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                        borderSide: BorderSide(
                            color: grey.withOpacity(0.5), width: 2.5),
                        onPressed: () {
                          selectImage(
                              ImagePicker.pickImage(
                                  source: ImageSource.gallery),
                              1);
                        },
                        child: _displayChild1(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                          borderSide: BorderSide(
                              color: grey.withOpacity(0.5), width: 2.5),
                          onPressed: () {
                            selectImage(
                                ImagePicker.pickImage(
                                    source: ImageSource.gallery),
                                2);
                          },
                          child: _displayChild2()),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                          borderSide: BorderSide(
                              color: grey.withOpacity(0.5), width: 2.5),
                          onPressed: () {
                            selectImage(
                                ImagePicker.pickImage(
                                    source: ImageSource.gallery),
                                3);
                          },
                          child: _displayChild3()),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'enter a product name with 10 characters at maximum',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: red, fontSize: 12),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: productNameController,
                  decoration: InputDecoration(hintText: 'Product name'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'You must enter the product name';
                    } else if (value.length > 10) {
                      return 'Product name cant have more than 10 letters';
                    }
                  },
                ),
              ),

//              select category
              Row(
                children: <Widget>[
                  Padding(
                    child: Text(
                      'Category:',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                    padding: EdgeInsets.all(8),
                  ),
                  DropdownButton(
                    value: _currentCategory,
                    onChanged: changeSelectedCategory,
                    items: categoriesDropDown,
                  ),
                  Padding(
                    child: Text(
                      'Brand:',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                    padding: EdgeInsets.all(8),
                  ),
                  DropdownButton(
                    value: _currentBrand,
                    onChanged: changeSelectedBrand,
                    items: brandsDropDown,
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: productNameController,
                  decoration: InputDecoration(hintText: 'Quantity'),
                  keyboardType: TextInputType.numberWithOptions(),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'You must enter the QTE';
                    } else if (value.length > 10) {
                      return 'Product name cant have more than 10 letters';
                    }
                  },
                ),
              ),

              Padding(
                child: Text(
                  'Available Sizes',
                  style: TextStyle(color: Colors.redAccent),
                ),
                padding: EdgeInsets.all(12),
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                      value: availableSizes.contains('XS'),
                      onChanged: (value) => changeSelectedSize('XS')),
                  Text('XS'),
                  Checkbox(
                      value: availableSizes.contains('S'),
                      onChanged: (value) => changeSelectedSize('S')),
                  Text('S'),
                  Checkbox(
                      value: availableSizes.contains('M'),
                      onChanged: (value) => changeSelectedSize('M')),
                  Text('M'),
                  Checkbox(
                      value: availableSizes.contains('L'),
                      onChanged: (value) => changeSelectedSize('L')),
                  Text('L'),
                  Checkbox(
                      value: availableSizes.contains('XL'),
                      onChanged: (value) => changeSelectedSize('XL')),
                  Text('XL'),
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                      value: availableSizes.contains('28'),
                      onChanged: (value) => changeSelectedSize('28')),
                  Text('28'),
                  Checkbox(
                      value: availableSizes.contains('32'),
                      onChanged: (value) => changeSelectedSize('32')),
                  Text('32'),
                  Checkbox(
                      value: availableSizes.contains('34'),
                      onChanged: (value) => changeSelectedSize('34')),
                  Text('34'),
                  Checkbox(
                      value: availableSizes.contains('40'),
                      onChanged: (value) => changeSelectedSize('40')),
                  Text('40'),
                  Checkbox(
                      value: availableSizes.contains('43'),
                      onChanged: (value) => changeSelectedSize('43')),
                  Text('43'),
                ],
              ),
              /* Padding(
                padding: const EdgeInsets.all(8.0),
                child: TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                      autofocus: false,
                      decoration: InputDecoration(hintText: 'add category')),
                  suggestionsCallback: (pattern) async {
                    return await _categoryService.getSuggestions(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      leading: Icon(Icons.category),
                      title: Text(suggestion['category']),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    setState(() {
                      _currentCategory = suggestion['category'];
                    });
                  },
                ),
              ),*/
//            select brand
              /*  Padding(
                padding: const EdgeInsets.all(8.0),
                child: TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                      autofocus: false,
                      decoration: InputDecoration(hintText: 'add brand')),
                  suggestionsCallback: (pattern) async {
                    return await _brandService.getSuggestions(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      leading: Icon(Icons.category),
                      title: Text(suggestion['brand']),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    setState(() {
                      _currentBrand = suggestion['brand'];
                    });
                  },
                ),
              ),*/

              FlatButton(
                color: red,
                textColor: white,
                child: Text('add product'),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }

  _getCategories() async {
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    print(data.length);
    setState(() {
      categories = data;
      categoriesDropDown = getCategoriesDropdown();

      _currentCategory = categories[0].data['category'];
      print(categories.length);
    });
  }

  _getBrands() async {
    List<DocumentSnapshot> data = await _brandService.getBrands();
    print(data.length);
    setState(() {
      brands = data;
      brandsDropDown = getBrandsDropdown();

      _currentBrand = brands[0].data['brand'];
      print(brands.length);
    });
  }

  changeSelectedCategory(String selectedCategory) {
    setState(() => _currentCategory = selectedCategory);
  }

  changeSelectedBrand(String selectedBrand) {
    setState(() => _currentBrand = selectedBrand);
  }

  void changeSelectedSize(String size) {
    if (availableSizes.contains(size)) {
      setState(() {
        availableSizes.remove(size);
      });
    } else
      setState(() {
        availableSizes.add(size);
      });
  }

  selectImage(Future<File> pickImage, int number) async {
    File tempImage = await pickImage;
    switch (number) {
      case 1:
        setState(() {
          _fileImage1 = tempImage;
        });
        break;
      case 2:
        setState(() {
          _fileImage2 = tempImage;
        });
        break;
      case 3:
        setState(() {
          _fileImage3 = tempImage;
        });
        break;
    }
  }

  _displayChild1() {
    if (_fileImage1 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 40, 14, 40),
        child: Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Padding(
          padding: const EdgeInsets.fromLTRB(14, 40, 14, 40),
          child: Image.file(_fileImage1));
    }
  }

  _displayChild2() {
    if (_fileImage2 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 40, 14, 40),
        child: Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Padding(
          padding: const EdgeInsets.fromLTRB(14, 40, 14, 40),
          child: Image.file(_fileImage2));
    }
  }

  _displayChild3() {
    if (_fileImage3 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 40, 14, 40),
        child: Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Padding(
          padding: const EdgeInsets.fromLTRB(14, 40, 14, 40),
          child: Image.file(_fileImage3));
    }
  }
}
