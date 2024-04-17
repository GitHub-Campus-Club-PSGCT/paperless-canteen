import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paperless_canteen/main.dart';
import 'package:paperless_canteen/models/models.dart';
import 'package:paperless_canteen/providers/foodItem.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:slide_to_act/slide_to_act.dart';

class BillScreen extends StatefulWidget {
  BillScreen({super.key, required this.bill, required this.isClaimed});

  Bill bill;
  bool isClaimed;

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  @override
  Widget build(BuildContext context) {
    final foodItemsData = Provider.of<FoodItems>(context);
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // leadingWidth: 100,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Bill",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
        leading: Builder(
          builder: (context) => Row(
            children: [
              IconButton(
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
              const SizedBox(width: 5),
            ],
          ),
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
              widget.bill.items.length.toString(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            child: Column(
              children: [
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.black,
                          size: 16,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "View all Bills",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color(0xffFBA10F),
                        borderRadius: BorderRadius.circular(43)),
                    child: Column(children: [
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "BILL",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              color: const Color(0xffFFFBF3),
                              borderRadius: BorderRadius.circular(43),
                              border: Border.all(
                                  color: const Color(0xff4B2900), width: 3)),
                          child: ListView(
                            children: [
                              const SizedBox(height: 23),
                              if (widget.bill.items.isNotEmpty)
                                for (Item item in widget.bill.items)
                                  BillCardWidget(item: item),
                              const SizedBox(height: 23),
                              QRCode(id: widget.bill.id),
                            ],
                          ),
                        ),
                      )
                    ]),
                  ),
                ),
              ],
            ),
          ),
          ClaimBillSection(bill: widget.bill, isClaimed: widget.isClaimed),
        ],
      ),
    );
  }
}

class QRCode extends StatelessWidget {
  QRCode({
    Key? key,
    required this.id,
  }) : super(key: key);

  String id;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.transparent,
      child: QrImage(
        data: id,
        version: QrVersions.auto,
        size: 150,
        gapless: false,
        errorStateBuilder: (cxt, err) {
          return Container(
            child: const Center(
              child: Text(
                "Uh oh! Something went wrong...",
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      ),
    );
  }
}

class BillCardWidget extends StatelessWidget {
  const BillCardWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      decoration: BoxDecoration(
          color: const Color(0xff4B2900).withOpacity(0.02),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: const Color(0xff321A00).withOpacity(0.06),
            width: 2,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const SizedBox(width: 17),
              ClipOval(
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(30)),
                child: Image(
                  width: 55,
                  height: 55,
                  image: AssetImage(item.imagePath),
                  fit: BoxFit.fitWidth,
                ),
              ),
              const SizedBox(width: 11),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.tamilName,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    item.name,
                    style: const TextStyle(
                        color: Color(0xff666666),
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              )
            ],
          ),
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      left: 2,
                      top: 2,
                    ),
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                        color: const Color(0xffFFF7ED),
                        border: Border.all(
                          color: const Color(0xffEB9531),
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(23)),
                  ),
                  Container(
                    width: 46,
                    height: 46,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: const Color(0xffFFF7ED),
                        border: Border.all(
                          color: const Color(0xffEB9531),
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(23)),
                    child: Text(
                      item.itemCounter.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 30),
            ],
          )
        ],
      ),
    );
  }
}

class ClaimBillSection extends StatefulWidget {
  ClaimBillSection({super.key, required this.bill, required this.isClaimed});

  Bill bill;
  bool isClaimed;

  @override
  State<ClaimBillSection> createState() => _ClaimBillSectionState();
}

class _ClaimBillSectionState extends State<ClaimBillSection> {
  @override
  Widget build(BuildContext context) {
    final foodItemsData = Provider.of<FoodItems>(context);
    return Container(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: 186,
        decoration: BoxDecoration(
        color: const Color(0xff4B2900), borderRadius: BorderRadius.circular(43)),
        child: Column(
          children: [
            const SizedBox(height: 9),
            const Text(
              "CLAIM",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 149,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(43),
              ),
              padding: const EdgeInsets.only(top: 3),
              child: Container(
                width: double.infinity,
                height: 145,
                decoration: BoxDecoration(
                  color: const Color(0xff251400),
                  borderRadius: BorderRadius.circular(43),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 28),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 23),
                      child: widget.isClaimed
                          ? const BillClaimedWidget()
                          : openNewSlider(widget.bill, foodItemsData),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SlideAction openNewSlider(Bill bill, FoodItems foodItemsData) {
    return SlideAction(
      key: UniqueKey(),
      height: 64,
      sliderButtonIconPadding: 0,
      sliderRotate: false,
      borderRadius: 26,
      outerColor: const Color(0xffFF7200),
      sliderButtonIcon: Container(
        height: 50,
        width: 175,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: const Color(0xffFFC698),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              "CLAIM BILL",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(width: 15),
            Stack(
              children: [
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 7),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 15)
          ],
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
            color: Colors.black38,
          ),
          SizedBox(width: 25),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
            color: Colors.black38,
          ),
          SizedBox(width: 25),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
            color: Colors.black38,
          ),
          SizedBox(width: 25),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
            color: Colors.black38,
          ),
          SizedBox(width: 36),
        ],
      ),
      onSubmit: () {
        showCupertinoDialog(
            context: context,
            builder: (_) => CupertinoAlertDialog(
                  title: const Text("Claim the Bill?"),
                  content: const Text("You can't use the bill again"),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text("No"),
                      onPressed: () {
                        Navigator.of(context).pop();
                        print(UniqueKey());
                        // Navigator.of(context).pop();
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (BuildContext context) => BillScreen()));
                        setState(() {
                          // claimed++;
                        });
                        print(widget.isClaimed);
                        print(widget.bill.id);
                      },
                    ),
                    CupertinoDialogAction(
                      child: const Text("Yes"),
                      onPressed: () {
                        foodItemsData.claimBill(bill);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        setState(() {
                          widget.isClaimed = true;
                        });
                      },
                    ),
                  ],
                ));
        return null;
      },
    );
  }
}

class BillClaimedWidget extends StatefulWidget {
  const BillClaimedWidget({super.key});

  @override
  State<BillClaimedWidget> createState() => _BillClaimedWidgetState();
}

class _BillClaimedWidgetState extends State<BillClaimedWidget>
    with SingleTickerProviderStateMixin {
  late Animation animation;
  late AnimationController animationController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    animation = Tween(begin: 0, end: 1).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController.drive(CurveTween(curve: Curves.easeIn)),
      child: Container(
        height: 64,
        decoration: BoxDecoration(
            color: const Color(0xffFF7200).withOpacity(0.1),
            borderRadius: BorderRadius.circular(26)),
        child: const Center(
          child: Text(
            "Bill CLAIMED",
            style: TextStyle(
                color: Colors.white54,
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
