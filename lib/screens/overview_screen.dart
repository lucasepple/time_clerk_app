import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:time_clerk_app/widgets/overview_chart.dart';
import 'package:time_clerk_app/widgets/overview_list.dart';

class OverviewScreen extends StatelessWidget {
  final String currentWeekday =
      DateFormat('EEEE').format(DateTime.now()).toString();
  final String currentDay = DateFormat('d').format(DateTime.now()).toString();

  String dayOfMonthWithSuffix(String day) {
    if (day == '1' || day == '21' || day == '31') {
      return '${day}st';
    } else if (day == '2' || day == '22') {
      return '${day}nd';
    } else if (day == '3' || day == '23') {
      return '${day}rd';
    } else {
      return '${day}th';
    }
  }

  Widget dateBuilder(BuildContext ctx) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            currentWeekday,
            style: Theme.of(ctx).textTheme.headline1,
          ),
          SizedBox(
            height: 1,
          ),
          Text(
            '${dayOfMonthWithSuffix(currentDay)} ${DateFormat('of MMMM y').format(DateTime.now()).toString()}',
            style: Theme.of(ctx).textTheme.headline6,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              dateBuilder(context),
              SizedBox(
                height: 33,
              ),
              OverviewChart(currentWeekday),
              SizedBox(
                height: 33,
              ),
              OverviewList(currentWeekday),
            ],
          ),
        ),
      ),
    );
  }
}
