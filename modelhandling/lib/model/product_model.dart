class Product {
  final String? id;
  final String name;
  final double price;
  final int quantity;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  // Calculate total
  double get total => price * quantity;

  // From database
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id']?.toString(),
      name: map['name'],
      price: double.parse(map['price'].toString()),
      quantity: int.parse(map['quantity'].toString()),
    );
  }

  // To database
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }
}
