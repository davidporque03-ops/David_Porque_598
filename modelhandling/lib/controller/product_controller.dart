import 'package:modelhandling/model/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

class ProductController {
  final supabase = Supabase.instance.client;
  // Get all product
  Future<List<Product>> getProducts() async {
    final data = await supabase.from('products').select();
    return data.map((item) => Product.fromMap(item)).toList();
  }

  // Add Product
  Future<void> addProduct(Product product) async {
    await supabase.from('products').insert(product.toMap());
  }

  // Delete product
  Future<void> deleteProduct(String id) async {
    await supabase.from('products').delete().eq('id', id);
  }

  //grand total for product
  double calculateGrandTotalItem(List<Product> products) {
    double grandtotal = 0;
    for (var product in products) {
      grandtotal += product.price * product.quantity;
    }
    return grandtotal;
  }

  //count total number of items
  int calculateTotalItems(List<Product> products) {
    int totalitems = 0;
    for (var item in products) {
      totalitems += item.quantity;
    }
    return totalitems;
  }
}
