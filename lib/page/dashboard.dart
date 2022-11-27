import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stisla/service/auth_service.dart';
import 'package:stisla/service/category_service.dart';

import '../models/category_model.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String? token;
  List<String> user = [];
  List<Category> categories = [];
  int selectedIndex = 0;
  int currentPage = 1;
  int lastPage = 0;

  Future<String> getToken() async {
    final sharedPref = await SharedPreferences.getInstance();

    String token = sharedPref.getString('token')!;

    return token;
  }

  Future<List<String>> getUser() async {
    final sharedPref = await SharedPreferences.getInstance();

    List<String> user = sharedPref.getStringList('user')!;

    return user;
  }

  fetchData() {
    CategoryService.getCategories(currentPage.toString()).then((resultList) {
      setState(() {
        categories = resultList[0];
        lastPage = resultList[1];
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getToken().then((value) {
      setState(() {
        token = value;
      });
    });

    getUser().then((value) {
      setState(() {
        user = value;
      });
    });

    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.data_array),
            label: 'Data',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_card_sharp),
            label: 'Add',
          ),
        ],
        selectedItemColor: const Color(0xff6777ef),
        currentIndex: selectedIndex,
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      body: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
          maxWidth: MediaQuery.of(context).size.width,
        ),
        decoration: const BoxDecoration(
          color: Color(0xff6777ef),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: 50.0,
                  right: 25.0,
                  left: 25.0,
                  bottom: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              Image.asset('assets/avatar-1.png').image,
                        ),
                        const Text(
                          'Dashboard',
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            AuthService.requestLogout().then((response) {
                              if (response.statusCode == 204) {
                                Navigator.pushNamed(context, '/login');
                              }
                            });
                          },
                          child: const Icon(
                            Icons.logout_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Hello, ',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              user[0],
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 4.0,
                          ),
                          child: Text(
                            user[1],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Column(
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 25.0,
                        ),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent:
                              MediaQuery.of(context).size.width / 2,
                          childAspectRatio: 2 / 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: categories.length,
                        itemBuilder: (context, index) => Container(
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
                                    child: Text(
                                      categories[index].name,
                                      style: const TextStyle(
                                        fontSize: 16.0,
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
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff6777ef),
                            ),
                            onPressed: currentPage == 1
                                ? null
                                : () {
                                    setState(() {
                                      currentPage--;
                                      fetchData();
                                    });
                                  },
                            child: const Text('Prev'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff6777ef),
                            ),
                            onPressed: currentPage == lastPage
                                ? null
                                : () {
                                    setState(() {
                                      currentPage++;
                                      fetchData();
                                    });
                                  },
                            child: const Text('Next'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
