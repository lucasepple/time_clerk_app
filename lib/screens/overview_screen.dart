import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
            DateFormat('EEEE').format(DateTime.now()).toString(),
            style: Theme.of(ctx).textTheme.headline1,
          ),
          SizedBox(
            height: 1,
          ),
          Text(
            DateFormat('MMMM d, y').format(DateTime.now()).toString(),
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
              OverviewChart(),
              OverviewList(),
            ],
          ),
        ),
      ),
    );
  }
}
