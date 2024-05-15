import 'package:anime_search/pages/home_page.dart';
import 'package:anime_search/pages/search_page.dart';
import 'package:anime_search/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    // Set status bar color
    statusBarColor: Colors.transparent,
    // Set status bar icon brightness
    statusBarIconBrightness: Brightness.light,
    // Set system navigation bar color
    systemNavigationBarColor: Colors.transparent,
    // Set system navigation bar icon brightness
    systemNavigationBarIconBrightness: Brightness.light,
  ));
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
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //body of the app
    return Scaffold(
      backgroundColor: primaryColor,
      body: PageView(
        controller: _pageController,
        children: const <Widget>[
          HomePage(),
          SearchPage(),
        ],
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),

      //bottom navigation bar for anime app
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
        currentIndex: _currentIndex, // Add this line
        backgroundColor: secondaryColor,
        elevation: 0,

        selectedIconTheme:
            const IconThemeData(size: 30, color: primaryIconColor),
        unselectedIconTheme:
            const IconThemeData(size: 30, color: secondaryIconColor),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          _pageController.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
