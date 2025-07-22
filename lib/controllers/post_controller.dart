import 'package:get/get.dart';
import '../services/post_ai_service.dart';
import 'Contatori/touch_counter.dart';
import 'Contatori/scroll_counter.dart';

class GeneratedPost {
  final String text;
  final DateTime createdAt;

  GeneratedPost(this.text) : createdAt = DateTime.now();
}

class PostController extends GetxController {
  var posts = <GeneratedPost>[].obs;

  final List<int> scrollGoals = [50, 200, 500];
  final List<int> touchGoals = [20, 100, 200];
  int _nextScrollGoalIndex = 0;
  int _nextTouchGoalIndex = 0;

  Future<void> checkGoals() async {
    final scrolls = Get.find<ScrollCounter>().scrolls.value;
    final touches = Get.find<TouchCounter>().touches.value;

    bool created = false;
    if (_nextScrollGoalIndex < scrollGoals.length &&
        scrolls >= scrollGoals[_nextScrollGoalIndex]) {
      final text = await PostAIService.instance.generatePost(scrolls, touches);
      posts.add(GeneratedPost(text));
      _nextScrollGoalIndex++;
      created = true;
    }

    if (_nextTouchGoalIndex < touchGoals.length &&
        touches >= touchGoals[_nextTouchGoalIndex]) {
      if (!created) {
        final text = await PostAIService.instance.generatePost(scrolls, touches);
        posts.add(GeneratedPost(text));
      }
      _nextTouchGoalIndex++;
    }
  }
}
