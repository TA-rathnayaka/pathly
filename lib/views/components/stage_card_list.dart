import 'package:flutter/material.dart';
import 'package:pathly/views/components/stage_card.dart';

class StageCardList extends StatelessWidget {
  final String? groupTitle;
  final List<StageCard> stageCards;
  final EdgeInsets? margin;
  final Color? backgroundColor;

  const StageCardList({super.key, 
    this.groupTitle,
    required this.stageCards,
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
              itemCount: stageCards.length,
              itemBuilder: (context, index) => stageCards[index],
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