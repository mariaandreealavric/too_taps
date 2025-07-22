import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:too_taps/Widgets/pod%20widgets/pod_appbar.dart';
import 'package:too_taps/Widgets/pod%20widgets/recap.dart';
import 'package:too_taps/Widgets/pod%20widgets/reward_widget.dart';
import 'package:too_taps/Widgets/pod%20widgets/suggested_profile_widget.dart';
import '../Widgets/Navigazione/navigazione.dart';
import '../controllers/Contatori/goal_controller.dart';
import '../controllers/Contatori/scroll_counter.dart';
import '../controllers/Contatori/touch_counter.dart';
import '../controllers/post_controller.dart';
import '../Widgets/post_widgets/generated_post_widget.dart';
import '../controllers/user_controller.dart';
import '../controllers/theme_controller.dart';
import '../models/user_model.dart';

class PodPage extends StatelessWidget {
  const PodPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final profileController = Get.find<UserController>();
    final scrollCounter = Get.find<ScrollCounter>();
    final touchCounter = Get.find<TouchCounter>();
    final goalController = Get.find<GoalController>();
    final UserController userController = Get.find<UserController>(); // Recupera l'istanza esistente di UserController
    final postController = Get.find<PostController>();

    // Controlla subito se ci sono nuovi traguardi
    postController.checkGoals();



    return GestureDetector(
      onTap: () {
        touchCounter.incrementTouches();
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollStartNotification ||
              scrollNotification is ScrollUpdateNotification ||
              scrollNotification is ScrollEndNotification) {
            scrollCounter.incrementScrolls();
          }
          return true;
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          extendBodyBehindAppBar: true,
          body: Stack(
            children: [
              Container(
                decoration: themeController.boxDecoration,
              ),
              Positioned.fill(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Obx(() {
                        if (userController.profile.value == null) {
                          return const SizedBox.shrink(); // Nasconde l'AppBar finché il profilo non è caricato
                        }
                        return CustomPodAppBar(profile: userController.profile.value!);
                      }),
                      Obx(() {
                        final latestGoal = goalController.latestAchievedGoal;
                        if (latestGoal != null) {
                          return RewardWidget(goal: latestGoal);
                        } else {
                          return SizedBox.shrink(); // Se non c'è un goal, non mostra nulla
                        }
                      }),
                      FutureBuilder<UserModel?>(
                        future: userController.getRandomProfile(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasData && snapshot.data != null) {
                            return SuggestedProfileWidget(profile: snapshot.data!);
                          } else {
                            return const SizedBox.shrink(); // Se non ci sono profili, non mostra nulla
                          }
                        },
                      ),
                      RecapWidget(),
                      Obx(() {
                        return Column(
                          children: postController.posts
                              .map((p) => GeneratedPostWidget(post: p))
                              .toList(),
                        );
                      }),
                      FutureBuilder<UserModel?>(
                        future: userController.getRandomProfile(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasData && snapshot.data != null) {
                            return SuggestedProfileWidget(profile: snapshot.data!);
                          } else {
                            return const SizedBox.shrink(); // Se non ci sono profili, non mostra nulla
                          }
                        },
                      ),


                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Obx(() {
                  if (profileController.profile.value == null) {
                    return CircularProgressIndicator(); // Mostra un indicatore di caricamento finché il profilo non è disponibile
                  }
                  return Navigation(profile: profileController.profile.value!);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
