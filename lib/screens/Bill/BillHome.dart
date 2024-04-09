import 'package:flutter/material.dart';
import 'package:paperless_canteen/screens/Panaroma/panaromaScreen.dart';
import 'package:provider/provider.dart';
import 'package:paperless_canteen/providers/foodItem.dart';
import 'package:paperless_canteen/models/models.dart';

class BillHomeScreen extends StatefulWidget {
  const BillHomeScreen({super.key});

  @override
  State<BillHomeScreen> createState() => _BillHomeScreenState();
}

class _BillHomeScreenState extends State<BillHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final foodItemsData = Provider.of<FoodItems>(context);
    List<int> counters = [];
    if (foodItemsData.cartItems.isNotEmpty) {
      for (Item item in foodItemsData.cartItems) {
        counters.add(item.counterId);
      }
    }
    print(counters);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bill Menu'),
        actions: [
          IconButton(
            onPressed: () {
              print('Help button pressed');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PanaromaScreen()),
              );
            },
            icon: const Icon(Icons.help),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: counters.contains(1)
                    ? () {
                        // TODO: Navigate to Counter 1 screen
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: const Text('Counter 1'),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: counters.contains(2)
                    ? () {
                        // TODO: Navigate to Counter 2 screen
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: const Text('Counter 2'),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: counters.contains(3)
                    ? () {
                        // TODO: Navigate to Counter 3 screen
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: const Text('Counter 3'),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: counters.contains(4)
                    ? () {
                        // TODO: Navigate to Counter 4 screen
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: const Text('Counter 4'),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: counters.contains(5)
                    ? () {
                        // TODO: Navigate to Counter 5 screen
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: const Text('Counter 5'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
