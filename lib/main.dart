import 'package:flutter/material.dart';
import 'package:paperless_canteen/screens/Bill/BillHome.dart';
import 'package:paperless_canteen/screens/Bill/ViewBillsScreen.dart';
import 'package:paperless_canteen/screens/ExtraScreens/GoogleAuth.dart';
import 'package:paperless_canteen/screens/ExtraScreens/QRCodeScanner.dart';
import 'package:paperless_canteen/screens/Home/HomeScreen.dart';
import 'package:paperless_canteen/screens/Profile/ProfileScreen.dart';
import 'package:paperless_canteen/screens/Panaroma/panaromaScreen.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'screens/ExtraScreens/QRGenerator.dart';
import './providers/foodItem.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => FoodItems(),
      child: MaterialApp(
        title: 'Paperless Canteen',
        theme: ThemeData(
          fontFamily: "Google Sans",
          primarySwatch: Colors.orange,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.orange),
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          "/qrcode-generator": (context) => const QRGenerator(),
          "/google-auth": (context) => const GoogleAuthScreen(),
          // "/login": (context) => LoginScreen(),
          "/home": (context) => const HomeScreen(),
          "/view-bills": (context) => const ViewBillsScreen(),
          "/profile": (context) => const ProfileScreen(),
          "/panaroma": (context) => const PanaromaScreen(),
        },
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Paperless Canteen")),
      body: const QRGenerator(),
      drawer: const DrawerWidget(),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.insert_drive_file_rounded,
                  color: Colors.white.withOpacity(0.8),
                  size: 30,
                ),
                const SizedBox(width: 10),
                const Text(
                  "Paperless Canteen",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.gpp_good_rounded),
                SizedBox(width: 10),
                Text("Login"),
              ],
            ),
            onTap: () {
              // Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.home_rounded),
                SizedBox(width: 10),
                Text("Home"),
              ],
            ),
            onTap: () {
              // Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
          ),
          // ListTile(
          //   title: Row(
          //     children: [
          //       Icon(Icons.insert_drive_file_rounded),
          //       SizedBox(width: 10),
          //       Text("Bill"),
          //     ],
          //   ),
          //   onTap: () {
          //     // Navigator.pop(context);
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => BillScreen()));
          //   },
          // ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.person_rounded),
                SizedBox(width: 10),
                Text("Profile"),
              ],
            ),
            onTap: () {
              // Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()));
            },
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.insert_drive_file_rounded),
                SizedBox(width: 10),
                Text("Bill Home"),
              ],
            ),
            onTap: () {
              // Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const BillHomeScreen()));
            },
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.qr_code_rounded),
                SizedBox(width: 10),
                Text("QR Code Generator"),
              ],
            ),
            onTap: () {
              // Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const QRGenerator()));
            },
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.qr_code_scanner_rounded),
                SizedBox(width: 10),
                Text("QR Code Scanner"),
              ],
            ),
            onTap: () {
              // Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => QRCodeScanner()));
            },
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.gpp_good_rounded),
                SizedBox(width: 10),
                Text("Google Auth"),
              ],
            ),
            onTap: () {
              // Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const GoogleAuthScreen()));
            },
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.panorama_fish_eye_rounded),
                SizedBox(width: 10),
                Text("Panaroma"),
              ],
            ),
            onTap: () {
              // Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PanaromaScreen()));
            },
          ),
        ],
      ),
    );
  }
}
