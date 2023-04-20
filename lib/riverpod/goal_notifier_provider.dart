import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/goal_model.dart';

final goalListProvider =
    StateNotifierProvider<GoalListNotifier, List<GoalModel>>(
  (ref) => GoalListNotifier(),
);

class GoalListNotifier extends StateNotifier<List<GoalModel>> {
  GoalListNotifier() : super(GoalList);
}

