import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pintas_app/ui/activity/activity_page.dart';
import 'package:pintas_app/ui/home/home_page.dart';
import 'package:pintas_app/ui/search/search_page.dart';
import 'package:pintas_app/ui/profile/profile_page_view.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentIndex = 0;
  final screens = [
    HomePage(),
    SearchPage(),
    ActivityPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.15),
                spreadRadius: 0,
                blurRadius: 7),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (value) => setState(() => currentIndex = value),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: HexColor("#7868E6"),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_books_outlined),
                label: "Activity",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_outlined),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
