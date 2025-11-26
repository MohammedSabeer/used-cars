import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product.dart';

class ApiService {
  // Using FakeStore API (open source ecommerce API)
  static const String baseUrl = 'https://fakestoreapi.com';

  static Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        
        if (decodedBody is! List) {
          throw Exception('Unexpected response type: expected List');
        }
        
        final List<dynamic> jsonData = decodedBody;
        return jsonData
            .map((product) => Product.fromJson(product as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  static Future<Product?> fetchProductById(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/$id'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return Product.fromJson(jsonData);
      } else {
        throw Exception('Failed to load product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching product: $e');
    }
  }

  static Future<List<Product>> fetchProductsByCategory(
      String category) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/category/$category'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        
        // Handle both list and map responses
        List<dynamic> jsonData;
        if (decodedBody is List) {
          jsonData = decodedBody;
        } else if (decodedBody is Map) {
          // Fallback for unexpected map response
          return [];
        } else {
          throw Exception('Unexpected response type');
        }
        
        return jsonData
            .map((product) => Product.fromJson(product as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(
            'Failed to load products by category: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products by category: $e');
    }
  }

  static Future<List<String>> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/categories'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);
        
        if (decodedBody is! List) {
          throw Exception('Unexpected response type: expected List');
        }
        
        return decodedBody
            .map((e) => e.toString())
            .toList();
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }
}
