import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';

import 'package:time_clerk_app/models/activity.dart';
import 'package:time_clerk_app/widgets/stats_tile.dart';
import 'package:time_clerk_app/widgets/picker.dart';

enum StatsType {
  month,
  year,
}

class StatsScreen extends StatefulWidget {
  final StatsType statsType;

  StatsScreen(this.statsType);

  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  int _currentIndex = 0;
  int selectedYear = 2021;
  String selcetedMonth = 'February';

  List<StatsTile> _statsTileList() {
    List<StatsTile> list = [];
    for (Activity activity in Activity.values) {
      list.add(StatsTile(
        year: selectedYear,
        month: selcetedMonth,
        activity: activity,
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 35,
            ),
            Container(
              padding: EdgeInsets.only(left: 25),
              child: Picker('Thursday', (String dummy) {}),
              width: double.infinity,
            ),
            SizedBox(
              height: 20,
            ),
            // AverageStatsTile(),
            CarouselSlider(
              items: <Widget>[
                StatsTile(
                  year: selectedYear,
                  month: selcetedMonth,
                ),
                ..._statsTileList(),
              ],
              options: CarouselOptions(
                  height: 420, // same as tile height
                  viewportFraction: 1,
                  onPageChanged: (index, _) {
                    setState(() {
                      _currentIndex = index;
                    });
                  }),
            ),
            SizedBox(
              height: 40,
            ),
            DotsIndicator(
              dotsCount: 7,
              position: _currentIndex.toDouble(),
              decorator: DotsDecorator(
                size: Size.square(9),
                activeSize: Size.square(12),
                shape: CircleBorder(
                  side: BorderSide(
                    width: 0.5,
                    color: Colors.black,
                  ),
                ),
                color: Theme.of(context).primaryColor,
                activeColor: Color(0xff5d5d5d),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
