import 'package:flutter/material.dart';

import 'package:time_clerk_app/screens/overview_screen.dart';
import 'package:time_clerk_app/screens/profile_screen.dart';
import 'package:time_clerk_app/screens/stats_screen.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedIndex = 0;
  double _fontSize = 23;
  bool _statsScreen = false;
  final List<Widget> _pages = <Widget>[
    OverviewScreen(),
    TabBarView(children: <Widget>[
      StatsScreen(StatsType.month),
      StatsScreen(StatsType.year),
    ]),
    ProfileScreen(),
  ];

  void _selectPage(int index) {
    setState(() {
      index == 1 ? _statsScreen = true : _statsScreen = false;
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _statsScreen ? 2 : 0,
      child: Scaffold(
        appBar: _statsScreen == true
            ? PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: SafeArea(
                  child: Container(
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Positioned(
                          // indicator height
                          bottom: 2,
                          child: Container(
                            // why not double.infinity possible? Make device width
                            width: 500,
                            height: 0.5,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          height: 50,
                          child: TabBar(
                            tabs: [
                              Text('Month'),
                              Text('Year'),
                            ],
                            labelStyle: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontWeight: FontWeight.w600),
                            unselectedLabelStyle:
                                Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : null,
        body: SafeArea(
          child: _pages.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Stack(
          children: [
            Container(
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black54,
                      blurRadius: 30,
                      offset: Offset(0, 22)),
                ],
              ),
            ),
            Container(
              height: 55,
              padding: EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: BottomNavigationBar(
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: _selectedIndex == 0
                        ? Text(
                            '2',
                            style: TextStyle(
                                fontSize: _fontSize,
                                fontFamily: 'Time-Clerk-Icons'),
                          )
                        : Text(
                            '1',
                            style: TextStyle(
                                fontSize: _fontSize,
                                fontFamily: 'Time-Clerk-Icons'),
                          ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: _selectedIndex == 1
                        ? Text(
                            '4',
                            style: TextStyle(
                                fontSize: _fontSize,
                                fontFamily: 'Time-Clerk-Icons'),
                          )
                        : Text(
                            '3',
                            style: TextStyle(
                                fontSize: _fontSize,
                                fontFamily: 'Time-Clerk-Icons'),
                          ),
                    label: 'Stats',
                  ),
                  BottomNavigationBarItem(
                    icon: _selectedIndex == 2
                        ? Text(
                            '6',
                            style: TextStyle(
                                fontSize: _fontSize,
                                fontFamily: 'Time-Clerk-Icons'),
                          )
                        : Text(
                            '5',
                            style: TextStyle(
                                fontSize: _fontSize,
                                fontFamily: 'Time-Clerk-Icons'),
                          ),
                    label: 'Profile',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.black,
                iconSize: 30,
                elevation: 0,
                onTap: _selectPage,
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
