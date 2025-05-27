// lib/screens/detail_screen.dart
import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/meal_service.dart';

class DetailScreen extends StatelessWidget {
  final Meal meal;

  const DetailScreen({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Hero(
            tag: meal.id,
            child: Image.network(meal.imageUrl),
          ),
          Expanded(
            child: FutureBuilder<String>(
              future: MealService.fetchMealDetails(meal.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: \${snapshot.error}'));
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Text(
                        snapshot.data!,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
