// lib/widgets/meal_item.dart
import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../screens/detail_screen.dart';

class MealItem extends StatelessWidget {
  final Meal meal;

  const MealItem({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DetailScreen(meal: meal),
        ),
      ),
      child: Hero(
        tag: meal.id,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GridTile(
            footer: Container(
              color: Colors.black54,
              child: Text(
                meal.name,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            child: Image.network(meal.imageUrl, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
