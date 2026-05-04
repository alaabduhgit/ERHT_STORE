import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/shop_provider.dart';
import 'product_details_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ShopProvider>(context).items;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F2ED),
      appBar: AppBar(
        title: const Text('إرث', style: TextStyle(color: Color(0xFF4A3428), fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.78,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemCount: products.length,
        itemBuilder: (ctx, i) => GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailsPage(product: products[i]))),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
            ),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    child: Image.asset(products[i].imageUrl, fit: BoxFit.cover, width: double.infinity),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: Text(products[i].title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF4A3428))),
                ),
                Text('\$${products[i].price}', style: const TextStyle(color: Color(0xFFC66B3D), fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
