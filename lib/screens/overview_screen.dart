import 'package:flutter/material.dart';

import 'package:time_clerk_app/models/date.dart';
import 'package:time_clerk_app/widgets/overview_chart.dart';
import 'package:time_clerk_app/widgets/overview_list.dart';

class OverviewScreen extends StatelessWidget {
  Widget dateBuilder(BuildContext ctx) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            Date().currentDay,
            style: Theme.of(ctx).textTheme.headline1,
          ),
          SizedBox(
            height: 1,
          ),
          Text(
            Date().currentDateString,
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
        child: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              dateBuilder(context),
              OverviewChart(),
              OverviewList(),
            ],
          ),
        ),
      ),
    );
  }
}
