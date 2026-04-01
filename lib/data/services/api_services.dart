import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oytra_app/data/models/product.dart';

class ProductService {
  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/Amrut-03/oytra_product_api/refs/heads/main/products.json'));

    final List data = jsonDecode(response.body);
    return data.map((e) => Product.fromJson(e)).toList();
  }
}