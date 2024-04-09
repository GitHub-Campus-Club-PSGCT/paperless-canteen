import "package:flutter/material.dart";
import 'package:paperless_canteen/models/models.dart';
import 'package:paperless_canteen/providers/foodItem.dart';
import 'package:provider/provider.dart';

import '../Home/components/ItemCard.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchState();
}

class _SearchState extends State<SearchScreen> {
  List<Item> dishes = [];
  @override
  Widget build(BuildContext context) {
    final foodItemsData = Provider.of<FoodItems>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: SearchBody(
        allDishes: foodItemsData,
      ),
    );
  }
}

class SearchBody extends StatefulWidget {
  const SearchBody({super.key, required this.allDishes});

  final List<Item> allDishes;

  @override
  State<SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  final controller = TextEditingController();
  List<Item> dishes = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Dish name',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.grey, width: 1),
              ),
            ),
            onChanged: (query) {
              final suggestions = query.isEmpty
                  ? widget.allDishes
                  : widget.allDishes
                      .where((dish) =>
                          dish.name.toLowerCase().contains(query.toLowerCase()))
                      .toList();
              setState(() => dishes = suggestions);
            },
          ),
        ),
        Expanded(
          //Display the item cards two in a row using a grid list
          child: GridView.count(
            mainAxisSpacing: 20,
            crossAxisCount: 2,
            childAspectRatio: 0.9,
            children: List.generate(dishes.length, (index) {
              return itemCardConstructor(dishes[index]);
            }),
          ),
        ),
      ],
    );
  }
}
