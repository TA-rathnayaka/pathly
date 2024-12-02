import 'package:flutter/material.dart';
import 'package:pathly/views/components/tech_card.dart';

class TechPathList extends StatelessWidget {
  final String? groupTitle;
  final List<TechCard> techCards;
  final EdgeInsets? margin;
  final Color? backgroundColor;

  const TechPathList({super.key, 
    this.groupTitle,
    required this.techCards,
    this.margin,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (groupTitle != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                groupTitle!,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          Container(
            decoration: BoxDecoration(
              color: backgroundColor ?? Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: techCards.length,
              itemBuilder: (context, index) => techCards[index],
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
            ),
          ),
        ],
      ),
    );
  }
}