import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/category_model.dart';

class CategoryService {
  static Future<List<dynamic>> getCategories(String page) async {
    var apiUrl =
        Uri.parse('http://192.168.100.191:8000/api/category?page=' + page);
    final sharedPref = await SharedPreferences.getInstance();
    final token = sharedPref.getString('token');

    List<Category> categories = [];
    List<dynamic> categoryServices = [];

    var response = await http.get(
      apiUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      List<dynamic> listCategories =
          (jsonObject as Map<String, dynamic>)['data'];

      var page = (jsonObject as Map<String, dynamic>)['meta'];

      List listPage = page.values.toList();

      for (var category in listCategories) {
        categories.add(Category.fromMap(category));
      }

      categoryServices.add(categories);
      categoryServices.add(listPage[2]);
    }

    return categoryServices;
  }

  static Future requestAddCategory(String name) async {
    var apiUrl = Uri.http('192.168.100.191:8000', '/api/category');

    final sharedPref = await SharedPreferences.getInstance();
    final token = sharedPref.getString('token');

    final response = await http.post(
      apiUrl,
      headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*",
        "Authorization": "Bearer $token",
      },
      body: {
        "name": name,
      },
    );

    return response;
  }
}
