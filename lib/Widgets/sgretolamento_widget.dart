import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/statue_controller.dart';
import 'unreal_widget.dart';

class SgretolamentoWidget extends StatefulWidget {
  const SgretolamentoWidget({super.key});

  @override
  SgretolamentoWidgetState createState() => SgretolamentoWidgetState();
}

class SgretolamentoWidgetState extends State<SgretolamentoWidget> {
  late final StatueController _statueController;

  @override
  void initState() {
    super.initState();
    _statueController = Get.isRegistered<StatueController>()
        ? Get.find<StatueController>()
        : Get.put(StatueController());
  }

  void _handleTap(TapUpDetails details) {
    _statueController.registerTap(details.localPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              const DecoratedBox(
                decoration: BoxDecoration(color: Colors.black),
                child: UnrealWidget(),
              ),
              Positioned.fill(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTapUp: _handleTap,
                ),
              ),
              Positioned(
                top: 20,
                left: 20,
                right: 20,
                child: Obx(() {
                  final destroyed = _statueController.isDestroyed.value;
                  final label = _statueController.statusLabel.value;
                  return _StatusBanner(
                    message: label,
                    destroyed: destroyed,
                  );
                }),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Obx(() {
          final taps = _statueController.tapCount.value;
          return Text(
            'Tocchi registrati: $taps',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          );
        }),
        const SizedBox(height: 12),
        Obx(() {
          final ready = _statueController.engineReady.value;
          final destroyed = _statueController.isDestroyed.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: ready
                ? ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          destroyed ? Colors.redAccent : Colors.white,
                      foregroundColor:
                          destroyed ? Colors.white : Colors.black,
                    ),
                    onPressed: _statueController.resetStatue,
                    icon: const Icon(Icons.restart_alt),
                    label: Text(
                        destroyed ? 'Rigenera statua' : 'Reset statua'),
                  )
                : const CircularProgressIndicator(),
          );
        }),
      ],
    );
  }
}

class _StatusBanner extends StatelessWidget {
  final String message;
  final bool destroyed;

  const _StatusBanner({
    required this.message,
    required this.destroyed,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: destroyed ? Colors.redAccent.withOpacity(0.8) : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          message,
          style: TextStyle(
            color: destroyed ? Colors.white : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
