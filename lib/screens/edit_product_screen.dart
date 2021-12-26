import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/products.dart';
import '../provider/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = 'edit-Product-Screen';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _editProduct =
      Product(id: null, imageUrl: '', title: '', description: '', price: 0);
  @override
  void dispose() {
    super.dispose();
    _imageUrlFocus.removeListener(_updateImageUrl);
    _imageUrlController.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
  }

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(_updateImageUrl);
  }

  var _isInit = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final id = ModalRoute.of(context).settings.arguments as String;
      if (id != null) {
        _editProduct = Provider.of<Products>(context).findById(id);
        _imageUrlController.text = _editProduct.imageUrl;
      }
    }
    _isInit = false;
  }

  void _updateImageUrl() {
    if (!_imageUrlFocus.hasFocus) {
      if (_imageUrlController.text.isEmpty ||
          !_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https') ||
          !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpeg')) {
        return;
      }

      setState(() {
        //used Just to build the whole ui
      });
    }
  }

  var _isLoading = false;
  Future<void> _saveForm() async {
    final bool valBool = _formKey.currentState.validate();
    if (!valBool) {
      return;
    }

    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editProduct.id == null) {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editProduct);
      } catch (error) {
        await showDialog<Null>(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('An error occured'),
                  content: Text('Something went wrong, check your connection!'),
                  actions: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary:Colors.black,elevation: 5 ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Okay!',
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                ));
      }
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .updateProduct(_editProduct);
      } catch (error) {
        await showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text('Error Message'),
                  content: Text('Something went wrong'),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Okay!')),
                  ],
                ));
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit/Add Your Product')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      TextFormField(
                        initialValue: _editProduct.title,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'This field cannot be empty.';
                          }
                          return null;
                        },
                        onSaved: (newValue) => _editProduct = Product(
                            title: newValue,
                            description: _editProduct.description,
                            price: _editProduct.price,
                            id: _editProduct.id,
                            imageUrl: _editProduct.imageUrl),
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_priceFocus);
                        },
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          labelText: 'Product Name',
                        ),
                      ),
                      TextFormField(
                        initialValue: _editProduct.price.toString(),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'This field cannot be empty.';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Enter Valid numbers.';
                          }
                          if ((double.parse(value)) <= 0) {
                            return 'Price cannot be zero.';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onSaved: (newValue) => _editProduct = Product(
                            title: _editProduct.title,
                            description: _editProduct.description,
                            price: double.parse(newValue),
                            id: _editProduct.id,
                            imageUrl: _editProduct.imageUrl),
                        focusNode: _priceFocus,
                        onFieldSubmitted: (_) => FocusScope.of(context)
                            .requestFocus(_descriptionFocus),
                        decoration: InputDecoration(
                          labelText: 'Product Price',
                        ),
                      ),
                      TextFormField(
                        initialValue: _editProduct.description,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'This field cannot be empty.';
                          }
                          if (value.length < 10) {
                            return 'Description is too short.';
                          }
                          return null;
                        },
                        onSaved: (newValue) => _editProduct = Product(
                            title: _editProduct.title,
                            description: newValue,
                            price: _editProduct.price,
                            id: _editProduct.id,
                            imageUrl: _editProduct.imageUrl),
                        focusNode: _descriptionFocus,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          labelText: 'Product Description',
                        ),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration:
                                BoxDecoration(border: Border.all(width: 1)),
                            child: _imageUrlController.text.isEmpty
                                ? const Center(child: Text('Image Preview'))
                                : FittedBox(
                                    fit: BoxFit.contain,
                                    child: Image.network(
                                        _imageUrlController.text)),
                          ),
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'This field cannot be empty.';
                                }
                                if (!value.startsWith('http') &&
                                    !value.startsWith('https')) {
                                  return 'Enter valid URL.';
                                }
                                if (!value.endsWith('.jpg') &&
                                    !value.endsWith('.png') &&
                                    !value.endsWith('.jpeg')) {
                                  return 'Enter valid URL..';
                                }
                                return null;
                              },
                              onSaved: (newValue) => _editProduct = Product(
                                  title: _editProduct.title,
                                  description: _editProduct.description,
                                  price: _editProduct.price,
                                  id: _editProduct.id,
                                  imageUrl: newValue),
                              textInputAction: TextInputAction.done,
                              controller: _imageUrlController,
                              decoration: const InputDecoration(
                                labelText: 'Image URL',
                              ),
                              onFieldSubmitted: (_) => _saveForm(),
                              focusNode: _imageUrlFocus,
                              keyboardType: TextInputType.url,
                            ),
                          ),
                        ],
                        // https://flutter.dev/assets/homepage/carousel/phone_bezel-467ab8d838e5e2d2d3f347f766173ccc365220223692215416e4ce7342f2212f.png
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.deepOrangeAccent[100]),
                              child: Text('Pick a default image',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              onPressed: () {
                                _imageUrlController.text =
                                    'https://logowik.com/content/uploads/images/flutter5786.jpg';
                              }),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.deepOrangeAccent[100]),
                              child: Text('Image Preview',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              onPressed: () {
                                _imageUrlController.text =
                                    'https://logowik.com/content/uploads/images/flutter5786.jpg';
                              }),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.deepOrangeAccent),
                          child: Text('Save Product',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          onPressed: () {
                            _saveForm();
                          }),
                    ],
                  )),
                ),
              ),
            ),
    );
  }
}
