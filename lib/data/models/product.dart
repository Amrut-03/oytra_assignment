class Product {
  final String name;
  final double price;
  final int moq;

  Product({
    required this.name,
    required this.price,
    required this.moq,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      price: json['price'].toDouble(),
      moq: json['moq'],
    );
  }
}