import 'package:flutter/material.dart';
import 'package:stisla/models/category_model.dart';

class DetailCategory extends StatefulWidget {
  const DetailCategory({super.key});

  @override
  State<DetailCategory> createState() => _DetailCategoryState();
}

class _DetailCategoryState extends State<DetailCategory> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Category;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff6777ef),
        title: const Text('Detail Category'),
      ),
      body: Center(
        child: Text(args.name),
      ),
    );
  }
}
