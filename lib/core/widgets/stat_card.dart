import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StatCard
    extends StatelessWidget {

  final IconData icon;
  final String title;
  final String value;

  const StatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding:
              const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon,size: 28),

              const SizedBox(
                height: 10,
              ),

              Text(
                value,
                style:
                    const TextStyle(
                  fontSize: 22,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 6,
              ),

              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}