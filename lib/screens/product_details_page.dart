import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/shop_provider.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final shop = Provider.of<ShopProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F2ED),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4A3428)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          
          IconButton(
            icon: Icon(
              product.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: product.isFavorite ? Colors.red : const Color(0xFF4A3428),
            ),
            onPressed: () => shop.toggleFavoriteStatus(product.id),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center( 
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.width * 0.75,
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: AssetImage(product.imageUrl),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 10))
                  ],
                ),
              ),
            ),
            Text(
              product.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF4A3428)),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${product.price}',
              style: const TextStyle(fontSize: 24, color: Color(0xFFC66B3D), fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                product.description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.brown, height: 1.6),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC66B3D),
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 0,
                ),
                onPressed: () {
                  shop.addToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('تمت إضافة القطعة إلى حقيبتك', textAlign: TextAlign.center),
                      backgroundColor: const Color(0xFF4A3428),
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.all(50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: const Text('إضافة إلى السلة', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}