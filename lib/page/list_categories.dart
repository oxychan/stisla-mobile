import 'package:flutter/material.dart';
import 'package:stisla/service/category_service.dart';
import '../models/category_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:confirm_dialog/confirm_dialog.dart';

class ListCategories extends StatelessWidget {
  const ListCategories({
    Key? key,
    required this.categories,
    required this.currentPage,
    required this.lastPage,
    required this.alertContext,
  }) : super(key: key);

  final List<Category> categories;
  final int currentPage;
  final int lastPage;
  final BuildContext alertContext;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(
          flex: 1,
          child: Center(
            child: Text(
              'Categories Data',
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
          child: GridView.builder(
            // controller: scrollController,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 25.0,
            ),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
              childAspectRatio: 2 / 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 10,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) => Slidable(
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
                        content:
                            const Text('Are you sure to delete this item?'),
                      )) {
                        CategoryService.requestDelete(categories[index])
                            .then((response) => print(response.statusCode));
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
                        arguments: Category(
                            id: categories[index].id,
                            name: categories[index].name),
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
                              categories[index].name,
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
            ),
          ),
        ),
      ],
    );
  }
}
