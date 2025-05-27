// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/meal_service.dart';
import '../widgets/meal_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late Future<List<Meal>> _meals;

  static const List<String> categories = ['Seafood', 'Dessert', 'Vegan'];

  @override
  void initState() {
    super.initState();
    _meals = MealService.fetchMeals(categories[_selectedIndex]);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _meals = MealService.fetchMeals(categories[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TheMealDB')),
      body: FutureBuilder<List<Meal>>(
        future: _meals,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: \${snapshot.error}'));
          } else {
            final meals = snapshot.data!;
            return GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                return MealItem(meal: meal);
              },
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: 'Seafood'),
          BottomNavigationBarItem(icon: Icon(Icons.cake), label: 'Dessert'),
          BottomNavigationBarItem(icon: Icon(Icons.eco), label: 'Vegan'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        onTap: _onItemTapped,
      ),
    );
  }
}
