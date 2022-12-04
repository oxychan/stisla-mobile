import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../models/category_model.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.alertContext,
    required this.category,
    required this.deleteData,
  });

  final BuildContext alertContext;
  final Category category;
  final Function deleteData;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(8.0),
            onPressed: (context) async {
              if (await confirm(
                alertContext,
                textOK: const Text('Delete'),
                textCancel: const Text('Cancel'),
                title: const Text('Delete'),
                content: const Text('Are you sure to delete this item?'),
              )) {
                deleteData(category);
              }
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete_forever_rounded,
          ),
          SlidableAction(
            borderRadius: BorderRadius.circular(8.0),
            onPressed: (context) {
              Navigator.pushNamed(
                context,
                '/detail-category',
                arguments: Category(id: category.id, name: category.name),
              );
            },
            backgroundColor: const Color(0xff6777ef),
            foregroundColor: Colors.white,
            icon: Icons.mode_edit_outline_rounded,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff6777ef).withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 9,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Image(
                image: const AssetImage('assets/stisla.png'),
                width: MediaQuery.of(context).size.width / 4,
              ),
            ),
            const SizedBox(
              width: 25.0,
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0)),
                ),
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      category.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
