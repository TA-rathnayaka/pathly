import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StepWidget extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final double progress;
  final bool isLocked;
  final VoidCallback? onTap;

  StepWidget({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.progress,
    this.isLocked = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isLocked ? null : onTap,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          icon,
                          color: color,
                          size: 28,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  ),
                  SizedBox(height: 16),
                  CircularPercentIndicator(
                    radius: 40,
                    lineWidth: 6,
                    percent: progress,
                    center: Text(
                      '${(progress * 100).toStringAsFixed(0)}%',
                      style: TextStyle(color: Colors.white),
                    ),
                    progressColor: color,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}