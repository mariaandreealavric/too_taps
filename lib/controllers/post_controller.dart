import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/post_ai_service.dart';
import 'Contatori/touch_counter.dart';
import 'Contatori/scroll_counter.dart';
import 'user_controller.dart';
import '../services/post_ai_service.dart';
import 'Contatori/touch_counter.dart';
import 'Contatori/scroll_counter.dart';

class GeneratedPost {
  final String text;
  final DateTime createdAt;

  GeneratedPost(this.text, {DateTime? createdAt})
      : createdAt = createdAt ?? DateTime.now();
}

class PostController extends GetxController {
  final FirebaseFirestore _firestore;

  PostController({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;


  GeneratedPost(this.text) : createdAt = DateTime.now();
}

class PostController extends GetxController {
  var posts = <GeneratedPost>[].obs;

  final List<int> scrollGoals = [50, 200, 500];
  final List<int> touchGoals = [20, 100, 200];
  int _nextScrollGoalIndex = 0;
  int _nextTouchGoalIndex = 0;

  @override
  void onInit() {
    super.onInit();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    final uid = Get.find<UserController>().profile.value?.uid;
    if (uid == null) return;
    final snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .get();
    posts.value = snapshot.docs
        .map((d) => GeneratedPost(
              d.data()['text'] ?? '',
              createdAt:
                  (d.data()['createdAt'] as Timestamp?)?.toDate(),
            ))
        .toList();
  }

  Future<void> _savePost(String uid, String text) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('posts')
        .add({'text': text, 'createdAt': Timestamp.now()});
  }

  Future<void> checkGoals() async {
    final scrolls = Get.find<ScrollCounter>().scrolls.value;
    final touches = Get.find<TouchCounter>().touches.value;

    bool created = false;
    if (_nextScrollGoalIndex < scrollGoals.length &&
        scrolls >= scrollGoals[_nextScrollGoalIndex]) {
      final text = await PostAIService.instance.generatePost(scrolls, touches);
      posts.add(GeneratedPost(text));
      final uid = Get.find<UserController>().profile.value?.uid;
      if (uid != null) {
        await _savePost(uid, text);
      }

      _nextScrollGoalIndex++;
      created = true;
    }

    if (_nextTouchGoalIndex < touchGoals.length &&
        touches >= touchGoals[_nextTouchGoalIndex]) {
      if (!created) {
        final text = await PostAIService.instance.generatePost(scrolls, touches);
        posts.add(GeneratedPost(text));
        final uid = Get.find<UserController>().profile.value?.uid;
        if (uid != null) {
          await _savePost(uid, text);
        }

      }
      _nextTouchGoalIndex++;
    }
  }
}
