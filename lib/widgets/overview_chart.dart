import 'package:flutter/material.dart';

class OverviewChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Divider(
            color: Color(0xff707070),
            indent: 5,
            endIndent: 5,
          ),
          Container(
            width: double.infinity,
            child: Row(
              children: <Widget>[],
            ),
          )
        ],
      ),
    );
  }
}
