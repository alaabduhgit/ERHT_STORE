import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:firebase_auth/firebase_auth.dart'; 
import '../models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class ShopProvider with ChangeNotifier {
  List<Product> _items = [];
  final Map<String, CartItem> _cartItems = {};
  List<String> _userFavIds = [];

  final CollectionReference _productsRef = 
      FirebaseFirestore.instance.collection('products');
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ShopProvider() {
    fetchAndStreamProducts();
    fetchAndStreamFavorites(); 
  }

  List<Product> get items => [..._items];

  List<CartItem> get cartItems => _cartItems.values.toList();

  List<Product> get favoriteItems {
    return _items.where((product) => _userFavIds.contains(product.id)).toList();
  }

  double get totalAmount {
    double total = 0.0;
    _cartItems.forEach((key, item) => total += item.product.price * item.quantity);
    return total;
  }

  bool isProductFavorite(String productId) {
    return _userFavIds.contains(productId);
  }

  void fetchAndStreamProducts() {
    _productsRef.snapshots().listen((snapshot) {
      _items = snapshot.docs.map((doc) => Product.fromDoc(doc)).toList();
      notifyListeners();
    });
  }

  void fetchAndStreamFavorites() {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        _userFavIds = [];
        notifyListeners();
        return;
      }

      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('userFavorites')
          .snapshots()
          .listen((snapshot) {
            _userFavIds = snapshot.docs.map((doc) => doc.id).toList();
            notifyListeners();
          });
    });
  }

  Future<void> toggleFavoriteStatus(String productId) async {
    final user = _auth.currentUser;
    if (user == null) return; 

    final favDocRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('userFavorites')
        .doc(productId);

    if (_userFavIds.contains(productId)) {
      await favDocRef.delete();
    } else {
      await favDocRef.set({'isFavorite': true});
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