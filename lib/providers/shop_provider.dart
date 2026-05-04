import 'package:flutter/material.dart';
import '../models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class ShopProvider with ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: 'h1',
      title: 'سجاد منسوج يدوياً',
      description: 'سجاد تراثي فاخر محاك بأيدي أمهر الحرفيين، يتميز بنقوش هندسية أصيلة وألوان دافئة تعكس عبق الماضي.',
      price: 250,
      imageUrl: 'assets/images/p11.jpg',
      category: 'منسوجات'
    ),
    Product(
      id: 'h2',
      title: 'نول النسيج الخشبي',
      description: 'أداة النسيج التقليدية التي تُصنع منها أجمل القطع التراثية، قطعة فنية تجسد مهارة الحرفة اليدوية.',
      price: 450,
      imageUrl: 'assets/images/p12.jpg',
      category: 'منسوجات'
    ),
    Product(
      id: 'h3',
      title: 'مجموعة فخار مزخرف',
      description: 'ثلاث أوانٍ فخارية بتصاميم متنوعة ونقوش يدوية دقيقة، مثالية لتزيين منزلك بلمسة تراثية فريدة.',
      price: 85,
      imageUrl: 'assets/images/p3.jpg',
      category: 'فخاريات'
    ),
    Product(
      id: 'h4',
      title: 'فن التطريز اليدوي',
      description: 'لوحة فنية مطرزة بخيوط الحرير على قماش الكتان، تعبر عن الدقة والصبر في العمل اليدوي الأصيل.',
      price: 120,
      imageUrl: 'assets/images/p10.jpg',
      category: 'منسوجات'
    ),
    Product(
      id: 'h5',
      title: 'فازة خزفية زرقاء',
      description: 'فازة من الخزف المصقول بلون أزرق ملكي ونقوش إسلامية غائرة، قطعة تضفي فخامة على أي زاوية.',
      price: 150,
      imageUrl: 'assets/images/p1.jpg',
      category: 'فخاريات'
    ),
    Product(
      id: 'h6',
      title: 'جرة فخار طينية',
      description: 'جرة تقليدية مصنوعة من الطين النقي بأسلوب بدائي جميل، تستخدم للزينة أو لحفظ السوائل ببرودة طبيعية.',
      price: 45,
      imageUrl: 'assets/images/p2.jpg',
      category: 'فخاريات'
    ),
    Product(
      id: 'h7',
      title: 'مبخرة نحاسية منقوشة',
      description: 'مبخرة مصنوعة من النحاس الخالص مع غطاء مخرم ونقوش النخيل، مصممة لتوزيع البخور بشكل مثالي.',
      price: 95,
      imageUrl: 'assets/images/p8.jpg',
      category: 'نحاسيات'
    ),
    Product(
      id: 'h8',
      title: 'وسادة تراثية مطرزة',
      description: 'وسادة (خدادية) منسوجة يدوياً بنقوش بدوية وألوان ترابية، مزينة بشرابات قطنية على الزوايا.',
      price: 65,
      imageUrl: 'assets/images/p9.jpg',
      category: 'منسوجات'
    ),
    Product(
      id: 'h9',
      title: 'سوار فضي مرصع',
      description: 'سوار عريض من الفضة بنمط "الفيلغري" الدقيق، مرصع بأحجار الفيروز الزرقاء لإطلالة ملكية قديمة.',
      price: 320,
      imageUrl: 'assets/images/p6.jpg',
      category: 'نحاسيات'
    ),
    Product(
      id: 'h10',
      title: 'قلادة إرث الفضية',
      description: 'قلادة حصرية تحمل شعار "إرث" (ERTH) بالخط العربي، مصاغة من الفضة الخالصة لتكون ذكرى خالدة.',
      price: 180,
      imageUrl: 'assets/images/p7.jpg',
      category: 'نحاسيات'
    ),
    Product(
      id: 'h11',
      title: 'طبق فخاري بكلمات عربية',
      description: 'طبق فخاري يدوي مزين بنقوش النخيل في المنتصف ومحاط بخط عربي أنيق، يجمع بين فن الخط وفن الخزف التراثي.',
      price: 110,
      imageUrl: 'assets/images/p4.jpg',
      category: 'فخاريات'
    ),
    Product(
      id: 'h12',
      title: 'أقراط فضية "قطرة الندى"',
      description: 'أقراط من الفضة الخالصة مصممة على شكل قطرة، مزينة بنقوش عربية دقيقة وتفاصيل هندسية تعكس رقيّ الصياغة اليدوية.',
      price: 140,
      imageUrl: 'assets/images/p5.jpg',
      category: 'نحاسيات'
    ),
  ];

  final Map<String, CartItem> _cartItems = {};
  List<Product> get items => [..._items];

  List<CartItem> get cartItems => _cartItems.values.toList();

  List<Product> get favoriteItems => _items.where((p) => p.isFavorite).toList();
  double get totalAmount {
    double total = 0.0;
    _cartItems.forEach((key, item) => total += item.product.price * item.quantity);
    return total;
  }

  void toggleFavoriteStatus(String id) {
    final index = _items.indexWhere((p) => p.id == id);
    if (index >= 0) {
      _items[index].isFavorite = !_items[index].isFavorite;
      notifyListeners();
    }
  }

  void addToCart(Product product) {
    if (_cartItems.containsKey(product.id)) {
      _cartItems[product.id]!.quantity += 1;
    } else {
      _cartItems[product.id] = CartItem(product: product);
    }
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_cartItems.containsKey(id)) return;
    if (_cartItems[id]!.quantity > 1) {
      _cartItems[id]!.quantity -= 1;
    } else {
      _cartItems.remove(id);
    }
    notifyListeners();
  }

  void removeItemCompletely(String id) {
    _cartItems.remove(id);
    notifyListeners();
  }
}
