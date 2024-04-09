import 'package:flutter/material.dart';
import 'package:paperless_canteen/models/models.dart';
import 'package:paperless_canteen/providers/foodItem.dart';
import 'package:provider/provider.dart';

// class PaymentScreen extends StatefulWidget {
//   @override
//   _PaymentScreenState createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         alignment: Alignment.center,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("Payment Screen", style: TextStyle(fontSize: 20)),
//             SizedBox(height: 20),
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.pushReplacementNamed(context, "/view-bill");
//                 },
//                 child: Text("Go to Bill Screen",
//                     style: TextStyle(
//                         color: Colors.white, fontWeight: FontWeight.bold)),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.black,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(32.0),
//                   ),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool gpaySelected = false;
  bool psgIdSelected = false;
  @override
  Widget build(BuildContext context) {
    final foodItemsData = Provider.of<FoodItems>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // leadingWidth: 100,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Checkout",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),

        actions: [
          Container(
            alignment: Alignment.center,
            width: 46,
            height: 40,
            margin: const EdgeInsets.only(right: 32, top: 10),
            decoration: BoxDecoration(
              color: const Color(0xffFFC888),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Text(
              foodItemsData.cartItems.length.toString(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.only(top: 7, left: 36, bottom: 12),
            alignment: Alignment.centerLeft,
            child: const Text(
              "Cart",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
          ),
          for (Item item in foodItemsData.cartItems) CartItemCard(item: item),
          const SizedBox(height: 15),
          const BulkBookingComponent(),
          const _LineHeading(title: "pay using"),
          Row(
            children: [
              const SizedBox(width: 20),
              Expanded(
                child: PaymentModeSelectionButton(
                  title: "GPay",
                  imagePath: "assets/icons/GoogleIcon.png",
                  selected: gpaySelected,
                  onPressed: () {
                    setState(() {
                      gpaySelected = !gpaySelected;
                      psgIdSelected = false;
                      print(gpaySelected);
                    });
                  },
                ),
              ),
              Expanded(
                child: PaymentModeSelectionButton(
                  title: "PSG ID Card",
                  imagePath: "",
                  selected: psgIdSelected,
                  onPressed: () {
                    setState(() {
                      gpaySelected = false;
                      psgIdSelected = true;
                      print(psgIdSelected);
                    });
                  },
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 20),
          if (psgIdSelected)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 45),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Enter your PSG ID",
                  hintStyle: const TextStyle(
                    color: Colors.black26,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          const SizedBox(height: 10),
          const _LineHeading(title: "Total"),
          TotalComponent(
            items: foodItemsData.cartItems.length,
            total: foodItemsData.getCartTotal,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 21, horizontal: 38),
            height: 51,
            child: ElevatedButton(
              onPressed: () {
                foodItemsData.generateBill();
                Navigator.pushReplacementNamed(context, "/view-bills");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                "Order Now",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TotalComponent extends StatefulWidget {
  TotalComponent({super.key, required this.items, required this.total});

  int items;
  int total;

  @override
  State<TotalComponent> createState() => _TotalComponentState();
}

class _TotalComponentState extends State<TotalComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "TOTAL",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontFamily: "Cocogoose"),
              ),
              Text(
                "${widget.items} items",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black45,
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xffFFA841),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Text(
              "₹ ${widget.total}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentModeSelectionButton extends StatefulWidget {
  PaymentModeSelectionButton(
      {super.key,
      required this.title,
      this.imagePath = "",
      required this.selected,
      required this.onPressed});

  final String title;
  final bool selected;
  final String imagePath;
  Function onPressed;

  @override
  State<PaymentModeSelectionButton> createState() =>
      _PaymentModeSelectionButtonState();
}

class _PaymentModeSelectionButtonState
    extends State<PaymentModeSelectionButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 51,
        decoration: BoxDecoration(
          color: widget.selected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (widget.imagePath.isNotEmpty)
              Image(
                image: AssetImage(widget.imagePath),
                width: 25,
                height: 25,
              ),
            Text(widget.title,
                style: TextStyle(
                  color: widget.selected ? Colors.white : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                )),
          ],
        ),
      ),
    );
  }
}

class _LineHeading extends StatelessWidget {
  const _LineHeading({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
      child: Row(children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 16),
            height: 1,
            color: const Color(0xffE5E5E5),
          ),
        ),
        Text(
          title,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xffBDBDBD)),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 16),
            height: 1,
            color: const Color(0xffE5E5E5),
          ),
        ),
      ]),
    );
  }
}

class BulkBookingComponent extends StatefulWidget {
  const BulkBookingComponent({super.key});

  @override
  State<BulkBookingComponent> createState() => _BulkBookingComponentState();
}

class _BulkBookingComponentState extends State<BulkBookingComponent> {
  @override
  Widget build(BuildContext context) {
    return const Row();
  }
}

class CartItemCard extends StatefulWidget {
  CartItemCard({Key? key, required this.item}) : super(key: key);

  Item item;

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  @override
  Widget build(BuildContext context) {
    final foodItemsData = Provider.of<FoodItems>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 13),
      decoration: BoxDecoration(
        color: const Color(0xffFFFAF1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xff4B2900).withOpacity(0.08),
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Image(
                  image: AssetImage(widget.item.imagePath),
                  width: 55,
                  height: 55,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.category.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  Text(
                    widget.item.name,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  Text(
                    "₹ ${widget.item.price}",
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffF68122)),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xff4B2900),
                ),
                child: Text(
                  "₹ ${widget.item.price * widget.item.itemCounter}",
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffFBA10F)),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        foodItemsData.decrementItemCounter(widget.item.id);
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffFFFAF1),
                        border: Border.all(
                          color: const Color(0xff4B2900).withOpacity(0.48),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.remove,
                        color: Colors.black,
                        size: 15,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "x ${widget.item.itemCounter}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        foodItemsData.incrementItemCounter(widget.item.id);
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xff4B2900),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
