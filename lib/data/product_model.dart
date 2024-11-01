

class ProductModel  {
  final String id;
  final String title;
  final String description;
  final double price;
  final int stock;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.stock,
  });
  


  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      stock: json['stock'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'stock': stock,
    };
  }
}
