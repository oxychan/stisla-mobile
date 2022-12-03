import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stisla/service/category_service.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final TextEditingController categoryNameController = TextEditingController();

  String? categoryNameError;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(
          flex: 1,
          child: Center(
            child: Text(
              'Add Category',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xff6777ef),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Padding(
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
                    controller: categoryNameController,
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
                      errorText: categoryNameError,
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
                        categoryNameError = null;
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
                    CategoryService.requestAddCategory(
                            categoryNameController.text)
                        .then((response) {
                      if (response.statusCode == 201) {
                        categoryNameController.clear();
                        Navigator.pushNamed(context, '/');
                      } else if (response.statusCode == 422) {
                        var jsonObj = json.decode(response.body);
                        var errors = jsonObj['errors'];
                        setState(() {
                          categoryNameError = errors['name'][0];
                        });
                      }
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Add",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
