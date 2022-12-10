import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stisla/models/category_model.dart';

import '../service/category_service.dart';

class EditCategory extends StatefulWidget {
  EditCategory({
    super.key,
    this.category,
  });

  Category? category;

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  final TextEditingController editTextController = TextEditingController();
  String? editCategoryError;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editTextController.text = widget.category!.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff6777ef),
        title: const Text('Edit Category'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30.0,
              horizontal: 24.0,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: editTextController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: "Category Name",
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.grey[600],
                      ),
                      errorText: editCategoryError,
                      errorStyle: const TextStyle(
                        fontSize: 16.0,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1.0),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        editCategoryError = null;
                      });
                    },
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.white,
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xff6777ef),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        side: const BorderSide(
                          color: Color(0xff6777ef),
                        ),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size.fromHeight(50),
                    ),
                  ),
                  onPressed: () {
                    CategoryService.requestUpdate(
                            widget.category!, editTextController.text)
                        .then((response) {
                      if (response.statusCode == 200) {
                        editTextController.clear();
                        Navigator.pushNamed(context, '/');
                      } else if (response.statusCode == 422) {
                        var jsonObj = json.decode(response.body);
                        var errors = jsonObj['errors'];
                        setState(() {
                          editCategoryError = errors['name'][0];
                        });
                      }
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Update",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
