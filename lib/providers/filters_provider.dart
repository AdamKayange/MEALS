import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';

enum Filters {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filters, bool>> {
  FiltersNotifier()
      : super({
          Filters.glutenFree: false,
          Filters.lactoseFree: false,
          Filters.vegetarian: false,
          Filters.vegan: false,
        });

  void setFilters(Map<Filters, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filters filters, bool isActive) {
    state = {
      ...state,
      filters: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filters, bool>>(
  (ref) => FiltersNotifier(),
);

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealProvider);
  final activeScreen = ref.read(filtersProvider);
  return meals.where((meal) {
    if (activeScreen[Filters.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeScreen[Filters.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeScreen[Filters.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeScreen[Filters.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
