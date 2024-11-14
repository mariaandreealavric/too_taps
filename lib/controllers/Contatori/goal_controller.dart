import 'package:get/get.dart';

class Goal {
  final String name;
  final double distance;
  final String description;
  final String coordinates;
  bool isAchieved;

  Goal({
    required this.name,
    required this.distance,
    required this.description,
    required this.coordinates,
    this.isAchieved = false,
  });
}

class GoalController extends GetxController {
  var totalDistance = 0.0.obs;
  var achievedGoals = <Goal>[].obs;

  final List<Goal> goals = [
    Goal(name: "Luna", distance: 0.384, description: "Satellite naturale della Terra", coordinates: "N/A"),
    Goal(name: "Marte", distance: 225.0, description: "Pianeta rosso", coordinates: "N/A"),
    Goal(name: "Giove", distance: 778.5, description: "Il gigante gassoso", coordinates: "N/A"),
    Goal(name: "Saturno", distance: 1433.5, description: "Pianeta con anelli", coordinates: "N/A"),
    Goal(name: "Plutone", distance: 5906.4, description: "Pianeta nano", coordinates: "N/A"),
    Goal(name: "Alpha Centauri", distance: 41253, description: "Sistema stellare più vicino", coordinates: "14h 39m 36s"),
  ];

  void addScrollDistance(double distance) {
    totalDistance.value += distance;
    checkGoals();
  }

  void checkGoals() {
    for (var goal in goals) {
      if (!goal.isAchieved && totalDistance.value >= goal.distance) {
        goal.isAchieved = true;
        achievedGoals.add(goal);
        Get.snackbar(
          "Obiettivo Raggiunto!",
          "Hai raggiunto ${goal.name} (${goal.distance} milioni di km)",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      }
    }
  }

  // Getter per ottenere l'ultimo obiettivo raggiunto, o `null` se non c'è alcun obiettivo
  Goal? get latestAchievedGoal => achievedGoals.isNotEmpty ? achievedGoals.last : null;
}
