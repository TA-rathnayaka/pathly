import 'package:flutter/material.dart';
import 'package:pathly/views/components/stage_card.dart';

class StageCardList extends StatelessWidget {
  final String? groupTitle;
  final List<StageCard> stageCards;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final int crossAxisCount; // Number of cards per row
  final double spacing; // Spacing between grid items

  const StageCardList({
    super.key,
    this.groupTitle,
    required this.stageCards,
    this.margin,
    this.backgroundColor,
    this.crossAxisCount = 2, // Default to 2 cards per row
    this.spacing = 5.0, // Default spacing
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
            child: GridView.builder(
              itemCount: stageCards.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
                childAspectRatio: 0.8, // Adjust based on your card's height
              ),
              itemBuilder: (context, index) => stageCards[index],
              shrinkWrap: true, // Makes the grid fit its content
              padding: EdgeInsets.all(spacing),
              physics: const NeverScrollableScrollPhysics(), // Prevents scrolling within the grid
            ),
          ),
        ],
      ),
    );
  }
}