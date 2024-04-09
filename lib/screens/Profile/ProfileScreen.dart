import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:paperless_canteen/providers/foodItem.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController rollNumberController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    nameController.text = "S Akash";
    rollNumberController.text = "22Z255";
    phoneController.text = "+91 9943803882";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              const ProfileWatermark(),
              Container(
                child: ListView(
                  children: [
                    Column(
                      children: [
                        const CustomAppBar(),
                        const SizedBox(height: 20),
                        const ProfilePicture(),
                        const SizedBox(height: 32),
                        const Name(),
                        const SizedBox(height: 5),
                        const Text(
                          "Student",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black38,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        const BalanceWidget(),
                        const SizedBox(height: 50),
                        const Row(
                          children: [
                            SizedBox(width: 43),
                            Text(
                              "Details",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ReadOnlyTextField(
                          controller: nameController,
                          label: "Name",
                        ),
                        const SizedBox(height: 30),
                        ReadOnlyTextField(
                          controller: rollNumberController,
                          label: "Roll Number",
                        ),
                        const SizedBox(height: 30),
                        EditableTextField(
                          controller: phoneController,
                          label: "Phone Number",
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class ReadOnlyTextField extends StatelessWidget {
  const ReadOnlyTextField({
    Key? key,
    required this.controller,
    required this.label,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 43),
      child: TextField(
        readOnly: true,
        controller: controller,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(19),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(19),
          ),
        ),
      ),
    );
  }
}

class EditableTextField extends StatelessWidget {
  const EditableTextField({
    Key? key,
    required this.controller,
    required this.label,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 43),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          suffixText: "Tap to edit",
          suffixStyle: const TextStyle(
            color: Colors.black45,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(19),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(19),
          ),
        ),
      ),
    );
  }
}

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 43),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xffFFC15B),
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: const Color(0xff595959),
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Balance in ID Card",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xff4B2900),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Text(
              "₹ 100",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

class Name extends StatelessWidget {
  const Name({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xffFFC698),
        borderRadius: BorderRadius.circular(18.5),
      ),
      child: const Text(
        "Rahul",
        style: TextStyle(
            fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xffEDEDED),
          width: 4,
        ),
        borderRadius:
            BorderRadius.circular(MediaQuery.of(context).size.width * 0.11),
      ),
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(MediaQuery.of(context).size.width * 0.1),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.35,
          height: MediaQuery.of(context).size.width * 0.35,
          child: Image.asset(
            "assets/images/profilePic.jpeg",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final foodItemsData = Provider.of<FoodItems>(context);
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
              size: 30,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                const storage = FlutterSecureStorage();
                storage.delete(key: "loggedInUserDisplayName");
                storage.delete(key: "loggedInUserPhotoUrl");
                storage.delete(key: "loggedInUserServerAuthCode");
                storage.delete(key: "loggedInUserEmail");
                storage.delete(key: "loggedInUserId");
                while (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }

                Navigator.pushReplacementNamed(context, "/home");
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              child: const Text("Log out",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ))),
        ],
      ),
    );
  }
}

class ProfileWatermark extends StatelessWidget {
  const ProfileWatermark({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 80),
      alignment: Alignment.topCenter,
      child: GradientText(
        'PROFILE',
        style: const TextStyle(
            fontSize: 87, fontWeight: FontWeight.bold, fontFamily: "Cocogoose"),
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 149, 149, 149),
            // Colors.black,
            const Color(0xffFFFFFF).withOpacity(0),
          ],
          transform: const GradientRotation(3.14 / 2),
        ),
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {super.key, 
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
