import 'package:flutter/material.dart';

import 'package:time_clerk_app/models/activity.dart';
import 'package:time_clerk_app/models/time_tracker.dart';

// TEST IF ALL AXIS ALIGNMENTS ARE NECESSARY!

class StatsTile extends StatelessWidget {
  static const double tileHeight = 370;
  static const double chartHeight = 260;
  static const double maxHeightFactor = 0.8;
  // max height = highest label (-1/2 Font Size)
  final double pxPerMin = 0.4;
  Activity activity;
  final int year;
  String month;

  StatsTile({
    @required this.year,
    this.month,
    this.activity,
  });

  Widget chartBuilder(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            // reuse from home screen?
            Container(
              width: 330,
              color: Color(0xff707070),
              height: 0.75,
            ),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalChartLabelBuilder(context),
                SizedBox(width: 12),
                activity != null
                    ? Container(
                        height: chartHeight,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: activityChartBarBuilder(),
                        ),
                      )
                    : Container(
                        height: chartHeight,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: avgChartBarBuilder(context),
                        ),
                      ),
              ],
            ),
          ],
        ),
        Container(
          height: 50,
          width: double.infinity,
          // color: Colors.grey,
          child: activity != null
              ? Row(
                  // not very elegant!
                  children: [
                    SizedBox(width: 83),
                    Text(
                      '07.',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    SizedBox(width: 41),
                    Text(
                      '14.',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    SizedBox(width: 41),
                    Text(
                      '21.',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    SizedBox(width: 41),
                    Text(
                      '28.',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                )
              : null,
        ),
      ],
    );
  }

  Widget verticalChartLabelBuilder(BuildContext context) {
    // make variable
    int maxValue = 480;
    int numberLabels = (maxValue ~/ 180) + 1;
    List<Widget> labels = [];
    for (int i = numberLabels; i > 0; i--) {
      // labels.add(Text(
      //   '${3 * i}h',
      //   style: Theme.of(context).textTheme.bodyText1,
      // ));
      // // subtract half font size
      // labels.add(
      //   SizedBox(
      //     height: (pxPerMin * 180) - 9,
      //   ),
      // );
      labels.add(Expanded(
        child: Container(
          child: Text(
            '${3 * i}h',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      ));
    }
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 2,
      ),
      height: chartHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: labels,
      ),
    );
  }

  List<Widget> avgChartBarBuilder(BuildContext context) {
    // combine with home screen chart Builder?
    List<Widget> bars = [];
    for (Activity avgActivity in Activity.values) {
      bars.add(
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            if (month != null
                ? TimeTracker().monthlyAvg(year, month, avgActivity) != 0
                : TimeTracker().yearlyAvg(year, avgActivity) != 0)
              RotatedBox(
                quarterTurns: -1,
                child: Text(
                  ActivityProperties.strings[avgActivity],
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            SizedBox(height: 8),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 7),
              height: month != null
                  ? TimeTracker().monthlyAvg(year, month, avgActivity) *
                      pxPerMin
                  : TimeTracker().yearlyAvg(year, avgActivity) * pxPerMin,
              width: 34,
              color: ActivityProperties.colors[avgActivity],
            )
          ],
        ),
      );
    }
    return bars;
  }

  List<Widget> activityChartBarBuilder() {
    List<int> data = [];
    List<Widget> bars = [];
    if (TimeTracker().storedData[activity][year] != null) {
      if (month == null) {
        TimeTracker().storedData[activity][year].forEach(
          (month, daysMap) {
            daysMap.forEach(
              (day, minutes) {
                data.add(minutes);
              },
            );
          },
        );
      } else {
        TimeTracker().storedData[activity][year][month].forEach(
          (day, minutes) {
            data.add(minutes);
          },
        );
      }
    }
    for (int i = 0; i < data.length; i++) {
      bars.add(Container(
        margin: EdgeInsets.symmetric(horizontal: 1.5),
        color: ActivityProperties.colors[activity],
        height: data[i] * pxPerMin,
        width: 6.5,
      ));
    }
    return bars;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey,
      padding: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      height: tileHeight,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            activity == null ? 'Average' : ActivityProperties.strings[activity],
            style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 24),
          ),
          chartBuilder(context),
        ],
      ),
    );
  }
}
