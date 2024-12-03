import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'progress_indicator.dart';

class Recently extends StatelessWidget {
  final List title = [
    "Unit 5 - Project Managing",
    "Unit 8 - Figma Design",
    "Unit 3 - Flutter tutorials",
  ];

  final List colors = [Colors.blue, Colors.black, Colors.green];

  Recently({super.key});

  @override
  Widget build(BuildContext context) {
    var rng = math.Random.secure();
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage(
                  "assets/1.jpg",
                ),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 15.0,
                  offset: Offset(0.75, 0.95))
            ],
            color: Colors.grey),
        width: 85.0,
        height: 100,
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title[rng.nextInt(3)],
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
              fontSize: 18,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 14,
          ),
          const FAProgressBar(
            size: 4,
            currentValue: 30,
            progressColor: Colors.green,
            backgroundColor: Color(0xffF0F0F0),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "30% Completed",
              style: TextStyle(
                color: Colors.grey[500],
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            height: 2,
          ),
        ],
      ),
    );
  }
}