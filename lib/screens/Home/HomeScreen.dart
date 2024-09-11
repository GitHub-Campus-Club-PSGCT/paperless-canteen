import 'package:flutter/material.dart';
import 'package:paperless_canteen/main.dart';
import 'package:paperless_canteen/providers/foodItem.dart';
import 'package:provider/provider.dart';

import '../../models/models.dart';
import 'components/CartPreview.dart';
import 'components/ItemCard.dart';
import '../Search/SearchScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool orderNowSelected = true;
  bool profileSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        primary: true,
        backgroundColor: const Color.fromARGB(255, 255, 237, 147),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 10),
            icon: const Image(
              image: AssetImage("assets/icons/drawerIcon.png"),
              width: 27,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: const Text(
          "PSG College of Technology",
          style: TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            child: IconButton(
              icon: const Image(
                image: AssetImage("assets/icons/searchIcon.png"),
                width: 36,
              ),
              onPressed: () {
                print("Search button pressed");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            ListView(
              children: [
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: const RangeMaintainingScrollPhysics(),
                      children: [
                        const SizedBox(width: 30),
                        ChoiceChip(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            label: Text("Order Now",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: orderNowSelected
                                        ? Colors.white
                                        : Colors.black)),
                            selected: orderNowSelected,
                            selectedColor: Colors.black,
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Colors.black, width: 1),
                            onSelected: (bool selected) {
                              setState(() {
                                orderNowSelected = selected;
                              });
                            }),
                        const SizedBox(width: 10),
                        ChoiceChip(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            label: Text("View Bills",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: profileSelected
                                        ? Colors.white
                                        : Colors.black)),
                            selected: profileSelected,
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            label: Text("Profile",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: profileSelected
                                        ? Colors.white
                                        : Colors.black)),
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
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(left: 30),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "THIRST-E",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2),
                  ),
                ),
                const BuildItemsWidget(),
                const SizedBox(height: 200)
              ],
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: const CartPreviewWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildItemsWidget extends StatelessWidget {
  const BuildItemsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemsData = Provider.of<FoodItems>(context);
    final items = itemsData.items;
    final tiffinitems =
        items.where((element) => element.category == "Tiffin").toList();
    final beverageitems =
        items.where((element) => element.category == "BEVERAGE").toList();
    final sandwichitems =
        items.where((element) => element.category == "SANDWICH").toList();
    return Column(
      children: [
        //ItemsCategory(title: "Tiffin", itemsList: tiffinitems),
        //const SizedBox(height: 10),
        ItemsCategory(title: "Juice", itemsList: beverageitems,),
        const SizedBox(width: 10),
        ItemsCategory(title: "Healthy", itemsList: sandwichitems),
        const SizedBox(height: 10)
      ],
    );
  }
}

// ignore: must_be_immutable
class ItemsCategory extends StatelessWidget {
  String title;
  List<Item> itemsList;

  ItemsCategory({Key? key, required this.itemsList, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CategorySubheadingWatermark(title: title),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 55),
            CategorySubheadingWidget(title: title),
            const SizedBox(height: 10),
            CardsListViewWidget(itemsList: itemsList),
          ],
        )
      ],
    );
  }
}

// ignore: must_be_immutable
class CardsListViewWidget extends StatelessWidget {
  List<Item> itemsList;

  CardsListViewWidget({Key? key, required this.itemsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 700,
      height: 210,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 40),
        itemCount: itemsList.length,
        physics: const PageScrollPhysics(),
        itemBuilder: (context, index) => itemCardConstructor(itemsList[index]),
      ),
    );
  }
}

class CategorySubheadingWatermark extends StatelessWidget {
  String title;

  CategorySubheadingWatermark({Key? key, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          color: Color(0xffE7E7E7),
          fontFamily: "Spicy Chicken",
          fontSize: 120,
          fontWeight: FontWeight.w400),
    );
  }
}

// ignore: must_be_immutable
class CategorySubheadingWidget extends StatelessWidget {
  CategorySubheadingWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 32),
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 17),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: Colors.black,
      ),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
  }
}
