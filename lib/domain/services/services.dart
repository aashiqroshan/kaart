import 'dart:convert';
import 'package:http/http.dart' as http;

class Services {
  List<Map<String, dynamic>> categories = [];
  final baseUrl = Uri.parse('https://dummyjson.com/products');

  Future<void> getData() async {
    try {
      final response = await http.get(baseUrl);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        final Map<String, List> categorizedProducts = {};
        for (var product in data['products']) {
          final category = product['category'];
          if (!categorizedProducts.containsKey(category)) {
            categorizedProducts[category] = [];
          }
          categorizedProducts[category]!.add(product);
        }
        categories = categorizedProducts.entries
            .map(
              (entry) => {'name': entry.key, 'products': entry.value},
            )
            .toList();
      } else {
        print('Failed to load data. Status code == ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> updateProduct(
      int productId, Map<String, dynamic> updatedData) async {
    final url = Uri.parse('$baseUrl/$productId');

    final response = await http.put(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updatedData));

    if (response.statusCode != 200) {
      throw Exception('Failed to update product');
    }
  }
}
