import 'package:flutter/material.dart';
import 'package:paperless_canteen/models/models.dart';
import 'package:paperless_canteen/providers/foodItem.dart';
import 'package:paperless_canteen/screens/Bill/BillScreen.dart';
import 'package:provider/provider.dart';

import 'Components/CustomAppBar.dart';

class ViewBillsScreen extends StatefulWidget {
  const ViewBillsScreen({super.key});

  @override
  State<ViewBillsScreen> createState() => _ViewBillsScreenState();
}

class _ViewBillsScreenState extends State<ViewBillsScreen> {
  @override
  Widget build(BuildContext context) {
    final foodItemsData = Provider.of<FoodItems>(context);
    return Scaffold(
      body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ListView(
            children: [
              const CustomAppBar(),
              const CustomNavigationBar(),

              // Bills Heading
              _Heading(title: "All Bills"),

              if (foodItemsData.bills.isEmpty)
                const Center(
                    child: Text(
                  "No Bills Available",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black38),
                )),

              for (Bill bill in foodItemsData.bills) AvailableBill(bill: bill),

              const SizedBox(height: 15),

              _Heading(title: "Previous Orders"),

              if (foodItemsData.previousBills.isEmpty)
                const Center(
                  child: Text(
                    "No Previous Orders Available",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black38),
                  ),
                ),
              for (Bill bill in foodItemsData.previousBills)
                PreviousOrderBill(bill: bill),
              const SizedBox(height: 50),
            ],
          )),
    );
  }
}

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    bool orderNowSelected = false;
    bool profileSelected = false;
    bool viewBillsSelected = true;
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ListView(scrollDirection: Axis.horizontal, children: [
        const SizedBox(width: 30),
        ChoiceChip(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            label: Text("Order Now",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: orderNowSelected ? Colors.white : Colors.black)),
            selected: orderNowSelected,
            selectedColor: Colors.black,
            backgroundColor: Colors.white,
            side: const BorderSide(color: Colors.black, width: 1),
            onSelected: (bool selected) {
              Navigator.popUntil(
                context,
                (route) => Navigator.canPop(context),
              );
              Navigator.of(context).pushReplacementNamed("/home");
            }),
        const SizedBox(width: 10),
        ChoiceChip(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            label: Text("Orders",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: viewBillsSelected ? Colors.white : Colors.black)),
            selected: viewBillsSelected,
            selectedColor: Colors.black,
            backgroundColor: Colors.white,
            side: const BorderSide(color: Colors.black, width: 1),
            onSelected: (bool selected) {
              if (selected) {
                Navigator.of(context).pushNamed("/view-bills");
              }
            }),
        const SizedBox(width: 10),
        ChoiceChip(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            label: Text("Profile",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: profileSelected ? Colors.white : Colors.black)),
            selected: profileSelected,
            selectedColor: Colors.black,
            backgroundColor: Colors.white,
            side: const BorderSide(color: Colors.black, width: 1),
            onSelected: (bool selected) {
              if (selected) {
                Navigator.of(context).pushNamed("/profile");
              }
            }),
      ]),
    );
  }
}

class _Heading extends StatelessWidget {
  _Heading({
    Key? key,
    required this.title,
  }) : super(key: key);

  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 7, left: 36, bottom: 12),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
      ),
    );
  }
}

class AvailableBill extends StatefulWidget {
  AvailableBill({super.key, required this.bill});

  Bill bill;

  @override
  State<AvailableBill> createState() => _AvailableBillState();
}

class _AvailableBillState extends State<AvailableBill> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BillScreen(
              bill: widget.bill,
              isClaimed: false,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(left: 22, right: 22, bottom: 14),
        decoration: BoxDecoration(
          color: const Color(0xffFFFBF8),
          // color: Colors.black,
          borderRadius: BorderRadius.circular(24),
          border:
              Border.all(color: const Color.fromARGB(255, 255, 235, 213), width: 4),
        ),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 20),
                Column(
                  children: [
                    const SizedBox(height: 18),
                    SizedBox(
                      width: 62,
                      height: 57,
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xffFFC698),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Text(widget.bill.counterId.toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                )),
                          ),
                          Positioned(
                            top: 35,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: Colors.black, width: 1),
                              ),
                              child: const Text(
                                "Counter",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 11),
                    Text(
                      "${widget.bill.items.length} items",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bill from",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff4B2900).withOpacity(0.24),
                              ),
                            ),
                            Text(
                              widget.bill.dateTime,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),
                        Stack(
                          children: [
                            Positioned(
                              top: 3,
                              left: 3,
                              child: Container(
                                margin: const EdgeInsets.only(left: 3, top: 3),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 17,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xffFDC461),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                    "₹ ${widget.bill.totalPrice}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    )),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 5,
                              ),
                              margin: const EdgeInsets.only(right: 5, bottom: 5),
                              decoration: BoxDecoration(
                                color: const Color(0xffFFDA94),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: const Color(0xffFFC698),
                                  width: 3,
                                ),
                              ),
                              child:
                                  Text("₹ ${widget.bill.totalPrice}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      )),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    for (Item item in widget.bill.items) BillItem(item: item),
                    const SizedBox(height: 5),
                  ],
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 56),
                    Text(
                      "Tiffin",
                      style: TextStyle(
                        fontSize: 46,
                        fontFamily: "Spicy Chicken",
                        color: Colors.black12,
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
                SizedBox(width: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BillItem extends StatelessWidget {
  BillItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  Item item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffFFEBC3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Text(
            item.name,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 17),
          Text(
            "x ${item.itemCounter}",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xffD48120),
            ),
          ),
        ],
      ),
    );
  }
}

class PreviousBillItem extends StatelessWidget {
  PreviousBillItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  Item item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffE4E4E4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Text(
            item.name,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 17),
          Text(
            "x ${item.itemCounter}",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xff8A8A8A),
            ),
          ),
        ],
      ),
    );
  }
}

class PreviousOrderBill extends StatefulWidget {
  PreviousOrderBill({super.key, required this.bill});

  Bill bill;

  @override
  State<PreviousOrderBill> createState() => _PreviousOrderBillState();
}

class _PreviousOrderBillState extends State<PreviousOrderBill> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                BillScreen(bill: widget.bill, isClaimed: true),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(left: 22, right: 22, bottom: 14),
        decoration: BoxDecoration(
          color: const Color(0xffF8F8F8),
          // color: Colors.black,
          borderRadius: BorderRadius.circular(24),
          border:
              Border.all(color: const Color.fromARGB(255, 224, 224, 224), width: 4),
        ),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 20),
                Column(
                  children: [
                    const SizedBox(height: 18),
                    SizedBox(
                      width: 62,
                      height: 57,
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xffD4D4D4),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: const Text("4",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                )),
                          ),
                          Positioned(
                            top: 35,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: Colors.black, width: 1),
                              ),
                              child: const Text(
                                "Counter",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 11),
                    const Text(
                      "2 items",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bill from",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff4B2900).withOpacity(0.24),
                              ),
                            ),
                            const Text(
                              "12 Mar, 2023 12:24 PM",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.125,
                        ),
                        Stack(
                          children: [
                            Positioned(
                              top: 3,
                              left: 3,
                              child: Container(
                                margin: const EdgeInsets.only(left: 3, top: 3),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 17,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xff909090),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Text("₹ 100",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    )),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 5,
                              ),
                              margin: const EdgeInsets.only(right: 5, bottom: 5),
                              decoration: BoxDecoration(
                                color: const Color(0xffF8F8F8),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: const Color(0xff909090),
                                  width: 3,
                                ),
                              ),
                              child: const Text("₹ 100",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffE4E4E4),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Row(
                        children: [
                          Text(
                            "Ghee Roast",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 17),
                          Text(
                            "x 2",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff8A8A8A),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffE4E4E4),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Row(
                        children: [
                          Text(
                            "Ghee Roast",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 17),
                          Text(
                            "x 2",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff8A8A8A),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 56),
                    Text(
                      "Tiffin",
                      style: TextStyle(
                        fontSize: 46,
                        fontFamily: "Spicy Chicken",
                        color: Colors.black12,
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
                SizedBox(width: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
