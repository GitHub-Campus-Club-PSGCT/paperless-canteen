import 'package:flutter/material.dart';
import 'package:paperless_canteen/providers/foodItem.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import '../../../models/models.dart';

class ItemCard extends StatefulWidget {
  ItemCard(
      {required this.id,
      required this.name,
      required this.category,
      required this.price,
      required this.imagePath,
      required this.itemCounter,
      super.key});

  String id;
  String name;
  String category;
  int price;
  String imagePath;
  int itemCounter;
  @override
  State<ItemCard> createState() => _ItemCardState();
}

Widget itemCardConstructor(Item item) {
  var itemCard = ItemCard(
      id: item.id,
      name: item.name,
      category: item.category,
      price: item.price,
      imagePath: item.imagePath,
      itemCounter: item.itemCounter);

  return itemCard;
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    final foodItemsData = Provider.of<FoodItems>(context);
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 168,
        height: 210,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(widget.imagePath))),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: const SizedBox(
                      width: 28,
                      height: 76,
                      child: Image(
                          image: AssetImage(
                              "assets/images/counterRemoveImage.png")),
                    ),
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      setState(() {
                        if (widget.itemCounter > 0) {
                          foodItemsData.decrementItemCounter(widget.id);
                        }
                      });
                    },
                  ),
                  GestureDetector(
                    child: const SizedBox(
                      width: 28,
                      height: 76,
                      child: Image(
                          image:
                              AssetImage("assets/images/counterAddImage.png")),
                    ),
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      setState(() {
                        foodItemsData.incrementItemCounter(widget.id);
                      });
                    },
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 26),
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 9),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 120,
                            child: Text(
                              widget.name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 18),
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(33),
                              color: const Color.fromARGB(255, 86, 47, 0)),
                          child: Text(
                            "₹ ${widget.price}",
                            style: const TextStyle(
                                color: Color(0xffFFBC3A),
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                widget.itemCounter == 0
                    ? GestureDetector(
                        child: const AddButton(),
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          setState(() {
                            foodItemsData.incrementItemCounter(widget.id);
                          });
                        },
                      )
                    : CounterWidget(
                        itemCounter: widget.itemCounter,
                      )
              ],
            ),
          ],
        ));
  }
}

class AddButton extends StatelessWidget {
  const AddButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(33),
              color: Colors.white.withOpacity(0.95)),
          child: const Text(
            "ADD",
            style: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

class CounterWidget extends StatefulWidget {
  CounterWidget({required this.itemCounter, super.key});

  int itemCounter;
  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 55,
          width: 60,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 100,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black),
                  child: const Text(
                    "Added",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(33),
                    color: Colors.white.withOpacity(0.95)),
                child: Text(
                  "x ${widget.itemCounter}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

