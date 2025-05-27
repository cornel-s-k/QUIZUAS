// lib/services/meal_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/meal.dart';

class MealService {
  static Future<List<Meal>> fetchMeals(String category) async {
    final url = 'https://www.themealdb.com/api/json/v1/1/filter.php?c=$category';
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    return (data['meals'] as List)
        .map((json) => Meal.fromJson(json))
        .toList();
  }

  static Future<String> fetchMealDetails(String idMeal) async {
    final url = 'https://www.themealdb.com/api/json/v1/1/lookup.php?i=$idMeal';
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    return data['meals'][0]['strInstructions'];
  }
}