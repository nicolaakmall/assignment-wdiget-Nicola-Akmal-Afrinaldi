import 'package:flutter/material.dart';

class NavigationAppBar extends StatefulWidget {
  const NavigationAppBar({super.key});

  @override
  State<NavigationAppBar> createState() => _NavigationAppBarState();
}

class _NavigationAppBarState extends State<NavigationAppBar> {
  int index = 0;

  List<Widget> body = [
    Center(
      child: Text('Home'),
    ),
    Center(
      child: Text('Profile'),
    ),
    Center(
      child: Text('Settings'),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        drawer: Drawer(
          child: Center(
            child: Text('Ini Drawer'),
          ),
        ),
        appBar: AppBar(
          leading: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
          title: Text('Title Appbar'),
          actions: [
            Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ],
          bottom: TabBar(
            onTap: (value) {
              print('index appbar bottom : $value');
              setState(() {
                index = value;
              });
            },
            indicatorColor: Colors.black,
            tabs: [
              Tab(
                child: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
              ),
              Tab(
                child: Icon(
                  Icons.cloud,
                  color: Colors.white,
                ),
              ),
              Tab(
                child: Icon(
                  Icons.brightness_1,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        body: TabBarView(children: body),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (value) {
            print(value);
            setState(() {
              index = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(Icons.account_circle),
            ),
            BottomNavigationBarItem(
              label: 'Settings',
              icon: Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }
}
