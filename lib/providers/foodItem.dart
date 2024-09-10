import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:paperless_canteen/models/models.dart';

class FoodItems with ChangeNotifier {
  Item item0 = Item(
      name: "Watermelon",
      tamilName: "மா ஜூஸ்",
      category: "BEVERAGE",
      price: 10,
      counterId: 4,
      imagePath: "assets/images/blackbg.png",
      id: "1000",
      status: -1);
  Item item1 = Item(
      name: "Papaya",
      tamilName: "கவின்ஸ் மில்க்",
      category: "BEVERAGE",
      price: 35,
      counterId: 4,
      imagePath: "assets/images/blackbg.png",
      id: "1001",
      status: -1);
  Item item2 = Item(
      name: "Masala Dosa",
      tamilName: "நெய் ரோஸ்ட்",
      category: "Tiffin",
      price: 35,
      counterId: 4,
      imagePath: "assets/images/dosaImage.png",
      id: "1002",
      status: 10);
  Item item3 = Item(
      name: "Onion Dosa",
      tamilName: "நெய் ரோஸ்ட்",
      category: "Tiffin",
      price: 35,
      counterId: 4,
      imagePath: "assets/images/dosaImage.png",
      id: "1003",
      status: 1);
  Item item4 = Item(
      name: "Plain Dosa",
      tamilName: "நெய் ரோஸ்ட்",
      category: "Tiffin",
      price: 35,
      counterId: 4,
      imagePath: "assets/images/dosaImage.png",
      id: "1004",
      status: -1);
  Item item5 = Item(
      name: "Mango",
      tamilName: "எலுமிச்சை ஜூஸ்",
      category: "BEVERAGE",
      price: 15,
      counterId: 4,
      imagePath: "assets/images/blackbg.png",
      id: "1005",
      status: -1);
  Item item6 = Item(
      name: "Sprouts",
      tamilName: "கார்ன் சீஸ் சாண்ட்விச்",
      category: "SANDWICH",
      price: 55,
      counterId: 4,
      imagePath: "assets/images/blackbg.png",
      id: "1006",
      status: -1);
  Item item7 = Item(
      name: "Peanuts",
      tamilName: "பனீர் சாண்ட்விச்",
      category: "SANDWICH",
      price: 50,
      counterId: 4,
      imagePath: "assets/images/blackbg.png",
      id: "1007",
      status: -1);
  Item item8 = Item(
      name: "Corn",
      tamilName: "வெஜ் சாண்ட்விச்",
      category: "SANDWICH",
      price: 35,
      counterId: 4,
      imagePath: "assets/images/blackbg.png",
      id: "1008",
      status: -1);
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  final HashMap<String, Item> _itemMap = HashMap<String, Item>();
  final List<Item> _items = [];
  final List<Item> _cartItems = [];
  final List<Bill> _bills = [];
  final List<Bill> _previousBills = [];
  int _totalPrice = 0;
  int availableBillId = 1001;
  GoogleSignInAccount? _currentUser;

  FoodItems() {
    _itemMap[item0.id] = item0;
    _itemMap[item1.id] = item1;
    _itemMap[item2.id] = item2;
    _itemMap[item3.id] = item3;
    _itemMap[item4.id] = item4;
    _itemMap[item5.id] = item5;
    _itemMap[item6.id] = item6;
    _itemMap[item7.id] = item7;
    _itemMap[item8.id] = item8;

    _items.add(item0);
    _items.add(item1);
    _items.add(item2);
    _items.add(item3);
    _items.add(item4);
    _items.add(item5);
    _items.add(item6);
    _items.add(item7);
    _items.add(item8);
  }

  bool isUserLoggedIn() {
    return _currentUser != null;
  }

  void saveUser(GoogleSignInAccount user) {
    _currentUser = user;
  }

  GoogleSignInAccount? get getUser {
    return _currentUser;
  }

  void logoutUser() {
    _handleSignOut();
    _currentUser = null;
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  List<Item> get items {
    return [..._items];
  }

  List<Item> get cartItems {
    return [..._cartItems];
  }

  int get getCartTotal {
    return _totalPrice;
  }

  void addFoodItem(Item item) {
    if (_itemMap.containsKey(item.id)) {
      print("Item already exists");
      return;
    }
    _itemMap[item.id] = item;
    _items.add(item);

    notifyListeners();
  }

  void incrementItemCounter(String id) {
    if (!_itemMap.containsKey(id)) {
      print("Item cannot be incremented becuase it does not exist");
    }
    _itemMap[id]!.itemCounter++;
    if (_itemMap[id]!.itemCounter == 1) {
      _cartItems.add(_itemMap[id]!);
    }
    _totalPrice += _itemMap[id]!.price;
    notifyListeners();
  }

  void decrementItemCounter(String id) {
    if (!_itemMap.containsKey(id)) {
      print("Item cannot be decremented becuase it does not exist");
    }
    _itemMap[id]!.itemCounter--;
    if (_itemMap[id]!.itemCounter == 0) {
      _cartItems.remove(_itemMap[id]!);
    }
    _totalPrice -= _itemMap[id]!.price;
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    _totalPrice = 0;
    _itemMap.forEach((key, value) {
      value.itemCounter = 0;
    });
    notifyListeners();
  }

  void generateBill() {
    String dateTime = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}";

    List<Item> items = [];
    for (var element in _cartItems) {
      items.add(Item(
          name: element.name,
          tamilName: element.tamilName,
          category: element.category,
          price: element.price,
          counterId: element.counterId,
          imagePath: element.imagePath,
          id: element.id,
          itemCounter: element.itemCounter,
          status: element.status));
    }

    Bill bill = Bill(
        id: (availableBillId++).toString(),
        totalPrice: _totalPrice,
        items: items,
        counterId: 4,
        dateTime: dateTime);
    clearCart();
    _bills.add(bill);
  }

  List<Bill> get bills {
    return [..._bills];
  }

  List<Bill> get previousBills {
    return [..._previousBills];
  }

  void claimBill(Bill bill) {
    _bills.remove(bill);
    _previousBills.add(bill);
    notifyListeners();
  }

  void claimBillWithId({String? id}) {
    if (id == null) {
      return;
    }
    Bill bill = _bills.firstWhere((element) => element.id == id);
    _bills.remove(bill);
    _previousBills.add(bill);
    notifyListeners();
  }

  bool isNotClaimed({String? id}) {
    if (id == null) {
      return false;
    }
    return _bills.any((element) => element.id == id);
  }
}
