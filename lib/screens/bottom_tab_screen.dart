import 'package:flutter/material.dart';

class BottomTabScreen extends StatefulWidget {
  @override
  _BottomTabScreenState createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<BottomTabScreen> {
  int _selectedIndex = 0;
  double _fontSize = 25;
  static const List<Widget> _screens = <Widget>[
    Text(
      'Overview',
    ),
    Text(
      'Stats',
    ),
    Text(
      'Profile',
    ),
  ];

  void _onIconTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Stack(
        children: [
          Container(
            height: 60,
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
            height: 60,
            padding: EdgeInsets.symmetric(
              horizontal: 25,
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
              onTap: _onIconTapped,
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
