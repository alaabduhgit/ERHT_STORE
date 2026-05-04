import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/shop_provider.dart';
import 'product_details_page.dart';

class CategoriesPage extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {'name': 'فخاريات', 'img': 'assets/images/p3.jpg'},
    {'name': 'منسوجات', 'img': 'assets/images/p10.jpg'},
    {'name': 'نحاسيات', 'img': 'assets/images/p6.jpg'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F2ED),
      appBar: AppBar(title: const Text('الأقسام'), centerTitle: true, backgroundColor: const Color(0xFFF5F2ED), elevation: 0),
      body: GridView.builder(
        padding: const EdgeInsets.all(15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15, childAspectRatio: 1.0),
        itemCount: categories.length,
        itemBuilder: (ctx, i) => GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SubCategoryScreen(catName: categories[i]['name']!))),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(image: AssetImage(categories[i]['img']!), fit: BoxFit.cover),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.3),
                ),
                child: Center(
                  child: Text(categories[i]['name']!,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubCategoryScreen extends StatelessWidget {
  final String catName;
  SubCategoryScreen({required this.catName});
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ShopProvider>(context).items.where((p) => p.category == catName).toList();
    return Scaffold(
      backgroundColor: const Color(0xFFF5F2ED),
      appBar: AppBar(title: Text(catName), backgroundColor: const Color(0xFFF5F2ED), elevation: 0),
      body: GridView.builder(
        padding: const EdgeInsets.all(15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15, childAspectRatio: 0.75),
        itemCount: products.length,
        itemBuilder: (ctx, i) => GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailsPage(product: products[i]))),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Expanded(child: ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(20)), child: Image.asset(products[i].imageUrl, fit: BoxFit.cover, width: double.infinity))),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(products[i].title, style: const TextStyle(color: Color(0xFF4A3428), fontWeight: FontWeight.bold)),
                ),
                Text('\$${products[i].price}', style: const TextStyle(color: Color(0xFFC66B3D), fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

