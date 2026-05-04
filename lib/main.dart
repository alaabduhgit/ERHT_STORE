import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/shop_provider.dart';
import 'screens/home_page.dart';
import 'screens/favorites_page.dart';
import 'screens/cart_page.dart';
import 'screens/categories_page.dart';

void main() => runApp(ChangeNotifierProvider(create: (_) => ShopProvider(), child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // تم تغيير الثيم إلى الفاتح ليتناسب مع ألوان "إرث" الهادئة
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFF5F2ED)),
      home: MainNavigation()
    );
  }
}

class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _index = 0;
  final _pages = [HomePage(), FavoritesPage(), CartPage(), CategoriesPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        
        backgroundColor: const Color(0xFFF5F2ED),
        selectedItemColor: const Color(0xFFC66B3D), 
        unselectedItemColor: const Color(0xFF4A3428).withOpacity(0.5), 
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'المفضلة'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'السلة'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'الأقسام'),
        ],
      ),
    );
  }
}