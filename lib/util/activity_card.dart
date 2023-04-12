// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final String activityImagePath;
  final String activityName;
  final String Keterangan;

  ActivityCard(
      {required this.activityImagePath,
      required this.activityName,
      required this.Keterangan});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.cyan[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // picture of doctor
            Image.asset(
              activityImagePath,
              height: 100,
            ),

            // SizedBox( height: 10,
            // ),

            // // rating out of 5
            // Row(children: [
            //   Icon(Icons.star,
            //   color: Colors.yellow[600],
            //   ),
            //   Text(rating,
            //   style: TextStyle(fontWeight: FontWeight.bold),),
            // ],
            // ),

            SizedBox(
              height: 10,
            ),
            // doctor name
            Text(
              activityName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              height: 5,
            ),
            // doctor title
            Text(Keterangan + '7 y.e.')
          ],
        ),
      ),
    );
  }
}
