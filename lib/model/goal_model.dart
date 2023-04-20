class GoalModel {
  final String name;
  final DateTime dueDate;
  final double progress;

  GoalModel({
    required this.name,
    required this.dueDate,
    required this.progress,
  });
}

// test model
final List<GoalModel> GoalList = [
  GoalModel(name: "Goal 1", dueDate: DateTime(2023,04,20), progress: 90),
  GoalModel(name: "Goal 2", dueDate: DateTime(2023,05, 05), progress: 24),
  GoalModel(name: "Goal 3", dueDate: DateTime(2023,03,28), progress: 95),
  GoalModel(name: "Goal 4", dueDate: DateTime(2023,04,26), progress: 80),
];