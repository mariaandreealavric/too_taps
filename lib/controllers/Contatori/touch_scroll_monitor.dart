import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Importa GetX

class TouchScrollMonitor extends StatefulWidget {
  const TouchScrollMonitor({super.key});

  @override
  _TouchScrollMonitorState createState() => _TouchScrollMonitorState();
}

class _TouchScrollMonitorState extends State<TouchScrollMonitor> {
  var touchCount = 0.obs;
  var scrollCount = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Touch and Scroll Counter'),
      ),
      body: GestureDetector(
        onTap: () {
          touchCount++;
        },
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollStartNotification ||
                scrollNotification is ScrollUpdateNotification) {
              scrollCount++;
            }
            return true;
          },
          child: Obx(() {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Touches: ${touchCount.value}',
                  style: const TextStyle(fontSize: 24),
                ),
                Text(
                  'Scrolls: ${scrollCount.value}',
                  style: const TextStyle(fontSize: 24),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 50,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('Item $index'),
                      );
                    },
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
