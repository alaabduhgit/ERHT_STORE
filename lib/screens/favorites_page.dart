import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/shop_provider.dart';
import 'product_details_page.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final shop = Provider.of<ShopProvider>(context);
    final favorites = shop.favoriteItems;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F2ED),
      appBar: AppBar(
        title: const Text('المفضلة', style: TextStyle(color: Color(0xFF4A3428), fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: const Color(0xFFF5F2ED),
        elevation: 0,
      ),
      body: favorites.isEmpty
          ? const Center(child: Text('لا توجد عناصر في المفضلة بعد', style: TextStyle(color: Color(0xFF4A3428))))
          : GridView.builder(
              padding: const EdgeInsets.all(15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: favorites.length,
              itemBuilder: (ctx, i) => GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ProductDetailsPage(product: favorites[i])),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                              child: Image.asset(favorites[i].imageUrl, fit: BoxFit.cover, width: double.infinity),
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: IconButton(
                                icon: const Icon(Icons.favorite, color: Colors.red),
                                onPressed: () => shop.toggleFavoriteStatus(favorites[i].id),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(favorites[i].title, style: const TextStyle(color: Color(0xFF4A3428), fontWeight: FontWeight.bold)),
                      ),
                      Text('\$${favorites[i].price}', style: const TextStyle(color: Color(0xFFC66B3D), fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}


