import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String image;
  final String category;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      image: json['image'],
      category: json['category'],
    );
  }
}

class ProductRepository {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://fakestoreapi.com/products';

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await _dio.get(_baseUrl);
      return (response.data as List)
          .map((json) => Product.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<Product> fetchProductDetails(int id) async {
    try {
      final response = await _dio.get('$_baseUrl/$id');
      return Product.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load product details: $e');
    }
  }
}

// Riverpod Providers
final productRepositoryProvider = Provider((ref) => ProductRepository());

final productsProvider = FutureProvider<List<Product>>((ref) {
  final repository = ref.read(productRepositoryProvider);
  return repository.fetchProducts();
});

final favoriteProductsProvider = StateNotifierProvider<FavoriteProductsNotifier, Set<int>>((ref) {
  return FavoriteProductsNotifier();
});

class FavoriteProductsNotifier extends StateNotifier<Set<int>> {
  FavoriteProductsNotifier() : super({});

  void toggleFavorite(int productId) {
    if (state.contains(productId)) {
      state = Set.from(state)..remove(productId);
    } else {
      state = Set.from(state)..add(productId);
    }
  }
}