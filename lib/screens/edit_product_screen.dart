import 'package:flutter/material.dart';

import '../widgets/edit_produt_body.dart';

class EditProductScreen extends StatelessWidget {
  static const routeName = 'edit-Product-Screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Your Product'),
      ),
      body: EditProductBody(),
    );
  }
}
