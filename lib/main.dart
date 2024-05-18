import 'package:anime_search/pages/home_page.dart';
import 'package:anime_search/pages/search_page.dart';
import 'package:anime_search/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

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

// MyApp is the root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime Search',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.raleway().fontFamily,
      ),
      home: const MyHomePage(),
    );
  }
}

// MyHomePage is the main page of the application
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// _MyHomePageState is the state associated with MyHomePage
class _MyHomePageState extends State<MyHomePage> {
  // _pageController controls the page view
  final PageController _pageController = PageController();
  // _currentIndex keeps track of the current page
  int _currentIndex = 0;

  @override
  void dispose() {
    // Dispose of the page controller when the widget is removed from the widget tree
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // The body of the app is a PageView with HomePage and SearchPage
    return Scaffold(
      backgroundColor: primaryColor,
      body: PageView(
        controller: _pageController,
        children: const <Widget>[
          HomePage(),
          SearchPage(),
        ],
        onPageChanged: (index) {
          // Update _currentIndex when the page changes
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      // The bottom navigation bar allows the user to switch between HomePage and SearchPage
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home_2, size: 25),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.search_normal4, size: 25),
            label: 'Search',
          ),
        ],
        currentIndex: _currentIndex,
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
          // Switch pages when an item is tapped
          _pageController.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
