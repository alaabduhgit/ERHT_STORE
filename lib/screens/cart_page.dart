import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/shop_provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final shop = Provider.of<ShopProvider>(context);
    final cartItems = shop.cartItems;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F2ED),
      appBar: AppBar(
        title: const Text('حقيبة إرث', style: TextStyle(color: Color(0xFF4A3428))),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: cartItems.isEmpty
                ? const Center(child: Text('حقيبتك فارغة، ابدأ بالتسوق الآن!'))
                : ListView.builder(
                    padding: const EdgeInsets.all(15),
                    itemCount: cartItems.length,
                    itemBuilder: (ctx, i) => Card(
                      margin: const EdgeInsets.only(bottom: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(cartItems[i].product.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                        ),
                        title: Text(cartItems[i].product.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('\$${cartItems[i].product.price}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(icon: const Icon(Icons.remove_circle_outline), onPressed: () => shop.removeSingleItem(cartItems[i].product.id)),
                            Text('${cartItems[i].quantity}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            IconButton(icon: const Icon(Icons.add_circle_outline), onPressed: () => shop.addToCart(cartItems[i].product)),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(25),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('الإجمالي المستحق:', style: TextStyle(fontSize: 16)),
                    Text('\$${shop.totalAmount.toStringAsFixed(2)}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFC66B3D))),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC66B3D),
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: () {
                    if (cartItems.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('شكراً لثقتك بـ إرث! تم استلام طلبك بنجاح', textAlign: TextAlign.center),
                          backgroundColor: Colors.green[800],
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.all(50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                      );
                    }
                  },
                  child: const Text('إتمام الدفع', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
