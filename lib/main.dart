import 'package:digital_business_cards/database/CardProvider.dart';
import 'package:digital_business_cards/screens/EditUserCard.dart';
import 'package:digital_business_cards/screens/SavedCards.dart';
import 'package:digital_business_cards/screens/ScanCard.dart';
import 'package:digital_business_cards/screens/UserCard.dart';
import 'package:digital_business_cards/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:digital_business_cards/database/DatabaseHelper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        fontFamily: 'Comfortaa',
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    openAppDatabase();
    initializePages();
  }

  void openAppDatabase() async {
    final Database db = await DatabaseHelper.database();
  }

  void initializePages() {
    _pages = [
      EditUserCard(),
      UserCard(),
      ScanCard(),
      SavedCards(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    /**
     * Change Notifier Provider is based on the code from Flutter Documentation: https://docs.flutter.dev/data-and-backend/state-mgmt/simple
     */
    return ChangeNotifierProvider(
      create: (_) => CardProvider(),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: oppositePrimaryColor,
          activeColor: white, // Set the active color
          inactiveColor: grey, // Set the inactive color
          iconSize: 35,
          height: 70,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.pencil),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.creditcard),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.photo_camera),
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.square_list),
            ),
          ],
        ),
        tabBuilder: (context, index) {
          return CupertinoTabView(
            builder: (context) {
              return _pages[index];
            },
          );
        },
      ),
    );
  }
}
